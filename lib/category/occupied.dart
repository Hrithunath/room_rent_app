import 'dart:io';

import 'package:flutter/material.dart';

import 'package:room_rent_app/functions/db_room.dart';
import 'package:room_rent_app/model/room_model.dart';
import 'package:room_rent_app/screens/room/edit_room.dart';
import 'package:room_rent_app/screens/user/add_userdetails.dart';

import '../widgets/refactor_delete.dart';
import '../widgets/refactor_edit.dart';

class Occupied extends StatelessWidget {
  final TabController tabController;
  const Occupied({super.key, required this.tabController});

  // int? id;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<RoomModel>>(
      valueListenable: occupiedroomNotifier,
      builder: (BuildContext context, List<RoomModel> roomList, Widget? child) {
        if (roomList.isEmpty) {
          return const Center(
            child: Text('No Data Found'),
          );
        }

        // List<RoomModel> occupiedRooms = [];
        // for (var room in roomList) {
        //   if (room.isOccupied) {
        //     occupiedRooms.add(room);
        //   }
        // }
        return ListView.separated(
          itemBuilder: (context, index) {
            final data = roomList[index];
            return Padding(
              padding: const EdgeInsets.all(15),
              child: Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: FileImage(File(data.image)),
                            fit: BoxFit.cover,
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
                              'Room No: ${data.room}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(
                              height: 1,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Floor: ${data.floor}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Guests: ${data.guests}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(width: 13),
                                Text(
                                  'Bed: ${data.bed}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                const Text('Not Available',
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
          itemCount: roomList.length,
        );
      },
    );
  }
}
