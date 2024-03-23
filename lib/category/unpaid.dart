import 'dart:io';

import 'package:flutter/material.dart';
import 'package:room_rent_app/functions/db_user.dart';
import 'package:room_rent_app/functions/db_room.dart'; // Import for room database
import 'package:room_rent_app/model/user_model.dart';
import 'package:room_rent_app/model/room_model.dart';

class Unpaid extends StatelessWidget {
  const Unpaid({Key? key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<UserModel>>(
      valueListenable: isunpaidNotifier,
      builder: (BuildContext context, List<UserModel> userList, Widget? child) {
        // Assuming you have a similar setup for roomNotifier
        return ListView.separated(
          itemBuilder: (context, int index) {
            final user = userList[index];

            return Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                elevation: 15,
                child: SizedBox(
                  height: 200,
                  width: 300,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: CircleAvatar(
                          backgroundImage: FileImage(File(user.image)),
                          radius: 30,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name: ${user.name}',
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  'RoomNo:${user.phoneNumber}',
                                  style: const TextStyle(fontSize: 18),
                                ),
                                const SizedBox(
                                    width: 50), // Gap between RoomNo and Rent
                                Text(
                                  '₹${user.checkin}',
                                  style: const TextStyle(fontSize: 20),
                                ),
                                const Text('/month',
                                    style: TextStyle(color: Colors.grey)),
                                // Gap between /month and Paid
                                const Text(
                                  'Paid',
                                  style: TextStyle(color: Colors.green),
                                ),
                                const SizedBox(width: 10),
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
          separatorBuilder: (context, index) => const SizedBox(height: 15),
          itemCount: userList.length,
        );
      },
    );
  }
}
