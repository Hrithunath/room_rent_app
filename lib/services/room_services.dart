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

Future<double> getRevenue(DateTime fromDate, DateTime toDate) async {
  final roomDB = await Hive.openBox<RoomModel>('room_db');

  double totalRoomRevenue = 0.0;
  try {
    for (var room in roomDB.values) {
      if (room.isOccupied) {
        final userModel = await fetchUserById(room.userId.toString());
        if (userModel != null) {
          DateTime checkInDate =
              DateFormat('M/d/yyyy').parse(userModel.checkin);
          if (checkInDate.isAfter(fromDate.subtract(const Duration(days: 1))) &&
              checkInDate.isBefore(toDate.add(const Duration(days: 1)))) {
            totalRoomRevenue += double.parse(room.rent);
          }
        }
      }
    }
  } catch (e) {
    print('Error calculating revenue: $e');
    return 0.0;
  }

  return totalRoomRevenue;
}

Future<List<RoomModel>> fetchRevenueList(
    DateTime fromDate, DateTime toDate) async {
  final roomDB = await Hive.openBox<RoomModel>('room_db');
  List<RoomModel> revenueList = [];

  try {
    for (var room in roomDB.values) {
      if (room.isOccupied) {
        final userModel = await fetchUserById(room.userId.toString());
        if (userModel != null) {
          DateTime checkInDate =
              DateFormat('M/d/yyyy').parse(userModel.checkin);
          if (checkInDate.isAfter(fromDate.subtract(const Duration(days: 1))) &&
              checkInDate.isBefore(toDate.add(const Duration(days: 1)))) {
            revenueList.add(room);
          }
        }
      }
    }
  } catch (e) {
    print('Error fetching revenue list: $e');
    return [];
  }

  return revenueList;
}

//================================================RoomUnoccupied Dispose
Future<void> setRoomUnoccupied(int? roomId) async {
  final roomDB = await Hive.openBox<RoomModel>('room_db');
  print('Room database opened successfully.');

  final room = await roomDB.get(roomId);
  if (room == null) {
    print('Room not found');
    await roomDB.close();
    return;
  }

  print('Before setting room unoccupied: ${room.isOccupied}');
  room.isOccupied = false;
  await roomDB.put(roomId, room);
  print('After setting room unoccupied: ${room.isOccupied}');

  await roomDB.close();
  print('Room database closed successfully.');

  await getRoom();
  print('Room information updated.');
}