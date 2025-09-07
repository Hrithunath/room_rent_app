import 'package:flutter/material.dart';

Widget button({
  required String buttonText,
  required void Function() buttonPressed,
}) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:  Color(0xFF5E47DD),
          ),
          onPressed: buttonPressed,
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.white),
          ),
        ),
      ],
    ),
  );
}
