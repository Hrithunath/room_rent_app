// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:room_rent_app/widgets/refactor_button.dart';
// import 'package:room_rent_app/widgets/refactor_text.dart';

// class OccupiedFullDetails extends StatefulWidget {
//   const OccupiedFullDetails({super.key});

//   @override
//   State<OccupiedFullDetails> createState() => _OccupiedFullDetailsState();
// }

// class _OccupiedFullDetailsState extends State<OccupiedFullDetails> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Full Details'),
//       ),
//       body: Center(
//         child: SizedBox(
//           width: 300,
//           height: 550,
//           child: Card(
//             elevation: 30,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20.0),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   CircleAvatar(
//                     radius: 50,
//                     backgroundImage: FileImage(File(widget.userModel.image)),
//                   ),
//                   const SizedBox(height: 20),

//                   //===================================== name
//                   customText('Name', widget.userModel.name, null),
//                   const SizedBox(height: 10),

//                   //===================================== PhoneNumber
//                   customText(
//                       'Phone Number', widget.userModel.phoneNumber, null),
//                   const SizedBox(height: 10),

//                   //===================================== UploadAdhaar
//                   customText(
//                     'UploadAdhaar',
//                     'Adhaar',

//                     //===================================== IconImage Button
//                     IconButton(
//                       onPressed: () {
//                         showUploadAdhaar(
//                             context, widget.userModel.uploadAdhaar);
//                       },
//                       icon: const Icon(Icons.image_outlined),
//                     ),
//                   ),
//                   const SizedBox(height: 10),

//                   //===================================== Occupation
//                   customText('Occupation', widget.userModel.occupation, null),
//                   const SizedBox(height: 10),

//                   //===================================== CheckIn
//                   customText('CheckIn', widget.userModel.checkin, null),
//                   const SizedBox(height: 10),

//                   //===================================== CheckOut
//                   customText('CheckOut', widget.userModel.checkout, null),
//                   const SizedBox(height: 10),

//                   //===================================== AdvanceAmount
//                   customText(
//                       'Advance Amount', widget.userModel.advanceAmount, null),

//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       button(buttonText: 'Dispose', buttonPressed: () {}),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       button(buttonText: 'Paid', buttonPressed: () {})
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
