import 'dart:io';
import 'package:flutter/material.dart';
import 'package:room_rent_app/model/room_model.dart';
import 'package:room_rent_app/model/user_model.dart';
import 'package:room_rent_app/services/room_services.dart';
import 'package:room_rent_app/services/user_services.dart';

class OccupiedFullDetails extends StatefulWidget {
  final TabController tabController;
  final RoomModel roomModel;
  const OccupiedFullDetails(
      {super.key, required this.tabController, required this.roomModel});

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
    getRoom();
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                //============================================ Room Number
                  Text(
                    'Room Number: ${widget.roomModel.room}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                //============================================ Floor
                  Text(
                    'Floor: ${widget.roomModel.floor}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                //============================================ Bed
                  Text(
                    'Bed Type: ${widget.roomModel.bed}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                 //============================================ Number of Guests 
                  Text(
                    'Number of Guests: ${widget.roomModel.guests}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                //============================================ Rent  
                  Text(
                    'Rent: ${widget.roomModel.rent}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                ],
              ),

              // ignore: unnecessary_null_comparison
              _user != null
                  ? Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
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
                        //============================================ Name  
                          Text(
                            'Name: ${_user.name}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                        //============================================ Phone Number  
                          Text(
                            'Phone Number: ${_user.phoneNumber}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                        //============================================ Occupation  
                          Text(
                            'Occupation: ${_user.occupation}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                        //============================================ Check-in  
                          Text(
                            'Check-in: ${_user.checkin}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                        //============================================ Check-out  
                          Text(
                            'Check-out: ${_user.checkout}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                        //============================================ Advance Amount  
                          Text(
                            'Advance Amount: ${_user.advanceAmount}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
