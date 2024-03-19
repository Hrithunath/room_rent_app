import 'package:flutter/material.dart';

Widget customText(String label, String text, IconButton? iconButton) {
  return Expanded(
    child: Row(
      children: [
        Text(
          '$label: ',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          text,
          style: const TextStyle(
            color: Color.fromARGB(255, 3, 12, 83),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        if (iconButton != null) iconButton,
      ],
    ),
  );
}
