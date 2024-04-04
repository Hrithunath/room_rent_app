import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:room_rent_app/model/notes_model.dart';

ValueNotifier<List<NoteModel>> notesNotifier = ValueNotifier([]);
Future<void> addnotes(noteModel,value) async {
  final notesDB = await Hive.openBox('notesdb');
  final notesId = await notesDB.add(value);
  value.id = notesId;
  await notesDB.put(value.id, value);
}

Future<void> getnotes() async {
  final notesDB = await Hive.openBox<NoteModel>('notesdb');
  notesNotifier.value.clear();
  notesNotifier.value.addAll(notesDB.values);  
  notesNotifier.notifyListeners();
}