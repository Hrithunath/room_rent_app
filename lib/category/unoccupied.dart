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
    return ValueListenableBuilder<List<RoomModel>>(
      valueListenable: unoccupiedroomNotifier,
      builder: (BuildContext context, List<RoomModel> roomList, Widget? child) {
        if (roomList.isEmpty) {
          return const Center(
            child: Text('No Data Found'),
          );
        }

        return ListView.separated(
          itemCount: roomList.length,
          itemBuilder: (context, index) {
            final data = roomList[index];
            return Padding(
              padding: const EdgeInsets.all(15),
              child: Card(
                  color: Color(0xFF0C2D57),
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
                  //============================================ Room Number          
                            Text(
                              'Room No: ${data.room}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                               color: Color(0xFFEFECEC),
                              ),
                            ),
                            const SizedBox(
                              height: 1,
                            ),
                            Row(
                              children: [
                  //============================================ Floor Number             
                                const Icon(Icons.layers, size: 20,color: Color(0xFFEFECEC),),
                                const SizedBox(width: 5),
                                Text(
                                  data.floor,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFFEFECEC),
                                  ),
                                ),
                                const SizedBox(width: 10),
                  //============================================ Number of Guest
                                const Icon(Icons.people, size: 20,color: Color(0xFFEFECEC),),
                                const SizedBox(width: 5),
                                Text(
                                  data.guests,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFFEFECEC),
                                  ),
                                ),
                                const SizedBox(width: 10),
                  //============================================== Bed
                                const Icon(Icons.hotel, size: 20,color: Color(0xFFEFECEC),),
                                const SizedBox(width: 5),
                                Text(
                                  data.bed,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFFEFECEC),
                                  ),
                                ),
                                const SizedBox(width: 60),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          if (data.id != null) {
                                            deleteAlert(context, data.id!);
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        )),
                                    IconButton(
                                      onPressed: () {
                                        if (data.id != null) {
                                          editAlert(context, data.id!, roomList,
                                              index);
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                      color: Color(0xFFEFECEC),
                                      ),
                                      iconSize: 20,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '₹${data.rent}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color(0xFFEFECEC),
                                  ),
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
                  //============================================== Rent                
                                  icon: const Icon(
                                    Icons.currency_rupee,
                                  color: Color(0xFFEFECEC),
                                  ),
                                  label: const Text(
                                    'Rent',
                                    style: TextStyle(
                                    color: Color(0xFFEFECEC),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.green),
                                    elevation:
                                        MaterialStateProperty.all<double>(8),
                                    padding: MaterialStateProperty.all<
                                        EdgeInsetsGeometry>(
                                      const EdgeInsets.all(12),
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                                )
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
