import 'package:flutter/material.dart';
import 'package:room_rent_app/model/notes_model.dart';
import 'package:room_rent_app/services/notes_services.dart';

class NoteDetails extends StatefulWidget {
  final NoteModel note;

  const NoteDetails({Key? key, required this.note}) : super(key: key);

  @override
  State<NoteDetails> createState() => _NoteDetailsState();
}

class _NoteDetailsState extends State<NoteDetails> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _descriptionController = TextEditingController(text: widget.note.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Note' : 'Note Details'),
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              setState(() {
                if (isEditing) {
                  // Save changes
                  widget.note.title = _titleController.text;
                  widget.note.description = _descriptionController.text;
                  
                  // Update note in the database
                  updatenotes(widget.note, widget.note.id);
                }
                isEditing = !isEditing;
              });
            },
          ),
          if (!isEditing)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Delete Note"),
                      content: Text("Are you sure you want to delete this note?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            // Delete note from the database
                            deletenotes(widget.note.id);
                            Navigator.of(context).pop();
                            Navigator.of(context).pop(); // Pop twice to return to previous screen
                          },
                          child: Text("Delete"),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isEditing)
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
              )
            else
              Text(
                widget.note.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            SizedBox(height: 10),
            if (isEditing)
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                maxLines: null,
              )
            else
              Text(
                widget.note.description,
                style: const TextStyle(fontSize: 18),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}