import 'dart:io';
import 'package:flutter/material.dart';
import 'package:room_rent_app/category/occupied_full_details.dart';

import 'package:room_rent_app/model/room_model.dart';
import 'package:room_rent_app/services/room_services.dart';

class Occupied extends StatelessWidget {
  const Occupied({super.key});

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

        return ListView.separated(
          itemBuilder: (context, index) {
            final data = roomList[index];
            return Padding(
              padding: const EdgeInsets.all(15),
              child: Card(
                elevation: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: FileImage(File(data.image)),
                            fit: BoxFit.cover,
                            colorFilter: const ColorFilter.mode(
                              Colors.grey,
                              BlendMode.saturation,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //============================================ Room Number
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Room No: ${data.room}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const Text(
                                ' Not Available',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 1),
                          Row(
                            children: [
                              //============================================ Floor
                              const Icon(
                                Icons.layers,
                                size: 20,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                data.floor,
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(width: 10),
                              //============================================ Guest
                              const Icon(
                                Icons.people,
                                size: 20,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                data.guests,
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(width: 10),
                              //============================================ Bed
                              const Icon(
                                Icons.hotel,
                                size: 20,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                data.bed,
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text.rich(
                                TextSpan(children: [
                                  TextSpan(
                                    text: '₹${data.rent.floor()}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  TextSpan(
                                      text: '/month',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500))
                                ]),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          OccupiedFullDetails(roomModel: data),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'View Details',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color(0XFF5E47DD)),
                                  elevation:
                                      MaterialStateProperty.all<double>(8),
                                  padding: MaterialStateProperty.all<
                                      EdgeInsetsGeometry>(
                                    const EdgeInsets.all(12),
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(
                                        color: Color(0XFF5E47DD),
                                        width: 2,
                                      ),
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
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: roomList.length,
        );
      },
    );
  }
}
