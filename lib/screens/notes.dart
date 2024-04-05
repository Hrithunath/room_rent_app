import 'package:flutter/material.dart';
import 'package:room_rent_app/model/notes_model.dart';
import 'package:room_rent_app/services/notes_services.dart';
import 'package:room_rent_app/widgets/refactor_text_feild.dart';

class Notes extends StatelessWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        // actions: [IconButton(onPressed: (){addnotes(noteModel, value)}, icon: const Icon(Icons.add))],
      ),
      body: ValueListenableBuilder(
        valueListenable: notesNotifier,
        builder: (BuildContext context, List<NoteModel> notesList, Widget? child) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: notesList.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 206, 242, 242),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Card(
                  child: Column(
                    children: [
                      Text(notesList[index].title),
                      Text(notesList[index].description),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class NotesForm extends StatelessWidget {
   NotesForm({super.key});

final titlecontroller = TextEditingController();
final descriptioncontroller = TextEditingController();
final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Notes'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            customTextfeild(controller: titlecontroller, keyboardTYpe: TextInputType.text, labelText: 'Title',  validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Title Is Required';
                      }
                      return null;
            }, autovalidateMode: AutovalidateMode.onUserInteraction),
            const SizedBox(height: 10,),
             customTextfeild(controller: descriptioncontroller, keyboardTYpe: TextInputType.text, labelText: 'Description',  validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Rent Is Required';
                      } else {
                        return null;
                      }
                    }, autovalidateMode: AutovalidateMode.onUserInteraction),
            const SizedBox(height: 10,),
            ElevatedButton(onPressed: (){}, child: Text('Add Note')),
          ],
        ),
      ),
    );
  }

  Future addNote() async {
    if (_formKey.currentState!.validate()) {
      NoteModel noteModel = NoteModel(title: titlecontroller.text.trim(), 
      description: descriptioncontroller.text.trim());
        
      // await addnotes(noteModel,value);

     }

  }
}