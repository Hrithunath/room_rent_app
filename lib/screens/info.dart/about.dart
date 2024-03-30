import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
       body: const Column(
        children: [
          Text('Rent App',
          style: TextStyle(fontSize: 30,fontWeight: FontWeight.w900),)
        ],
       ),
    );
  }
}