import 'package:hive/hive.dart';
part 'room_model.g.dart';

@HiveType(typeId: 1)
class RoomModel extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final String room;
  @HiveField(2)
  final String floor;
  @HiveField(3)
  final String guests;
  @HiveField(4)
  final String bed;
  @HiveField(5)
  final double rent;
  @HiveField(6)
  final String image;
  @HiveField(7)
  final int? userId;
  @HiveField(8)
  bool isOccupied;
  @HiveField(9)
  final DateTime? dateOccupied;
  RoomModel(
      {required this.room,
      required this.floor,
      required this.guests,
      required this.bed,
      required this.rent,
      required this.image,
      this.id,
      this.userId,
      required this.isOccupied,
      this.dateOccupied});
}
