import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:room_rent_app/model/notes_model.dart';

ValueNotifier<List<NoteModel>> notesNotifier = ValueNotifier([]);

Future<void> addnotes(NoteModel value) async {
  final notesDB = await Hive.openBox<NoteModel>('notesdb');
  // Use await to get the ID when adding to the database
  final notesId = await notesDB.add(value);
  value.id = notesId;
  await notesDB.put(notesId, value);
  // ignore: avoid_print
  print('added $notesId');
  await getnotes();
}

Future<void> getnotes() async {
  final notesDB = await Hive.openBox<NoteModel>('notesdb');
  notesNotifier.value.clear();
  notesNotifier.value.addAll(notesDB.values);
  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  notesNotifier.notifyListeners();
  // ignore: avoid_print
  print('get $notesDB');
}

Future<void> deletenotes(int id) async {
  final notesDB = await Hive.openBox<NoteModel>('notesdb');
  await notesDB.delete(id);
  await getnotes();
}

Future<void> updatenotes(NoteModel editNote, id) async {
  final notesDB = await Hive.openBox<NoteModel>('notesdb');
    await notesDB.put(id, editNote);
    await getnotes();
    
  }