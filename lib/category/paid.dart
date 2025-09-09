import 'dart:io';
import 'package:flutter/material.dart';
import 'package:room_rent_app/model/user_model.dart';
import 'package:room_rent_app/services/user_services.dart';

class Paid extends StatelessWidget {
  const Paid({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ValueListenableBuilder<List<UserModel>>(
      valueListenable: ispaidNotifier,
      builder: (BuildContext context, List<UserModel> userList, Widget? child) {
        if (userList.isEmpty) {
          return const Center(
            child: Text('No Data Found'),
          );
        }
        return ListView.separated(
          itemBuilder: (context, index) {
            final user = userList[index];
            return Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Card(
                elevation: 15,
                child: SizedBox(
                  height: screenHeight * 0.15,
                  width: screenWidth * 0.9,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.025),
                        child: CircleAvatar(
                          backgroundImage: FileImage(File(user.image)),
                          radius: screenWidth * 0.08,
                          backgroundColor: Colors.black,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.03),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ============================== Name
                            Text(
                              "Name: ${user.name}",
                              style: TextStyle(
                                fontSize: screenWidth * 0.045,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.005),
                            // ============================== CheckIn
                            Text(
                              "CheckIn: ${user.checkin}",
                              style: TextStyle(
                                fontSize: screenWidth * 0.04,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.005),
                            Row(
                              children: [
                                // ============================== Phone Number
                                Text(
                                  "Phone: ${user.phoneNumber}",
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.04,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.02),
                                // ============================== Paid
                                Text(
                                  'Paid',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: screenWidth * 0.045,
                                    fontWeight: FontWeight.bold,
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
          separatorBuilder: (BuildContext context, int index) =>
              SizedBox(height: screenHeight * 0.02),
          itemCount: userList.length,
        );
      },
    );
  }
}
