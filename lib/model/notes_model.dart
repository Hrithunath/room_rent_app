import 'package:hive/hive.dart';

part 'notes_model.g.dart';

@HiveType(typeId: 3)
class NoteModel extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String description;
  
  @HiveField(2)
   int id;
  NoteModel({required this.title, required this.description,this.id=0 });
}
