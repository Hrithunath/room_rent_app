import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:room_rent_app/model/notes_model.dart';

ValueNotifier<List<NoteModel>> notesNotifier = ValueNotifier([]);

Future<void> addnotes(NoteModel noteModel) async {
  final notesDB = await Hive.openBox<NoteModel>('notesdb');
  // Use await to get the ID when adding to the database
  final notesId = await notesDB.add(noteModel);
  noteModel.id = notesId;
  await notesDB.put(notesId, noteModel);
}

Future<void> getnotes() async {
  final notesDB = await Hive.openBox<NoteModel>('notesdb');
  notesNotifier.value.clear();
  notesNotifier.value.addAll(notesDB.values);  
  notesNotifier.notifyListeners();
}
