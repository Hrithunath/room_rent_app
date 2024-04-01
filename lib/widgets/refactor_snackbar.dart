import 'package:flutter/material.dart';

void customSnackBar(
    BuildContext context, String message, Color backgroundColor) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: backgroundColor,
      margin: const EdgeInsets.all(10),
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
    ),
  );
}
