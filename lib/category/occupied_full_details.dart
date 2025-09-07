import 'dart:io';
import 'package:flutter/material.dart';
import 'package:room_rent_app/model/room_model.dart';
import 'package:room_rent_app/model/user_model.dart';
import 'package:room_rent_app/services/room_services.dart';
import 'package:room_rent_app/services/user_services.dart';

class OccupiedFullDetails extends StatefulWidget {
  final RoomModel roomModel;
  const OccupiedFullDetails({super.key, required this.roomModel});

  @override
  State<OccupiedFullDetails> createState() => _OccupiedFullDetailsState();
}

class _OccupiedFullDetailsState extends State<OccupiedFullDetails> {
  UserModel? _user;

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: FileImage(File(widget.roomModel.image)),
                    fit: BoxFit.cover,
                    colorFilter: const ColorFilter.mode(
                      Colors.grey,
                      BlendMode.saturation,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Text(
                'Room Details',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0XFF5E47DD)),
              ),

              const SizedBox(height: 20),
              //============================================ Floor
              Row(
                children: [
                  const Icon(
                    Icons.apartment,
                    size: 24,
                    color: Color(0xFF646464),
                  ),
                  const SizedBox(width: 8),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Floor: ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF646464),
                          ),
                        ),
                        TextSpan(
                          text: '${widget.roomModel.floor}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              //============================================ Bed

              Row(
                children: [
                  const Icon(
                    Icons.hotel,
                    size: 24,
                    color: Color(0xFF646464),
                  ),
                  const SizedBox(width: 8),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Bed Type:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF646464),
                          ),
                        ),
                        TextSpan(
                          text: '${widget.roomModel.bed}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              //============================================ Number of Guests

              Row(
                children: [
                  const Icon(
                    Icons.people,
                    size: 24,
                    color: Color(0xFF646464),
                  ),
                  const SizedBox(width: 8),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Number of Guests:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF646464),
                          ),
                        ),
                        TextSpan(
                          text: '${widget.roomModel.guests}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              //============================================ Rent
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Rent: ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF646464),
                          ),
                        ),
                        TextSpan(
                          text: '${widget.roomModel.rent.floor()}/month',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              Text(
                'User Details',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0XFF5E47DD)),
              ),
              const SizedBox(height: 20),
              // ignore: unnecessary_null_comparison
              if (_user != null) ...[
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Name: ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF646464), // label color
                        ),
                      ),
                      TextSpan(
                        text: _user?.name ?? '',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // value color
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Number: ', // changed from Phone Number → Number
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF646464),
                        ),
                      ),
                      TextSpan(
                        text: _user?.phoneNumber ?? '',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Occupation: ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF646464),
                        ),
                      ),
                      TextSpan(
                        text: _user?.occupation ?? '',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Advance Amount: ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF646464),
                        ),
                      ),
                      TextSpan(
                        text: _user?.advanceAmount ?? '',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
