
import 'package:flutter/material.dart';
import 'package:room_rent_app/model/notes_model.dart';
import 'package:room_rent_app/services/notes_services.dart';

class NoteDetails extends StatefulWidget {
  final NoteModel note;

  const NoteDetails({super.key, required this.note});

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
                  widget.note.title = _titleController.text;
                  widget.note.description = _descriptionController.text;
                  updatenotes(widget.note, widget.note.id);
                }
                isEditing = !isEditing;
              });
            },
          ),
          if (!isEditing)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Delete Note"),
                      content: const Text("Are you sure you want to delete this note?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            deletenotes(widget.note.id);
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: const Text("Delete"),
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
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
              )
            else
              Text(
                widget.note.title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0C2D57),),
              ),
            const SizedBox(height: 10),
            if (isEditing)
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                maxLines: null,
              )
            else
              Expanded(
                child: Text(
                  widget.note.description,
                  style: const TextStyle(fontSize: 18, color: Color(0xFF0C2D57),),
                  
                ),
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
