import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:room_rent_app/model/room_model.dart';
import 'package:room_rent_app/model/user_model.dart';

ValueNotifier<List<RoomModel>> roomNotifier = ValueNotifier([]);
ValueNotifier<List<RoomModel>> occupiedroomNotifier = ValueNotifier([]);
ValueNotifier<List<RoomModel>> unoccupiedroomNotifier = ValueNotifier([]);
//=====================================AddRoom
Future<void> addRoomAsync(RoomModel value) async {
  final roomDB = await Hive.openBox<RoomModel>('room_db');
  final roomId = await roomDB.add(value);
  value.id = roomId;
  await roomDB.put(value.id, value);

  roomNotifier.notifyListeners();
}

//=====================================UpdateRoom
Future<void> updateRoomAsync(editRoom, id) async {
  final roomDB = await Hive.openBox<RoomModel>('room_db');
  await roomDB.put(editRoom.id, editRoom);
  // roomNotifier.value.clear(); // Clear the list before updating
  // roomNotifier.value.addAll(roomDB.values);
  // roomNotifier.notifyListeners();
}

//=====================================FetchRoomById
Future<RoomModel?> fetchRoomById(int? roomId) async {
  final roomDB = await Hive.openBox<RoomModel>('room_db');
  final List<RoomModel> rooms =
      roomDB.values.where((room) => room.id == roomId).toList();
  return rooms.isNotEmpty ? rooms.first : null;
}

//=====================================GetRoom
Future<void> getRoom() async {
  final roomDB = await Hive.openBox<RoomModel>('room_db');
  roomNotifier.value.clear();
  occupiedroomNotifier.value.clear();
  unoccupiedroomNotifier.value.clear();
  Future.forEach(roomDB.values, (element) {
    if (element.isOccupied) {
      occupiedroomNotifier.value.add(element);
    } else {
      unoccupiedroomNotifier.value.add(element);
    }
  });


  occupiedroomNotifier.notifyListeners();
  unoccupiedroomNotifier.notifyListeners();
  roomNotifier.notifyListeners();
}

Future<void> setRoomStatus(int id) async {
  final roomDB = await Hive.openBox<RoomModel>('room_db');
  await Future.forEach(roomDB.values, (element) async {
    if (element.id == id) {
      RoomModel data = element;
      data.isOccupied = !data.isOccupied;
      await roomDB.put(id, data);
      return;
    }
  });
  await getRoom();
}

Future<UserModel?> fetchUserById(String userId) async {
  log(userId);
  final userBox = await Hive.openBox<UserModel>('user_db');
  final data = userBox.get(int.parse(userId));
  return data;
}

bool ischeckroomNo(String roomId) {
  for (final room in roomNotifier.value) {
    if (room.room == roomId) {
      return true;
    }
  }
  return false;
}

//=====================================GetRoom
Future<void> deleteroom(int id) async {
  final roomDB = await Hive.openBox<RoomModel>('room_db');
  await roomDB.delete(id);
  await getRoom();
  roomNotifier.notifyListeners();
}

// Future<double> getrevenue(String fromDate, String toDate) async {
//   final roomDB = await Hive.openBox<RoomModel>('room_db');
//   final df = DateFormat('MMM d, yyyy'); // Specify the expected format
//   DateTime fromdate = df.parse(fromDate);
//   DateTime todate = df.parse(toDate);

//   final occupiedRooms = roomDB.values.where((element) => element.isOccupied == true);

//   final roomsWithinRange = fromdate != todate
//       ? occupiedRooms.where((element) =>
//           df.parse(element.dateOccupied!).isAfter(fromdate.subtract(const Duration(days: 1))) &&
//           df.parse(element.dateOccupied!).isBefore(todate.add(const Duration(days: 1))))
//       : occupiedRooms.where((element) => df.parse(element.dateOccupied!) == todate);

//   double totalRoomRevenue = 0.0;
//   for (var room in roomsWithinRange) {
//     totalRoomRevenue = totalRoomRevenue + room.roomRate;
//   }
//   roomNotifier.value.clear();
//   roomNotifier.value.addAll(roomsWithinRange.toList()); // Convert to list before adding to the notifier
//   roomNotifier.notifyListeners();
//   return totalRoomRevenue;
// }