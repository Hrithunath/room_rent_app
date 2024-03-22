import 'dart:io';

import 'package:flutter/material.dart';

class Unoccupied extends StatefulWidget {
  // final TabController tabController;
  const Unoccupied({super.key
      //  required this.tabController
      });

  @override
  State<Unoccupied> createState() => _UnoccupiedState();
}

class _UnoccupiedState extends State<Unoccupied> {
  int? id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 7, 36, 100),
      appBar: AppBar(
        title: Text('hai'),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          // final data = roomList[index];
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Card(
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: Image(
                                  image: AssetImage('lib/assets/images/1.jpg'))
                              .image,
                          colorFilter: ColorFilter.mode(
                              Colors.grey, BlendMode.saturation),
                          // image: FileImage(File(data.image)),
                          // fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Room No:',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 1,
                          ),
                          Row(
                            children: const [
                              Text(
                                'Floor: ',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Guests: ',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(width: 13),
                              Text(
                                'Bed: ',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text('Not Available',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemCount: 4,
      ),
    );
  }
}
