import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:room_rent_app/model/user_model.dart';
import 'package:room_rent_app/screens/user/user_list.dart';
import 'package:room_rent_app/services/room_services.dart';
import 'package:room_rent_app/services/user_services.dart';
import 'package:room_rent_app/widgets/refactor_button.dart';
import 'package:room_rent_app/widgets/refactor_calender.dart';
import 'package:room_rent_app/widgets/refactor_snackbar.dart';
import 'package:room_rent_app/widgets/refactor_text_feild.dart';

class AddUser extends StatefulWidget {
  final int roomId;
  const AddUser({
    super.key,
    required this.roomId,
  });

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final formkey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  // final uploadAdhaarController = TextEditingController();
  final occupationController = TextEditingController();
  final checkInController = TextEditingController();
  final checkOutController = TextEditingController();
  final advanceAmounntController = TextEditingController();

  DateTime? seletedCheckInDate;
  DateTime? seletedCheckoutDate;

  final ImagePicker _imagePicker = ImagePicker();
  File? pickedImage;
  File? pickedImagePath;
  String imgPath = '';
  String imgPath2 = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Tenant Details')),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: pickImage,
                      child: CircleAvatar(
                        radius: 70,
                        backgroundImage: imgPath.isNotEmpty
                            ? FileImage(File(imgPath))
                            : const AssetImage("lib/assets/images/user.png")
                                as ImageProvider,
                      ),
                    ),

                    //===================================== Name
                    customTextfeild(
                      controller: nameController,
                      keyboardTYpe: TextInputType.text,
                      labelText: 'Name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name is Required';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),

                    //===================================== Phone Number
                    customTextfeild(
                      controller: phoneNumberController,
                      keyboardTYpe: TextInputType.phone,
                      labelText: 'Phone Number',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Phone Number is Required';
                        } else if (!RegExp(r"^(?:\+91)?[0-9]{10}$")
                            .hasMatch(value)) {
                          return 'Enter Valid Mobile number';
                        } else {
                          return null;
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),

                   
                    //===================================== Occupation
                    customTextfeild(
                      controller: occupationController,
                      keyboardTYpe: TextInputType.text,
                      labelText: 'Occupation',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Occupation is Required';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    //===================================== CheckIn
                    Row(
                      children: [
                        Expanded(
                            child: customtextFeildcalender(
                          controller: checkInController,
                          onTapcalender: () {
                            selectedCheckedIN(context);
                          },
                          labeltext: 'Check In',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'CheckIn is Required';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        )),

                        //===================================== CheckOut
                        Expanded(
                            child: customtextFeildcalender(
                                controller: checkOutController,
                                onTapcalender: () {
                                  selectedCheckedOut(context);
                                },
                                labeltext: 'CheckOut',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'CheckOut is Required';
                                  }
                                  return null;
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction)),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    //===================================== Advance Amount
                    
                    customTextfeild(
                        controller: advanceAmounntController,
                        keyboardTYpe: TextInputType.number,
                        labelText: 'Advance Amount',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Advance Amount is Required';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction),

                         //===================================== Upload Adhaar
                   Padding(
  padding: const EdgeInsets.all(15),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey), // Add border styling if needed
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10), // Add padding as needed
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  uploadAdhaar();
                  // Handle the tap on the TextFormField if needed
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: const Row(
                    children: [
                      Icon(Icons.upload_file),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Upload Adhaar',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      pickedImagePath != null
          ? Image.file(
              pickedImagePath!,
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            )
          : Container(),
    
  


                        ],
                      ),
                    ),
                        
                    const SizedBox(
                      height: 10,
                    ),

                    //===================================== Save Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        button(
                            buttonText: 'Save',
                            buttonPressed: () async {
                              if (formkey.currentState!.validate()) {
                                await setRoomStatus(widget.roomId);
                                // ignore: use_build_context_synchronously
                                await addUser(context, widget.roomId);
                              }
                            })
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

  //===================================== CheckIn Function
  Future<void> selectedCheckedIN(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        seletedCheckInDate = pickedDate;
        checkInController.text = DateFormat("dd/MM/yyyy").format(pickedDate);

      });
    }
  }

  //===================================== CheckOut Function
  Future<void> selectedCheckedOut(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        seletedCheckoutDate = pickedDate;
        checkOutController.text = DateFormat("dd/MM/yyyy").format(pickedDate);
      });
    } else {
      setState(() {
        seletedCheckoutDate = null;
        checkOutController.text = "Indefinite";
      }
      );
    }
  }

  //===================================== PickImage Function
  Future<void> pickImage() async {
    final XFile? pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        pickedImage = File(pickedFile.path);
        imgPath = pickedFile.path;
      });
    }
  }

  Future<void> uploadAdhaar() async {
    final XFile? pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        pickedImagePath = File(pickedFile.path);
        imgPath2 = pickedFile.path;
      });
    }
  }

  //===================================== AddUser Function
  Future<void> addUser(BuildContext context, int id) async {
    final name = nameController.text.trim();
    final phoneNumber = phoneNumberController.text.trim();
    // final uploadAdhaar = uploadAdhaarController.text.trim();
    final occupation = occupationController.text.trim();
    final checkin = checkInController.text.trim();
    final checkout = checkOutController.text.trim();
    final advanceAmount = advanceAmounntController.text.trim();
    final image = imgPath;
    final image2 = imgPath2;
    if (name.isEmpty ||
        phoneNumber.isEmpty ||
        // uploadAdhaar.isEmpty ||
        occupation.isEmpty ||
        checkin.isEmpty ||
        checkout.isEmpty ||
        image.isEmpty) {
      return;
    }

    final addUser = UserModel(
      roomId: id,
        ispaid: false,
        name: name,
        phoneNumber: phoneNumber,
        uploadAdhaar: image2,
        occupation: occupation,
        checkin: checkin,
        checkout: checkout=='Indefinite'?null:checkout,
        advanceAmount: advanceAmount,
        image: image);

    await addUserAsync(addUser, id);
    final roomIdData = await fetchRoomIdData();

    if (roomIdData != null) {
      roomIdData.isOccupied = true;
      await updateRoomAsync(roomIdData, roomIdData.id);
    }
    // print('$roomIdData');
    // ignore: use_build_context_synchronously
    customSnackBar(context, 'Tenant Details Added SuccesFully',
  Color(0xFF5E47DD));
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const UserList()));
    });
  }

  fetchRoomIdData() {}
}
