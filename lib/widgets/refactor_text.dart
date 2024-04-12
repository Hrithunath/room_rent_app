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
             color: Color(0xFFEFECEC),
          ),
        ),
        Text(
          text,
          style: const TextStyle(
             color: Color(0xFFEFECEC),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        if (iconButton != null) iconButton,
      ],
    ),
  );
}
