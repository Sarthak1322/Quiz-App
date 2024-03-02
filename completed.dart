


// import 'dart:html';
import 'package:responsive_builder/responsive_builder.dart';

import 'package:flutter/material.dart';
import 'package:jnanamarga_quiz/quiz.dart';

class CompletedPage extends StatelessWidget {
  const CompletedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 521,
            width: 400,
            child: Stack(
              children: [
                Container(
                  height: 340,
                  width: 410,
                  decoration: BoxDecoration(
                    color: Color(0xFFFC8A02),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Center(
                    child: CircleAvatar(
                      radius: 90,
                      backgroundColor: Colors.white.withOpacity(.3),
                      child: CircleAvatar(
                        radius: 77,
                        backgroundColor: Colors.white.withOpacity(.4),
                        child:  CircleAvatar(
                          radius: 65,
                          backgroundColor: Colors.white,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                              const Text('Your Score', style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xffA42FC1)
                          
                                ),),
                                RichText(
                                    text:const TextSpan(
                                  text:'100', style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffA42FC1)
                                ),
                                children: [
                                     TextSpan(
                                    text:' pt', style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xffA42FC1)
                                    ),
                          
                                     ) ]
                          
                                )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 60,
                    left: 22,
                    child: Container(
                      height: 190,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            spreadRadius: 3,
                            color: Color(0xffA42FC1).withOpacity(.7),
                            offset: Offset(0 ,1)
                          )
                        ]
                      ),
                      child:Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 15,
                                              width: 15,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xffA42FC1)

                                              ),

                                            ),
                                           const Text('100%', style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20,
                                              color: Color(0xffA42FC1)
                                            ),)
                                          ]
                                        ),
                                      ),
                                      const Text('Completion')
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Row(
                                            children: [
                                              Container(
                                                height: 15,
                                                width: 15,
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Color(0xffA42FC1)

                                                ),

                                              ),
                                              const Text('10', style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 20,
                                                  color: Color(0xffA42FC1)
                                              ),)
                                            ]
                                        ),
                                      ),
                                      const Text('Total Questions')
                                    ],
                                  )

                                ],
                              ),
                             const SizedBox(
                                height: 25,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Row(
                                            children: [
                                              Container(
                                                height: 15,
                                                width: 15,
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.green

                                                ),

                                              ),
                                              const Text('07', style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 20,
                                                  color: Colors.green
                                              ),)
                                            ]
                                        ),
                                      ),
                                      const Text('Correct')
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 48),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Row(
                                              children: [
                                                Container(
                                                  height: 15,
                                                  width: 15,
                                                  decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.red
                                    
                                                  ),
                                    
                                                ),
                                                const Text('03', style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 20,
                                                    color: Colors.red
                                                ),)
                                              ]
                                          ),
                                        ),
                                        const Text('Wrong')
                                      ],
                                    ),
                                  )

                                ],
                              )
                            ],
                          ),
                        ),
                      ),

                ))
              ],
            ),
          ),
          const SizedBox(height: 5,),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>QuizScreen()));
                          },
                        child: const CircleAvatar(
                          backgroundColor: Color(0xff37AFA1),
                          radius: 35,
                          child: Center(
                            child: Icon(Icons.refresh, size: 35, color: Colors.white,),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text('Restart', style: TextStyle(fontSize: 15,
                      fontWeight: FontWeight.w500),)
                    ],
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xffCB9771),
                        radius: 35,
                        child: Center(
                          child: Icon(Icons.visibility_rounded, size: 35, color: Colors.white,),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text('Review Answer', style: TextStyle(fontSize: 15,
                          fontWeight: FontWeight.w500),)
                    ],
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xff37AFA1),
                        radius: 35,
                        child: Center(
                          child: Icon(Icons.share, size: 35, color: Colors.white,),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text('Share Score', style: TextStyle(fontSize: 15,
                          fontWeight: FontWeight.w500),)
                    ],
                  )

                ],
              ),
            ),
          ),
          SizedBox(height: 5,),
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xff37AFA1),
                        radius: 35,
                        child: Center(
                          child: Icon(Icons.file_open_rounded, size: 35, color: Colors.white,),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text('Generate PDF', style: TextStyle(fontSize: 15,
                          fontWeight: FontWeight.w500),)
                    ],
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xffAD8AEB),
                        radius: 35,
                        child: Center(
                          child: Icon(Icons.home, size: 35, color: Colors.white,),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text('Home', style: TextStyle(fontSize: 15,
                          fontWeight: FontWeight.w500),)
                    ],
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xff5F6A6E),
                        radius: 35,
                        child: Center(
                          child: Icon(Icons.note, size: 35, color: Colors.white,),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text('Leaderboard', style: TextStyle(fontSize: 15,
                          fontWeight: FontWeight.w500),)
                    ],
                  )

                ],
              ),
            ),
          ),

        ],
      ),


    );
  }
}
