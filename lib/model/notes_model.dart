import 'package:hive/hive.dart';
part 'notes_model.g.dart';

@HiveType(typeId:1)
class NoteModel extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String description;

  NoteModel({required this.title, required this.description});
}
