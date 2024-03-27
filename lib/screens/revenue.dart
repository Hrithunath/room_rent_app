import 'package:flutter/material.dart';

class Revenue extends StatefulWidget {
  const Revenue({super.key});

  @override
  State<Revenue> createState() => _RevenueState();
}

class _RevenueState extends State<Revenue> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 29, 29, 31),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Padding(
          padding: EdgeInsets.only(left: 100),
          child: Text(
            "Revenue",
            style: TextStyle(
              color: Colors.white, // Changed Color to color
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text("Today"),
            ),
            const SizedBox(width: 5),
            ElevatedButton(
              onPressed: () {},
              child: const Text("This Week"),
            ),
            const SizedBox(width: 5),
            ElevatedButton(
              onPressed: () {},
              child: const Text("This Month"),
            ),
          ],
        ),
      ),
    );
  }
}
