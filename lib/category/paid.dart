import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:room_rent_app/functions/db_user.dart';
import 'package:room_rent_app/model/user_model.dart';

class Paid extends StatelessWidget {
  const Paid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<UserModel>>(
        valueListenable: ispaidNotifier,
        builder:
            (BuildContext context, List<UserModel> userList, Widget? child) {
          return ListView.separated(
            itemBuilder: (context, index) {
              final user = userList[index];
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                  elevation: 15,
                  child: Container(
                    height: 200,
                    width: 300,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: CircleAvatar(
                            backgroundImage: FileImage(File(user.image)),
                            radius: 30,
                            backgroundColor: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
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
                                      width:
                                          50), // Gap between RoomNo 34 and 5000
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
            itemCount: userList.length,
          );
        });
  }
}
