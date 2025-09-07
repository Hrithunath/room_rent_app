// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, duplicate_ignore

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:room_rent_app/model/room_model.dart';
import 'package:room_rent_app/model/user_model.dart';
import 'package:room_rent_app/services/revenue_services.dart';

ValueNotifier<List<RoomModel>> roomNotifier = ValueNotifier([]);
ValueNotifier<List<RoomModel>> occupiedroomNotifier = ValueNotifier([]);
ValueNotifier<List<RoomModel>> unoccupiedroomNotifier = ValueNotifier([]);

//=====================================AddRoom
Future<void> addRoomAsync(RoomModel value) async {
  final roomDB = await Hive.openBox<RoomModel>('room_db');
  final roomId = await roomDB.add(value);
  value.id = roomId;
  await roomDB.put(value.id, value);
  await getRoom(); 
}

//=====================================UpdateRoom
Future<void> updateRoomAsync(editRoom, id) async {
  final roomDB = await Hive.openBox<RoomModel>('room_db');
  await roomDB.put(editRoom.id, editRoom);
  await getRoom();
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
    roomNotifier.value.add(element);
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
  await getRevenue();
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
  // ignore: avoid_print
  print('check ${roomNotifier.value.length}');
  for (final room in roomNotifier.value) {
    // ignore: avoid_print
    print('check $roomId');

    // ignore: avoid_print
    print('check ${room.room}');
    if (room.room == roomId) {
      // ignore: avoid_print

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

//================================================ change to unoccupied
Future<void> setRoomUnoccupied(int? roomId) async {
  final roomDB = await Hive.openBox<RoomModel>('room_db');
  final room = roomDB.get(roomId);
  if (room == null) {
    await roomDB.close();
    return;
  }
  room.isOccupied = false;
  await roomDB.put(roomId, room);
  await roomDB.close();
  await getRoom();
}
