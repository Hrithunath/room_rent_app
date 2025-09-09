import 'dart:io';
import 'package:flutter/material.dart';
import 'package:room_rent_app/model/room_model.dart';
import 'package:room_rent_app/screens/room/edit_room.dart';
import 'package:room_rent_app/screens/user/add_userdetails.dart';
import 'package:room_rent_app/services/room_services.dart';
import '../widgets/refactor_delete.dart';
import '../widgets/refactor_edit.dart';

class Unoccupied extends StatefulWidget {
  const Unoccupied({super.key});

  @override
  State<Unoccupied> createState() => _UnoccupiedState();
}

class _UnoccupiedState extends State<Unoccupied> {
  // int? id;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return ValueListenableBuilder<List<RoomModel>>(
      valueListenable: unoccupiedroomNotifier,
      builder: (BuildContext context, List<RoomModel> roomList, Widget? child) {
        if (roomList.isEmpty) {
          return Center(
            child: Text(
              'No Data Found',
              style: TextStyle(fontSize: screenWidth * 0.05),
            ),
          );
        }

        return ListView.separated(
          itemCount: roomList.length,
          itemBuilder: (context, index) {
            final data = roomList[index];
            return Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Card(
                elevation: 10,
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: screenHeight * 0.25,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(screenWidth * 0.03),
                          image: DecorationImage(
                            image: FileImage(File(data.image)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //============================================ Room Number

                            Row(
                              children: [
                                Text(
                                  'Room No: ${data.room}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth * 0.05,
                                  ),
                                ),
                                Spacer(),
                                IconButton(
                                    onPressed: () {
                                      if (data.id != null) {
                                        deleteAlert(context, data.id!);
                                      }
                                    },
                                    icon: Icon(Icons.delete,
                                        color: Colors.red,
                                        size: screenWidth * 0.06)),
                                IconButton(
                                  onPressed: () {
                                    if (data.id != null) {
                                      editAlert(
                                          context, data.id!, roomList, index);
                                    }
                                  },
                                  icon: Icon(Icons.edit,
                                      size: screenWidth * 0.06),
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.005),
                            Row(
                              children: [
                                //============================================ Floor Number
                                Icon(Icons.layers, size: screenWidth * 0.05),
                                SizedBox(width: screenWidth * 0.01),
                                Text(
                                  data.floor,
                                  style:
                                      TextStyle(fontSize: screenWidth * 0.04),
                                ),
                                SizedBox(width: screenWidth * 0.025),
                                //============================================ Number of Guest
                                Icon(Icons.people, size: screenWidth * 0.05),
                                SizedBox(width: screenWidth * 0.01),
                                Text(data.guests,
                                    style: TextStyle(
                                        fontSize: screenWidth * 0.04)),
                                SizedBox(width: screenWidth * 0.025),
                                //============================================== Bed
                                Icon(Icons.hotel, size: screenWidth * 0.05),
                                SizedBox(width: screenWidth * 0.01),
                                Text(
                                  data.bed,
                                  style:
                                      TextStyle(fontSize: screenWidth * 0.04),
                                ),
                                SizedBox(height: screenHeight * 0.01),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text.rich(
                                  TextSpan(children: [
                                    TextSpan(
                                      text: '₹${data.rent.floor()}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: screenWidth * 0.05,
                                      ),
                                    ),
                                    TextSpan(
                                        text: '/month',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: screenWidth * 0.035,
                                        ))
                                  ]),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddUser(
                                          roomId: data.id!,
                                        ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.currency_rupee,
                                    color: Colors.white,
                                  ),
                                  label:  Text(
                                    'Rent',
                                    style: TextStyle(
                                       fontSize: screenWidth * 0.03,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            elevation: 8,
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05,
                              vertical: screenHeight * 0.015,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(screenWidth * 0.03),
                              side: BorderSide(
                                color: const Color(0XFF4CB050),
                                width: screenWidth * 0.005,
                              ),
                            ),
                          ),
                        ),
                                
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
          separatorBuilder: (context, index) =>   SizedBox(height: screenHeight * 0.015),
        );
      },
    );
  }

  editAlert(BuildContext context, int id, List<RoomModel> roomList, int index) {
    showDialog(
        context: context,
        builder: (context) {
          return EditAlert(onEdit: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => EditRoom(roomModel: roomList[index])));
          });
        });
  }

  deleteAlert(BuildContext context, int id) {
    showDialog(
        context: context,
        builder: (context) {
          return DeleteAlert(onDelete: () {
            deleteroom(id);
            Navigator.of(context).pop();
          });
        });
  }
}
