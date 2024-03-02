import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Options extends StatelessWidget {
  final String option;

  const Options({Key? key, required this.option}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60,
          width: 260,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 3, color: Color(0xFFFC8A02)),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Radio(
                    value: option,
                    groupValue: null, // Use appropriate group value her
                    onChanged: (val) {
                      // Handle radio button selection
                    },
                  ),
                  Text(
                    option,
                    style: const TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 12),
                  ),

                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
