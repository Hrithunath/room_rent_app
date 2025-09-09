import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:room_rent_app/model/user_model.dart';
import 'package:room_rent_app/screens/user/edit_userdetails.dart';
import 'package:room_rent_app/services/user_services.dart';
import 'package:room_rent_app/widgets/refactor_button.dart';
import 'package:room_rent_app/widgets/refactor_edit.dart';
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

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tenant Details',
          style: TextStyle(fontSize: screenWidth * 0.05),
        ),
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
          width: screenWidth * 0.85,
          height: screenHeight * 0.75,
          child: Card(
            elevation: 30,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(screenWidth * 0.05),
            ),
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: screenWidth * 0.15,
                      backgroundImage: FileImage(File(widget.userModel.image)),
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // Name
                    Text(
                      'Name: ${widget.userModel.name}',
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),

                    // Phone Number
                    Row(
                      children: [
                        Text(
                          'Phone Number: ',
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            launchUrl(
                              Uri.parse('tel:${widget.userModel.phoneNumber}'),
                            );
                          },
                          icon: Icon(
                            Icons.call,
                            color: Colors.green,
                            size: screenWidth * 0.06,
                          ),
                        ),
                        Text(
                          widget.userModel.phoneNumber,
                          style: TextStyle(
                            fontSize: screenWidth * 0.032,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.015),

                    // Aadhaar
                    Row(
                      children: [
                        Text(
                          'Upload Adhaar: ',
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            showUploadAdhaar(
                                context, widget.userModel.uploadAdhaar);
                          },
                          icon: Icon(
                            Icons.image_outlined,
                            size: screenWidth * 0.06,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.015),

                    // Occupation
                    Text(
                      'Occupation: ${widget.userModel.occupation}',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),

                    // CheckIn
                    Text(
                      'CheckIn: ${widget.userModel.checkin}',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),

                    // CheckOut
                    Text(
                      'CheckOut: ${widget.userModel.checkout ?? 'Indefinite'}',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),

                    // Advance Amount
                    Text(
                      'Advance Amount: ${widget.userModel.advanceAmount}',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.025),

                    // Buttons
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
      ),
    );
  }

  Future<void> showUploadAdhaar(BuildContext context, String imagePath) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        final screenWidth = MediaQuery.of(context).size.width;
        return AlertDialog(
          title: Text(
            'Adhaar Image',
            style: TextStyle(fontSize: screenWidth * 0.045),
          ),
          content: SizedBox(
            width: screenWidth * 0.5,
            height: screenWidth * 0.5,
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
              child: Text(
                'Close',
                style: TextStyle(fontSize: screenWidth * 0.04),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> disposeUserAction(BuildContext context) async {
    if (widget.userModel.id != null) {
      log('Room ID: ${widget.userModel.roomId}');
      log('advnc amt: ${widget.userModel.advanceAmount}');
      log('phno: ${widget.userModel.phoneNumber}');
      log('occu: ${widget.userModel.occupation}');
      await disposeUser(widget.userModel.id, widget.userModel.roomId);

      if (widget.userModel.roomId != null) {
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
