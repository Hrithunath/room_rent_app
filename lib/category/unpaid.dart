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
      valueListenable: userNotifier,
      builder: (BuildContext context, List<UserModel> userList, Widget? child) {
        // Assuming you have a similar setup for roomNotifier
        return ValueListenableBuilder<List<RoomModel>>(
          valueListenable: roomNotifier,
          builder:
              (BuildContext context, List<RoomModel> roomList, Widget? child) {
            return ListView.separated(
              itemBuilder: (context, int index) {
                UserModel user = userList[index];
                // Assuming there's a corresponding room for each user
                RoomModel room = roomList[index];
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
                          const Padding(
                            padding: EdgeInsets.all(10),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.black,
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
                                      'RoomNo:${room.room}',
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(
                                        width:
                                            50), // Gap between RoomNo and Rent
                                    Text(
                                      '₹${room.rent}',
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
      },
    );
  }
}
