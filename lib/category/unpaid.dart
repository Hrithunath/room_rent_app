import 'package:flutter/material.dart';
import 'package:room_rent_app/functions/db_user.dart';
import 'package:room_rent_app/model/user_model.dart';
import 'package:room_rent_app/model/room_model.dart';
import 'package:room_rent_app/screens/user/user_list.dart';

class Unpaid extends StatelessWidget {
  const Unpaid({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<UserModel>>(
        valueListenable: userNotifier,
        builder:
            (BuildContext context, List<UserModel> userlist, Widget? child) {
          return ListView.separated(
            itemBuilder: (context, int index) {
              UserModel user = userlist[index];
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
                                    'RoomNo:${user.room.roomNuber}',
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
            separatorBuilder: (context, index) => const SizedBox(height: 15),
            itemCount: 3,
          );
        });
  }
}
