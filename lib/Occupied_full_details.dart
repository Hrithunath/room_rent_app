import 'dart:io';
import 'package:flutter/material.dart';
import 'package:room_rent_app/model/room_model.dart';
import 'package:room_rent_app/model/user_model.dart';
import 'package:room_rent_app/services/room_services.dart';
import 'package:room_rent_app/services/user_services.dart';
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
  late UserModel _user;

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
    getuser();
  }

  Future<void> _fetchUserDetails() async {
    final user = await fetchUserById(widget.roomModel.userId.toString());
    setState(() {
      _user = user!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Full Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    image: FileImage(File(widget.roomModel.image)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Room Details
              ListTile(
                title: Text('Room Number: ${widget.roomModel.room}'),
                subtitle: Text('Floor: ${widget.roomModel.floor}'),
              ),
              ListTile(
                title: Text('Bed Type: ${widget.roomModel.bed}'),
                subtitle: Text('Number of Guests: ${widget.roomModel.guests}'),
              ),
              const SizedBox(height: 20),
              _user != null
                  ? Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 300,
                            height: 200,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                image: FileImage(File(_user.image)),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ListTile(
                            title: Text('User Name: ${_user.name}'),
                            subtitle:
                                Text('Phone Number: ${_user.phoneNumber}'),
                          ),
                          ListTile(
                            title: Text('Occupation: ${_user.occupation}'),
                            subtitle: Text('Check-in: ${_user.checkin}'),
                          ),
                          ListTile(
                            title: Text('Check-out: ${_user.checkout}'),
                            subtitle:
                                Text('Advance Amount: ${_user.advanceAmount}'),
                          ),
                        ],
                      ),
                    )
                  : CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
