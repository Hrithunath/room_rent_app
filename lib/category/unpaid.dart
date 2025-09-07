import 'dart:io';
import 'package:flutter/material.dart';
import 'package:room_rent_app/model/user_model.dart';
import 'package:room_rent_app/screens/user/user_details.dart';
import 'package:room_rent_app/services/user_services.dart';
import 'package:room_rent_app/widgets/refactor_text.dart';

class Unpaid extends StatelessWidget {
  const Unpaid({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<UserModel>>(
      valueListenable: isunpaidNotifier,
      builder: (BuildContext context, List<UserModel> userList, Widget? child) {
        if (userList.isEmpty) {
          return const Center(
            child: Text('No Data Found'),
          );
        }
        return ListView.separated(
          itemBuilder: (context, int index) {
            final user = userList[index];
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => UserDetails(userModel: user),
                ));
              },
              child: Padding(
                padding:  const EdgeInsets.all(10),
                child: Card(
                   
                  elevation: 15,
                  child: SizedBox(
                    height: 100,
                    width: 300,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
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
                  //============================================ Name            
                              customText('Name', user.name, null),
                              const SizedBox(width: 50),
                  //============================================ CheckIn            
                             customText('CheckIn', user.checkin, null),
                              Row(
                                children: [
                  //============================================ Phone Number                
                               customText('Phone Number', user.phoneNumber, null),
                                  const SizedBox(width: 10),
                  //============================================ Paid                
                                  const Text(
                                    'UnPaid',
                                    style: TextStyle(color: Colors.red,fontSize: 17,fontWeight: FontWeight.bold),
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
