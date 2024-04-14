import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:room_rent_app/model/revenue_model.dart';
import 'package:room_rent_app/model/room_model.dart';
import 'package:room_rent_app/model/user_model.dart';
import 'package:room_rent_app/services/room_services.dart';

ValueNotifier<List<RevenueModel>> revenueNotifier = ValueNotifier([]);

//==============================================================copyUserDataToRevenue
addRevenue(UserModel user, RoomModel room) async {
  final revenue = RevenueModel(
    roomId: user.roomId,
    userId: user.id,
    datePaided: DateFormat("dd/MM/yyyy").format(DateTime.now()),

    image: room.image,
    rent: double.parse(room.rent.toString()),
    isOccupied: room.isOccupied,
    room: room.room,
    floor: room.floor,
  );
  final revenueDB = await Hive.openBox<RevenueModel>('revenue_db');
   await revenueDB.add(revenue);
  await getRevenue();
}

//==============================================================================getRevenue
Future<double> getRevenue({DateTime? fromDate, DateTime? toDate}) async {
  final revenueDB = await Hive.openBox<RevenueModel>('revenue_db');
  List<RevenueModel> revenueList = [];
  double totalRoomRevenue = 0.0;

  revenueNotifier.value.clear();

  try {
    for (var room in revenueDB.values) {
      print(room.datePaided);
      if (fromDate == null && toDate == null) {
        revenueList.add(room);
        totalRoomRevenue += room.rent;
      } else {
        final date = DateFormat("dd/MM/yyyy").parse(room.datePaided);
        if (date.isAfter(fromDate!.subtract(const Duration(days: 1))) &&
            date.isBefore(toDate!.add(const Duration(days: 1)))) {
          revenueList.add(room);
          totalRoomRevenue += room.rent;
        }
      }
    }
    print('revenueList: $revenueList');
    revenueNotifier.value = revenueList;
    revenueNotifier.notifyListeners(); // Notify listeners after updating the value
  } catch (e) {
    print('Error calculating revenue: $e');
    return 0.0;
  }

  return totalRoomRevenue;
}
