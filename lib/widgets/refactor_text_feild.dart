import 'package:flutter/material.dart';

Widget customTextfeild({
  required TextEditingController controller,
  required TextInputType keyboardTYpe,
  required String labelText,
  required String? Function(String?)? validator,
  required AutovalidateMode autovalidateMode,
}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardTYpe,
          decoration: InputDecoration(
            labelText: labelText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          ),
          validator: validator,
          autovalidateMode: autovalidateMode,
        ),
      ),
    ],
  );
}
