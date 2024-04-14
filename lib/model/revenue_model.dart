import 'package:hive/hive.dart';
part 'revenue_model.g.dart';

@HiveType(typeId: 4)
class RevenueModel extends HiveObject {
  @HiveField(0)
  final int? roomId;
  @HiveField(1)
  final int? userId;
  @HiveField(2)
  final double rent;
  @HiveField(3)
  final bool isOccupied;
  @HiveField(4)
  final String room;
  @HiveField(5)
  final String image;
  @HiveField(6)
  final String floor;
  @HiveField(7)
  final String datePaided;


  RevenueModel({
    this.roomId,
    this.userId,
    required this.rent,
    required this.isOccupied,
    required this.room,
    required this.image,
    required this.floor,
    required this.datePaided,
  });
}
