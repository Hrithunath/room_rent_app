import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easy_search_bar/flutter_easy_search_bar.dart';
import 'package:room_rent_app/model/user_model.dart';
import 'package:room_rent_app/screens/user/user_details.dart';
import 'package:room_rent_app/services/user_services.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  void initState() {
    super.initState();
    getuser();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: EasySearchBar(
        title: const Center(child: Text('Tenants')),
        onSearch: (value) async {
          List<UserModel> user = await searchText(value);
          userNotifier.value = user;
        },
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.03),
        child: ValueListenableBuilder<List<UserModel>>(
          valueListenable: userNotifier,
          builder:
              (BuildContext context, List<UserModel> userList, Widget? child) {
            return ListView.separated(
              itemBuilder: (context, index) {
                final data = userList[index];
                return Card(
                  elevation: 15,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.03),
                  ),
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              UserDetails(userModel: data, roomId: data.roomId),
                        ),
                      );
                    },
                    leading: CircleAvatar(
                      backgroundImage: FileImage(File(data.image)),
                      radius: screenWidth * 0.09,
                    ),
                    title: Text(
                      "Name: ${data.name}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.035,
                      ),
                    ),
                    subtitle: Text(
                      "Phone number: ${data.phoneNumber}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.035,
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) =>
                  SizedBox(height: screenHeight * 0.02),
              itemCount: userList.length,
            );
          },
        ),
      ),
    );
  }
}
