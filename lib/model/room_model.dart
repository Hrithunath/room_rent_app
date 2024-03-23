import 'package:hive/hive.dart';
import 'package:room_rent_app/category/occupied.dart';
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
  final String rent;
  @HiveField(6)
  final String image;
  @HiveField(7)
  final int? userId;
  @HiveField(8)
  bool isOccupied;
  RoomModel(
      {required this.room,
      required this.floor,
      required this.guests,
      required this.bed,
      required this.rent,
      required this.image,
      this.id,
      this.userId,
      this.isOccupied = false});
}
