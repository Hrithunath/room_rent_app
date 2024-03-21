import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Paid extends StatelessWidget {
  const Paid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Card(
              elevation: 15,
              child: Container(
                height: 200,
                width: 300,
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.black,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Muhammad Faisal',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                'RoomNo 34',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                  width: 50), // Gap between RoomNo 34 and 5000
                              Text('₹5000', style: TextStyle(fontSize: 20)),
                              Text('/month',
                                  style: TextStyle(color: Colors.grey)),
                              // Gap between /month and Paid
                              Text(
                                'Paid',
                                style: TextStyle(color: Colors.green),
                              ),
                              SizedBox(width: 10),
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
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: 15),
        itemCount: 3,
      ),
    );
  }
}
