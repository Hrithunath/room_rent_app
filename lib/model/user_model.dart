import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 2)
class UserModel extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String phoneNumber;
  @HiveField(3)
  final String uploadAdhaar;
  @HiveField(4)
  final String occupation;
  @HiveField(5)
  final String checkin;
  @HiveField(6)
  final String? checkout;
  @HiveField(7)
  final String advanceAmount;
  @HiveField(8)
  final String image;
  @HiveField(9)
  final int? roomId;
  @HiveField(10)
  bool ispaid;

  UserModel(
      {required this.name,
      required this.phoneNumber,
      required this.uploadAdhaar,
      required this.occupation,
      required this.checkin,
      this.checkout,
      required this.advanceAmount,
      required this.image,
      this.roomId,
      required this.ispaid,
      this.id});
}
