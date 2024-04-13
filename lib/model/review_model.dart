import 'package:hive/hive.dart';
part 'review_model.g.dart';
@HiveType(typeId: 4)
class NoteModel extends HiveObject {
  @HiveField(0)
  final int? roomId;
  @HiveField(1)
  final int? userId;
  @HiveField(2)
  final String checkin;
  @HiveField(3)
  final String checkout;
  @HiveField(4)
  final String rent;

  NoteModel({required this.roomId, required this.userId, required this.checkin, required this.checkout, required this.rent});
}
