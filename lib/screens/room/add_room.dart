// ignore_for_file: invalid_use_of_protected_member

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:room_rent_app/model/room_model.dart';
import 'package:room_rent_app/screens/Home/home.dart';
import 'package:room_rent_app/services/room_services.dart';
import 'package:room_rent_app/services/user_services.dart';
import 'package:room_rent_app/widgets/refactor_button.dart';
import 'package:room_rent_app/widgets/refactor_snackbar.dart';
import 'package:room_rent_app/widgets/refactor_text_feild.dart';

class AddRoom extends StatefulWidget {
  final RoomModel? roomModel;

  const AddRoom(
      {super.key, required TabController tabController, this.roomModel});

  @override
  State<AddRoom> createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> {
  final formkey = GlobalKey<FormState>();
  final roomNoController = TextEditingController();
  final floorController = TextEditingController();
  final guestsController = TextEditingController();
  final bedController = TextEditingController();
  final rentController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Room Details')),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
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
                    image: imageFile != null
                        ? DecorationImage(
                            image: FileImage(imageFile!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (imageFile == null)
                        const Icon(Icons.add_a_photo_outlined, size: 50),
                      Positioned.fill(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onTap: pickImageFromGallery,
                          ),
                        ),
                      ),
                    ],
                  ),
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
                        return 'Bed Is Required';
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

                //===================================== Add Button
                button(
                    buttonText: 'save',
                    buttonPressed: () async {
                      if (ischeckroomNo(roomNoController.text)) {
                        customSnackBar(
                            context, 'Room Number Already Added', Colors.red);
                      } else {
                        addRoom(context);
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

//===================================== PickImage function
  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = imagePath.split('/').last;
    final newImage = File('${directory.path}/$name');
    return File(imagePath).copy(newImage.path);
  }

  Future pickImageFromGallery() async {
    final XFile? pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    final permanentImage = await saveImagePermanently(pickedFile.path);

    setState(() {
      imageFile = permanentImage;
    });
  }

//===================================== AddRoom Function
  Future<void> addRoom(BuildContext context) async {
    if (formkey.currentState!.validate()) {
      final room = roomNoController.text.trim();
      final floor = floorController.text.trim();
      final guests = guestsController.text.trim();
      final bed = bedController.text.trim();
      final rent = rentController.text.trim();
      final image = imageFile;
      if (room.isEmpty ||
          floor.isEmpty ||
          guests.isEmpty ||
          bed.isEmpty ||
          rent.isEmpty ||
          imageFile == null) {
        return;
      }

      final addRooms = RoomModel(
        isOccupied: false,
        room: room,
        floor: floor,
        guests: guests,
        bed: bed,
        rent: rent == '' ? 0.0 : double.parse(rent),
        image: image!.path,
      );

      await addRoomAsync(addRooms);
      // ignore: invalid_use_of_visible_for_testing_member
      userNotifier.notifyListeners();
      // ignore: use_build_context_synchronously
      customSnackBar(
          context, 'Room Number Added SuccesFully', const Color(0xFF5E47DD));
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Home()),
        );
      });
    }
  }
}
