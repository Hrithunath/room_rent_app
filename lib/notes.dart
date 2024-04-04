// import 'package:flutter/material.dart';
// import 'package:room_rent_app/model/notes_model.dart';
// import 'package:room_rent_app/services/notes_services.dart';

// class Notes extends StatelessWidget {
//   const Notes({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       appBar: AppBar(
//         title: const Text('Notes'),
//       ),
//       body:  ValueListenableBuilder List<<NoteModel>>(
//         valueListenable: notesNotifier,
//         builder:(BuildContext, List<NoteModel>, Notes Widget? child) {
         
//           if (notesNotifier.value.isEmpty) {
//             return const Center(
              
//             );
//           }
//         }
//        return GridView.builder(gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           mainAxisSpacing: 10,
//           crossAxisSpacing:10 ),
//            itemBuilder: (context, index) {
             
//            }),
//       ),
//     );
  
// }