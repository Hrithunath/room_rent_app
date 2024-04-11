import 'package:flutter/material.dart';
import 'package:room_rent_app/model/notes_model.dart';
import 'package:room_rent_app/services/notes_services.dart';
import 'package:room_rent_app/widgets/refactor_text_feild.dart';

class NotesForm extends StatelessWidget {
  NotesForm({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
      //============================================ Title        
              customTextfeild(controller: titleController,
               keyboardTYpe: TextInputType.text, labelText: 'Title',
               validator: (value) {
                 if (value == null || value.isEmpty) {
                   return 'Title is Required';
                 }
                 return null;
               }, 
               autovalidateMode: AutovalidateMode.onUserInteraction, ),
              const SizedBox(height: 16.0),
      //============================================ Description        
             customTextfeild(controller: descriptionController,
              keyboardTYpe:TextInputType.text ,
               labelText: 'Description', 
               validator: (value) {
                 if (value == null || value.isEmpty) {
                   return 'Description is Required';
                 }
                 return null;
               },
                autovalidateMode: AutovalidateMode.onUserInteraction),
              const SizedBox(height: 16.0),
      //============================================ Add Note Button        
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    addNote(titleController.text, descriptionController.text);
                  Navigator.pop(context); // Close the form after adding a note
                  }
                  
                },
                child: const Text('Add Note'),
              ),
            ],
          ),
        ),
      ),
    );
  }
//============================================ Add Note Function
  void addNote(String title, String description) {
    
    NoteModel note = NoteModel(title: title, description: description);
    addnotes(note);
    // ignore: avoid_print
    print('notes:- $note');
  }
}