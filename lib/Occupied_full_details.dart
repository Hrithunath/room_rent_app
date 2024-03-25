import 'dart:io';
import 'package:flutter/material.dart';
import 'package:room_rent_app/functions/db_room.dart';
import 'package:room_rent_app/model/room_model.dart';
import 'package:room_rent_app/model/user_model.dart';
import 'package:room_rent_app/widgets/refactor_text.dart';

class OccupiedFullDetails extends StatefulWidget {
  final TabController tabController;
  final RoomModel roomModel; // Add roomModel as a member of the widget
  const OccupiedFullDetails(
      {Key? key, required this.tabController, required this.roomModel});

  @override
  State<OccupiedFullDetails> createState() => _OccupiedFullDetailsState();
}

class _OccupiedFullDetailsState extends State<OccupiedFullDetails> {
  late Future<UserModel?> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = fetchUserById(widget.roomModel.userId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Full Details'),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          height: 600, // Increased height to accommodate room details
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
                    backgroundImage: FileImage(File(widget.roomModel.image)),
                  ),
                  const SizedBox(height: 20),
                  // Room Details
                  customText(
                      'Room Number', widget.roomModel.room.toString(), null),
                  const SizedBox(height: 5),
                  customText('Floor', widget.roomModel.floor.toString(), null),
                  const SizedBox(height: 5),
                  customText('Bed Type', widget.roomModel.bed, null),
                  const SizedBox(height: 5),
                  customText('Number of Guests',
                      widget.roomModel.guests.toString(), null),
                  const SizedBox(height: 20),
                  Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: FutureBuilder<UserModel?>(
                        future: _userFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData) {
                            final user = snapshot.data!;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'User Details',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                customText('User Name', user.name, null),
                                const SizedBox(height: 5),
                                customText(
                                    'Phone Number', user.phoneNumber, null),
                                const SizedBox(height: 5),
                                customText('Occupation', user.occupation, null),
                                const SizedBox(height: 5),
                                customText('Check-in', user.checkin, null),
                                const SizedBox(height: 5),
                                customText('Check-out', user.checkout, null),
                                const SizedBox(height: 5),
                                customText(
                                    'Advance Amount', user.advanceAmount, null),
                              ],
                            );
                          } else {
                            return Text('No user data available');
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Future checkoutroom() async {
//   await ischeckroomNo(widget.roomModel.room.toString()) == false;
//   await deleteroom(widget.roomModel.id!);
//   await getRoom();
//   roomNotifier.notifyListeners();
//   Navigator.pop(context);
// }
