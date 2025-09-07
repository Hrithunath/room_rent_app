import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:room_rent_app/model/room_model.dart';
import 'package:room_rent_app/screens/Home/home.dart';
import 'package:room_rent_app/services/room_services.dart';
import 'package:room_rent_app/widgets/refactor_button.dart';
import 'package:room_rent_app/widgets/refactor_snackbar.dart';
import 'package:room_rent_app/widgets/refactor_text_feild.dart';

class EditRoom extends StatefulWidget {
  final RoomModel? roomModel;

  const EditRoom({
    super.key,
    required this.roomModel,
  });

  @override
  State<EditRoom> createState() => _EditRoomState();
}

class _EditRoomState extends State<EditRoom> {
  final formkey = GlobalKey<FormState>();
  final roomNoController = TextEditingController();
  final floorController = TextEditingController();
  final guestsController = TextEditingController();
  final bedController = TextEditingController();
  final rentController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  String imgPath = '';

  @override
  void initState() {
    super.initState();
    roomNoController.text = widget.roomModel!.room;
    floorController.text = widget.roomModel!.floor;
    guestsController.text = widget.roomModel!.guests;
    bedController.text = widget.roomModel!.bed;
    rentController.text = widget.roomModel!.rent.toString();
    imgPath = widget.roomModel!.image;
  }

  @override
  Widget build(BuildContext context) {
    int? id = widget.roomModel!.id;
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Room Details')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 237, 234, 234),
                    borderRadius: BorderRadius.circular(15),
                    // ignore: unnecessary_null_comparison
                    image: imgPath != null
                        ? DecorationImage(
                            image: FileImage(File(imgPath)),
                            fit: BoxFit.cover,
                          )
                        : const DecorationImage(
                            image: AssetImage("assets/images/profile.jpg"),
                            fit: BoxFit.cover,
                          ),
                  ),
                  child: IconButton(
                      onPressed: () {
                        pickImageFromGallery();
                      },
                      icon: const Icon(
                        Icons.add_a_photo_outlined,
                        size: 50,
                      )),
                ),

                //===================================== Room No
                customTextfeild(
                  controller: roomNoController,
                  keyboardTYpe: TextInputType.number,
                  labelText: 'Room No',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Room No Is Required';
                    } else {
                      return null;
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),

                //===================================== Floor
                customTextfeild(
                    controller: floorController,
                    keyboardTYpe: TextInputType.number,
                    labelText: 'Floor',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Floor Is Required';
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction),

                //===================================== Guests
                customTextfeild(
                    controller: guestsController,
                    keyboardTYpe: TextInputType.number,
                    labelText: 'Guests',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Guests Is Required';
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction),

                   //===================================== Bed 
                customTextfeild(
                    controller: bedController,
                    keyboardTYpe: TextInputType.text,
                    labelText: 'Bed',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Bed Type Is Required';
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction),

                //===================================== Rent
                customTextfeild(
                    controller: rentController,
                    keyboardTYpe: TextInputType.number,
                    labelText: 'Rent/Month',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Rent Is Required';
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction),

                //===================================== Rent
                button(
                    buttonText: 'save',
                    buttonPressed: () {
                      editRoom(context, id);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

//=====================================PickImage
  Future pickImageFromGallery() async {
    final XFile? pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imgPath = pickedFile.path;
      });
    }
  }

//=====================================Edit Room
  Future<void> editRoom(BuildContext context, int? id) async {
    if (formkey.currentState!.validate()) {
      final room = roomNoController.text.trim();
      final floor = floorController.text.trim();
      final guests = guestsController.text.trim();
      final bed = bedController.text.trim();
      final rent = rentController.text.trim();
      final image = imgPath;
      if (room.isEmpty ||
          floor.isEmpty ||
          guests.isEmpty ||
          bed.isEmpty ||
          rent.isEmpty ||
          imgPath.isEmpty) {
        return;
      }

      final editRooms = RoomModel(
          isOccupied: widget.roomModel!.isOccupied,
          id: id,
          room: room,
          floor: floor,
          guests: guests,
          bed: bed,
          rent: rent == '' ? 0.0 : double.parse(rent),
          image: image);

      await updateRoomAsync(editRooms, id);

      // ignore: use_build_context_synchronously
      customSnackBar(context, 'Edited the Room Details SuccesFully',
          const Color(0XFF5E47DD));
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const Home()));
      });
    }
  }
}
