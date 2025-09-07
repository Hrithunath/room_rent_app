import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:room_rent_app/model/user_model.dart';
import 'package:room_rent_app/screens/user/edit_userdetails.dart';
import 'package:room_rent_app/services/user_services.dart';
import 'package:room_rent_app/widgets/refactor_button.dart';
import 'package:room_rent_app/widgets/refactor_edit.dart';
import 'package:room_rent_app/widgets/refactor_text.dart';
import 'package:url_launcher/url_launcher.dart';

class UserDetails extends StatefulWidget {
  final UserModel userModel;
  final int? roomId;
  final String? imagepath;
  const UserDetails(
      {super.key, required this.userModel, this.imagepath, this.roomId});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    int? id = widget.userModel.id;

    return Scaffold(
      appBar: AppBar(
        title: const Text(' Tenant Details'),
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
          width: 320,
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
                  Row(
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Phone Number: ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                              width:
                                  5), 
                          IconButton(
                            onPressed: () {
                              launchUrl(
                                Uri.parse(
                                  'tel:${widget.userModel.phoneNumber}',
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.call,
                              color: Colors.green,
                            ),
                          ),
                          Text(
                            widget.userModel.phoneNumber,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

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
                  customText('CheckOut',
                      widget.userModel.checkout ?? 'Indefinite', null),
                  const SizedBox(height: 10),

                  //===================================== AdvanceAmount
                  customText(
                      'Advance Amount', widget.userModel.advanceAmount, null),

                  Row(
                    children: [
                      button(
                        buttonText: 'Dispose',
                        buttonPressed: () async {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Alert'),
                              content: const Text('Do you want to dispose?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    disposeUserAction(context);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('YES'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('NO'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      button(
                        buttonText: 'Paid',
                        buttonPressed: () async {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Alert'),
                              content: const Text('Do you want to paid?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    setuserStatus(widget.userModel.id!);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('YES'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('NO'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
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

//===================================== DisposeUser Function
  Future<void> disposeUserAction(BuildContext context) async {
    if (widget.userModel.id != null) {
      log('Room ID: ${widget.userModel.roomId}');
      log('advnc amt: ${widget.userModel.advanceAmount}');
      log('phno: ${widget.userModel.phoneNumber}');
      log('occu: ${widget.userModel.occupation}');
      await disposeUser(widget.userModel.id, widget.userModel.roomId);

      if (widget.userModel.roomId != null) {
        // ignore: avoid_print
        print('Room ID: ${widget.userModel.roomId}');

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User disposed successfully'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User ID is null'),
        ),
      );
    }
  }

  //===================================== ShowSnackBar Edit Function
  editAlert(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (context) {
        return EditAlert(
          onEdit: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacement(
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
