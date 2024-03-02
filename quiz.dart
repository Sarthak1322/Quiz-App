import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jnanamarga_quiz/completed.dart';
import 'package:jnanamarga_quiz/options.dart';
import 'package:http/http.dart' as http;

const Color primaryColor = Color(0xFFFC8A02);

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List responseData = [];
  int number = 0;
  late Timer _timer;
  int totalQuizTime = 600;
  int _secondRemaining = 30;

  List<String> shuffledOptions = ["Option A", "Option B", "Option C", "Option D"];


  // Function for POST API
  Future api() async {
    final Map<String, dynamic> requestBody = {
      "url": "https://ncert.nic.in/textbook/pdf/kebo116.pdf", // replace your url
      "num_questions": 5,
      "mode": "interval",
      "page_number": 6,
      "interval": 2
    };

    final response = await http.post(
      Uri.parse('https://nptel.jnanamarga.in/q_generator'), // replace your base url
      headers: <String, String>{
        'Content-Type': 'application/json',
        // Add any other headers if needed
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        responseData = data['data'];
      });
      updateShuffleOptions();
    }
    else {
      // Handle the case when the API call is not successful
      print('Failed to load questions. Status code: ${response.statusCode}');
      // You might want to display an error message or handle it based on your requirements
    }
  }

  // function for GET API
  // Future api()async{
  //   final response=await http.get(Uri.parse("your url "));
  //   if(response.statusCode==200){
  //     var data=jsonDecode(response.body)['result'];
  //     setState(() {
  //       responseData=data;
  //     });
  //   }
  // }


  @override
  void initState() {
    super.initState();
    api();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            // Mobile view
            return buildMobileView();
          } else {
            // Web view
            return buildWebView();
          }
        },
      ),
    );
  }

  Widget buildMobileView() {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              SizedBox(
                height: 380,
                width: 380,
                child: Stack(
                  children: [
                    Container(
                      height: 360,
                      width: 390,
                      decoration: BoxDecoration(
                        color: const Color(0xfff6ddbe),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      left: 22,
                      child: Container(
                        height: 200,
                        width: 300,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 1),
                              blurRadius: 5,
                              spreadRadius: 3,
                              color: Color(0xFFFC8A02).withOpacity(.4),
                            )
                          ],
                        ),

                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18,
                          vertical: 45),
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  "Question ${number + 1}/${responseData.length}",
                                  style: TextStyle(color: Color(0xFFFC8A02), fontSize: 18, fontWeight: FontWeight.bold,),
                                ),
                              ),
                              SizedBox(height: 20,),
                              Text(
                                responseData.isNotEmpty ? responseData[number]['question'] : '',
                                style: TextStyle(fontSize: 14,),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                              bottom: 190,
                              left: 135,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            height: 85, // Set the desired height
                            width: 85, // Set the desired width
                            child: CircularProgressIndicator(
                              value: (number + 1) / responseData.length, // Set the progress value accordingly
                              strokeWidth: 10, // Adjust the strokeWidth as needed
                              backgroundColor: Colors.black,
                              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFC8A02)),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${number + 1}/${responseData.length}",
                                style: const TextStyle(color: Color(0xFFFC8A02), fontSize: 18),
                              ),
                              Text(
                                "Visited",
                                style: const TextStyle(color: Color(0xFFFC8A02),fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                            ),

                    Container(
                      padding: EdgeInsets.symmetric(vertical: 40.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Positioned(

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.access_time,
                                    color: Colors.black,
                                    size:50 ,
                                  ),
                                 // Adjust the spacing between the icon and text
                                  Text(
                                    formatTime(_secondRemaining),
                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          SizedBox(width: 30,),


                          ElevatedButton(
                            onPressed: () {
                              autoSubmitQuiz();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFFFC8A02),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text(
                              'Submit',
                              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold , fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: shuffledOptions.map((option) {
                          return Options(option: option.toString());
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFFC8A02),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        elevation: 5,
                      ),
                      onPressed: () {
                        previousQuestion();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'Previous',
                          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFFC8A02),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        elevation: 5,
                      ),
                      onPressed: () {
                        nextQuestion();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'Next',
                          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }




  Widget buildWebView() {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
               width: 1100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    // height: 450,
                    // width: 600,
                    child: Stack(
                      children: [
                        Container(
                          height: 550,
                          width: 1000,
                          decoration: BoxDecoration(
                            color: const Color(0xfff6ddbe),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        Positioned(
                          bottom: 100,
                          left: 100,
                          child: Container(
                            height: 350,
                            width: 800,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 1),
                                  blurRadius: 5,
                                  spreadRadius: 3,
                                  color: Color(0xFFFC8A02).withOpacity(.4),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                     Text(
                                 "Question ${number + 1} of ${responseData.length}",
                                      style: const TextStyle(color: Color(0xFFFC8A02),
                                      fontSize: 28),
                                    ),

                                  SizedBox(height: 25,),
                                  Text(
                                    responseData.isNotEmpty ? responseData[number]['question'] : '',
                                    style: const TextStyle(
                                      fontSize: 18, // Change the value as needed
                                    ),
                                  ),
                                  SizedBox(height: 25,),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: double.infinity,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              for (int i = 0; i < shuffledOptions.length; i += 2)
                                                Row(
                                                  children: [
                                                    Options(option: shuffledOptions[i].toString()),
                                                    SizedBox(width: 20, height: 80), // Adjust the width as needed
                                                    if (i + 1 < shuffledOptions.length)
                                                      Options(option: shuffledOptions[i + 1].toString()),
                                                  ],
                                                ),

                                              // Add any additional widgets for the right side as needed
                                            ],
                                          ),
                                        ),
                                      ),


                                      Padding(
                                        padding: EdgeInsets.only(bottom: 10, right: 60),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            SizedBox(
                                              height: 120, // Set the desired height
                                              width: 120, // Set the desired width
                                              child: CircularProgressIndicator(
                                                value: (number + 1) / responseData.length, // Set the progress value accordingly
                                                strokeWidth: 10, // Adjust the strokeWidth as needed
                                                backgroundColor: Color(0xfff6ddbe),
                                                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFC8A02)),
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${number + 1}/${responseData.length}",
                                                  style: const TextStyle(color: Color(0xFFFC8A02), fontSize: 18),
                                                ),
                                                Text(
                                                  "Visited",
                                                  style: const TextStyle(color: Color(0xFFFC8A02), fontSize: 18),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),


                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 20.0,
                          horizontal: 20),
                          child: Row(

                            children: [
                              Positioned(

                                  child: Row(

                                    children: [
                                      const Icon(
                                        Icons.access_time,
                                        color: Colors.black,
                                        size: 50,
                                      ),
                                      SizedBox(width: 5), // Adjust the spacing between the icon and text
                                      Column(

                                        children:[
                                          Text("Time Remaining"),
                                          Text(
                                          formatTime(_secondRemaining),
                                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                                        ),
                                       ]

                                      ),
                                    ],
                                  ),

                              ),

                             SizedBox(width: 700,),
                              ElevatedButton(
                                onPressed: () {
                                  autoSubmitQuiz();
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFFFC8A02),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: const Text(
                                  'Submit',
                                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold , fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Positioned(
                          bottom: 30,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFFFC8A02),
                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                    elevation: 5,
                                  ),
                                  onPressed: () {
                                    previousQuestion();
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'Previous',
                                      style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),

                                SizedBox(width: 250,),
                                for (int i = 0; i < responseData.length; i++)
                                  GestureDetector(
                                    onTap: () {
                                      goToQuestion(i);
                                    },
                                    child: Container(
                                      width: 45,
                                      height: 45,
                                      margin: EdgeInsets.symmetric(horizontal: 5),
                                      decoration: BoxDecoration(
                                        color: i == number ? Color(0xFFFC8A02) : Colors.white, // Highlight the selected question
                                        borderRadius: BorderRadius.circular(5), // Adjust the radius for rounded corners
                                      ),
                                      child: Center(
                                        child: Text(
                                          (i + 1).toString(), // Display question number (adding 1 because index starts from 0)
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                SizedBox(width: 250,),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFFFC8A02),
                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                    elevation: 5,
                                  ),
                                  onPressed: () {
                                    nextQuestion();
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'Next',
                                      style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),


                ],
              ),
            ),

          ],
        ),
      ),
    );
  }


  String formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void goToQuestion(int questionIndex) {
    if (questionIndex >= 0 && questionIndex < responseData.length) {
      // Check if the question index is within valid bounds
      setState(() {
        number = questionIndex;
        updateShuffleOptions();// Update the current question index
      });
    }
  }


  void nextQuestion() {
    if (number == responseData.length - 1) {
      completed();
    }
    setState(() {
      number = number + 1;
      updateShuffleOptions();
      _secondRemaining = 30;
    });
  }

  void completed() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CompletedPage()));
  }

  void updateShuffleOptions() {
    setState(() {
      List<dynamic>? options = responseData[number]['options'] as List<dynamic>?;

      if (options != null && options.isNotEmpty) {
        shuffledOptions = shuffledOption(options.cast<String>());
      }
    });
  }




  List<String> shuffledOption(List<String> option) {
    List<String> shuffledOptions = List.from(option);
    shuffledOptions.shuffle();
    return shuffledOptions;
  }


  void startTimer() {
    const oneSecond = Duration(seconds: 1);

    Timer.periodic(oneSecond, (timer) {
      setState(() {
        if (totalQuizTime > 0) {
          totalQuizTime--;
          _secondRemaining = totalQuizTime;
        } else {
          timer.cancel(); // Stop the timer when it reaches 0
          autoSubmitQuiz(); // Auto-submit the quiz when time is up
        }
      });
    });
  }
  void autoSubmitQuiz() {

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CompletedPage())); // Assuming you have a function to submit the quiz
  }


  void previousQuestion() {
    if (number > 0) {
      setState(() {
        number = number - 1;
        updateShuffleOptions();
        _secondRemaining = 30;
      });
    }
  }
}

