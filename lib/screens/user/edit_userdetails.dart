import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:room_rent_app/model/user_model.dart';
import 'package:room_rent_app/screens/user/user_details.dart';
import 'package:room_rent_app/screens/user/user_list.dart';
import 'package:room_rent_app/services/user_services.dart';
import 'package:room_rent_app/widgets/refactor_button.dart';
import 'package:room_rent_app/widgets/refactor_calender.dart';
import 'package:room_rent_app/widgets/refactor_delete.dart';
import 'package:room_rent_app/widgets/refactor_snackbar.dart';
import 'package:room_rent_app/widgets/refactor_text_feild.dart';

class EditUser extends StatefulWidget {
  final UserModel? userModel;

  const EditUser({
    super.key,
    required this.userModel,
  });

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final formkey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final uploadAdhaarController = TextEditingController();
  final occupationController = TextEditingController();
  final checkInController = TextEditingController();
  final checkOutController = TextEditingController();
  final advanceAmounntController = TextEditingController();

  DateTime? seletedCheckInDate;
  DateTime? seletedCheckoutDate;

  final ImagePicker _imagePicker = ImagePicker();
  File? pickedImage;
  String imgPath = '';
  String imgPath2 = '';
  @override
  void initState() {
    super.initState();

    nameController.text = widget.userModel!.name;
    phoneNumberController.text = widget.userModel!.phoneNumber;
    uploadAdhaarController.text = widget.userModel!.uploadAdhaar;
    occupationController.text = widget.userModel!.occupation;
    checkInController.text = widget.userModel!.checkin;
    checkOutController.text = widget.userModel!.checkout ?? '';
    advanceAmounntController.text = widget.userModel!.advanceAmount;
    imgPath = widget.userModel!.image;
  }

  @override
  Widget build(BuildContext context) {
    int? id = widget.userModel!.id;
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Tenant Details')),
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
                              : FileImage(File(widget.userModel!.image))),
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

                    //===================================== PhoneNumber
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
                   
                    customTextfeild(
                        controller: uploadAdhaarController,
                        keyboardTYpe: TextInputType.name,
                        labelText: 'uploadAdhaar',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Upload Adhaar is Required';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction),

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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),

                            //===================================== CheckOut
                            child: TextFormField(
                              controller: checkOutController,
                              keyboardType: TextInputType.none,
                              onTap: () {
                                selectedCheckedOut(context);
                              },
                              decoration: InputDecoration(
                                labelText: 'Check Out',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                suffixIcon: GestureDetector(
                                  child: const Icon(Icons.calendar_month),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    //===================================== AdvanceAmount
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //===================================== DeleteButton
                        button(
                          buttonText: 'Delete',
                          buttonPressed: () {
                            if (id != null) {
                              deleteAlert(context, id);
                            }
                          },
                        ),
                        const SizedBox(width: 10),

                        //===================================== Save
                        button(
                          buttonText: 'Save',
                          buttonPressed: () {
                            editUser(context, id);
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
        checkInController.text = DateFormat.yMd().format(pickedDate);
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
        checkOutController.text = DateFormat.yMd().format(pickedDate);
      });
    } else {
      setState(() {
        seletedCheckoutDate = null;
        checkOutController.text = "Indefinite";
      });
    }
  }

  //===================================== UserImagePick Function
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

  //===================================== UploadAdhaarImage Function
  Future<void> uploadAdhaar() async {
    final XFile? pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        pickedImage = File(pickedFile.path);
        imgPath2 = pickedFile.path;
      });
    }
  }

  //===================================== EditUser Function
  Future<void> editUser(BuildContext context, int? id) async {
    if (formkey.currentState!.validate()) {
      final name = nameController.text.trim();
      final phoneNumber = phoneNumberController.text.trim();
      final uploadAdhaar = uploadAdhaarController.text.trim();
      final occupation = occupationController.text.trim();
      final checkin = checkInController.text.trim();
      final checkout = checkOutController.text.trim();
      final advanceAmount = advanceAmounntController.text.trim();
      final image = imgPath;

      if (name.isEmpty ||
          phoneNumber.isEmpty ||
          uploadAdhaar.isEmpty ||
          occupation.isEmpty ||
          checkin.isEmpty ||
          checkout.isEmpty ||
          image.isEmpty) {
        return;
      }

      final editUser = UserModel(
        ispaid: widget.userModel!.ispaid,
        id: widget.userModel!.id,
        name: name,
        phoneNumber: phoneNumber,
        uploadAdhaar: uploadAdhaar,
        occupation: occupation,
        checkin: checkin,
        checkout: checkout,
        advanceAmount: advanceAmount,
        image: imgPath.isEmpty ? widget.userModel!.image : imgPath,
      );

      await updateUserAsync(editUser, widget.userModel!.id);

      // ignore: use_build_context_synchronously
      customSnackBar(context, 'Edited Tenant Details SuccesFully',
          const Color(0xFF5E47DD));
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => UserDetails(userModel: editUser)),
        );
      });
    }
  }

  //===================================== ShowSnackbar Delete Function
  deleteAlert(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (context) {
        return DeleteAlert(
          onDelete: () async {
            await deleteuser(id);
            // ignore: use_build_context_synchronously
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) {
              return const UserList();
            }), (route) => false);
          },
        );
      },
    );
  }
}
