// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, duplicate_ignore

import 'dart:developer';
import 'package:intl/intl.dart';

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
 // ignore: invalid_use_of_visible_for_testing_member
 roomNotifier.notifyListeners();
}

//=====================================UpdateRoom
Future<void> updateRoomAsync(editRoom, id) async {
  final roomDB = await Hive.openBox<RoomModel>('room_db');
  await roomDB.put(editRoom.id, editRoom);
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

//=================================SetRoomStatus
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

//==================================================fetchuserById
Future<UserModel?> fetchUserById(String userId) async {
  log(userId);
  final userBox = await Hive.openBox<UserModel>('user_db');
  final data = userBox.get(int.parse(userId));
  return data;
}

//=====================================CheckRoomNo
bool ischeckroomNo(String roomId) {
  for (final room in roomNotifier.value) {
    if (room.room == roomId) {
      return true;
    }
  }
  return false;
}

//===================================== DeleteRoom
Future<void> deleteroom(int id) async {
  final roomDB = await Hive.openBox<RoomModel>('room_db');
  await roomDB.delete(id);
  await getRoom();
  roomNotifier.notifyListeners();
}


//===============================================get revenue
Future<double> getRevenue(String fromDate, String toDate) async {
  final roomDB = await Hive.openBox<RoomModel>('room_db');
  final df = DateFormat('MM d, yyyy');

  DateTime fromDateParsed;
  DateTime toDateParsed;

  try {
    fromDateParsed = df.parse(fromDate);
    toDateParsed = df.parse(toDate);
  } catch (e) {
    // ignore: avoid_print
    print('Error parsing date: $e');
    return 0.0;
  }

  double totalRoomRevenue = 0.0;
  for (var room in roomDB.values) {
    if (room.isOccupied) {
      final userModel = await fetchUserById(room.userId.toString());
      if (userModel != null) {
        try {
          DateTime checkInDate = df.parse(userModel.checkin);
          if (checkInDate
                  .isAfter(fromDateParsed.subtract(const Duration(days: 1))) &&
              checkInDate.isBefore(toDateParsed.add(const Duration(days: 1)))) {
            totalRoomRevenue += double.parse(room.rent);
          }
        } catch (e) {
          // ignore: avoid_print
          print('Error parsing check-in date: $e');
        }
      }
    }
  }

  return totalRoomRevenue;
}

//================================================RoomUnoccupied Dispose
Future<void> setRoomUnoccupied(int? roomId) async {
  final roomDB = await Hive.openBox<RoomModel>('room_db');

  final room = roomDB.get(roomId);
  if (room == null) {
   
    // ignore: avoid_print
    print('Room not found');
    return;
  }
  room.isOccupied = false;
  await roomDB.put(roomId, room);
  getRoom();
}
