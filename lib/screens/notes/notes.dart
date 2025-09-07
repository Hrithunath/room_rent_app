import 'package:flutter/material.dart';
import 'package:room_rent_app/model/notes_model.dart';
import 'package:room_rent_app/screens/notes/add_notes.dart';
import 'package:room_rent_app/screens/notes/note_details.dart';
import 'package:room_rent_app/services/notes_services.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  void initState() {
    getnotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotesForm()));
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: notesNotifier,
        builder: (BuildContext context, List<NoteModel> notesList, Widget? child) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: notesList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NoteDetails(note: notesList[index]),
                    ));
                  },
                  child: Card(
                   
                    elevation: 10,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: SizedBox(
                        height: 45,
                        
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notesList[index].title,
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
                              ),
                              SizedBox(height: 5),
                              Text(
                                notesList[index].description,
                                style: const TextStyle(fontSize: 16,),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
