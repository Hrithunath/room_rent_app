import 'dart:io';
import 'package:flutter/material.dart';
import 'package:room_rent_app/model/user_model.dart';
import 'package:room_rent_app/screens/user/edit_userdetails.dart';
import 'package:room_rent_app/widgets/refactor_edit.dart';
import 'package:room_rent_app/widgets/refactor_text.dart';

class UserDetails extends StatefulWidget {
  final UserModel userModel;
  final String? imagepath;
  const UserDetails({super.key, required this.userModel, this.imagepath});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    int? id = widget.userModel.id;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Full Details'),
        actions: [
          IconButton(
            onPressed: () {
              if (id != null) {
                editAlert(context, id);
              }
            },
            icon: const Icon(Icons.edit),
            color: Colors.white,
          )
        ],
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          height: 550,
          child: Card(
            elevation: 30,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: FileImage(File(widget.userModel.image)),
                  ),
                  const SizedBox(height: 20),

                  //===================================== name
                  customText('Name', widget.userModel.name, null),
                  const SizedBox(height: 10),

                  //===================================== PhoneNumber
                  customText(
                      'Phone Number', widget.userModel.phoneNumber, null),
                  const SizedBox(height: 10),

                  //===================================== UploadAdhaar
                  customText(
                    'UploadAdhaar',
                    'Adhaar',

                    //===================================== IconImage Button
                    IconButton(
                      onPressed: () {
                        showUploadAdhaar(
                            context, widget.userModel.uploadAdhaar);
                      },
                      icon: const Icon(Icons.image_outlined),
                    ),
                  ),
                  const SizedBox(height: 10),

                  //===================================== Occupation
                  customText('Occupation', widget.userModel.occupation, null),
                  const SizedBox(height: 10),

                  //===================================== CheckIn
                  customText('CheckIn', widget.userModel.checkin, null),
                  const SizedBox(height: 10),

                  //===================================== CheckOut
                  customText('CheckOut', widget.userModel.checkout, null),
                  const SizedBox(height: 10),

                  //===================================== AdvanceAmount
                  customText(
                      'Advance Amount', widget.userModel.advanceAmount, null),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //===================================== ShowUploadAdhaar Function
  Future<void> showUploadAdhaar(BuildContext context, String imagePath) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Adhaar Image'),
          content: SizedBox(
            width: 200,
            height: 200,
            child: Image.file(
              File(widget.userModel.uploadAdhaar),
              fit: BoxFit.cover,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  //===================================== ShowSnackBar Edit Function
  editAlert(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (context) {
        return EditAlert(
          onEdit: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EditUser(userModel: widget.userModel),
              ),
            );
          },
        );
      },
    );
  }
}
