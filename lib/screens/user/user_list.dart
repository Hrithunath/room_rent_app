import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easy_search_bar/flutter_easy_search_bar.dart';
import 'package:room_rent_app/model/user_model.dart';
import 'package:room_rent_app/screens/user/user_details.dart';
import 'package:room_rent_app/services/user_services.dart';
import 'package:room_rent_app/widgets/refactor_text.dart';

class UserList extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
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
    return Scaffold(
      appBar:EasySearchBar(title: const Center(child: Text('Tenants')), onSearch: (value)async {
              List<UserModel> user = await searchText(value);
              userNotifier.value = user;
          },),
      body: Padding(
        padding: const EdgeInsets.all(10),
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
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UserDetails(userModel: data, roomId: data.roomId)));
                    },
                    leading: CircleAvatar(
                      backgroundImage: FileImage(File(data.image)),
                      radius: 35,
                    ),
                    title: Row(
                      children: [
                        //===================================== Name
                        customText('Name', data.name, null),
                      ],
                    ),
                    subtitle: Row(
                      children: [
                        //===================================== PhoneNumber
                        customText('Phone number', data.phoneNumber, null),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 15,
              ),
              itemCount: userList.length,
            );
          },
        ),
      ),
    );
  }
}
