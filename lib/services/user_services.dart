// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, duplicate_ignore

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:room_rent_app/model/room_model.dart';
import 'package:room_rent_app/model/user_model.dart';
import 'package:room_rent_app/services/revenue_services.dart';
import 'package:room_rent_app/services/room_services.dart';

ValueNotifier<List<UserModel>> userNotifier = ValueNotifier([]);
ValueNotifier<List<UserModel>> ispaidNotifier = ValueNotifier([]);
ValueNotifier<List<UserModel>> isunpaidNotifier = ValueNotifier([]);

//===================================== AddUser
Future<void> addUserAsync(UserModel value, int roomId) async {
  final userDB = await Hive.openBox<UserModel>('user_db');
  final userId = await userDB.add(value);
  value.id = userId;
  await userDB.put(value.id, value);
  final roomDB = await Hive.openBox<RoomModel>('room_db');
  RoomModel? room = roomDB.get(roomId);
  RoomModel temp = RoomModel(
    id: room!.id,
    userId: userId,
    room: room.room,
    floor: room.floor,
    guests: room.guests,
    bed: room.bed,
    rent: room.rent,
    image: room.image,
    isOccupied: room.isOccupied,
  );
  await roomDB.put(roomId, temp);
  await getRoom();
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  userNotifier.notifyListeners();
}

//=====================================UpdateRoom
Future<void> updateUserAsync(UserModel editUser, id) async {
  final userDB = await Hive.openBox<UserModel>('user_db');
  log(id.toString());
  try {
    await userDB.put(id, editUser);
  } catch (e) {
    log('error');
    log(e.toString());
  }
}

//===================================== GetUser
Future<void> getuser() async {
  final userDB = await Hive.openBox<UserModel>('user_db');
  userNotifier.value.clear();
  ispaidNotifier.value.clear();
  isunpaidNotifier.value.clear();

  Future.forEach(userDB.values, (element) {
    if (element.ispaid) {
      ispaidNotifier.value.add(element);
    } else {
      isunpaidNotifier.value.add(element);
    }
  });
  userNotifier.value.addAll(userDB.values);
  // ignore: invalid_use_of_visible_for_testing_member
  userNotifier.notifyListeners();
  ispaidNotifier.notifyListeners();
  isunpaidNotifier.notifyListeners();
}

//==================================setuserStatus
Future<void> setuserStatus(int id) async {
  final userDB = await Hive.openBox<UserModel>('user_db');
  await Future.forEach(userDB.values, (element) async {
    if (element.id == id) {
      UserModel data = element;
      data.ispaid = !data.ispaid;
      await userDB.put(id, data);
      final roomDB = await Hive.openBox<RoomModel>('room_db');
      RoomModel? room = roomDB.get(data.roomId);
      await addRevenue(data, room!);
      return;
    }
  });
  await getuser();
}

//=====================================DeleteUser
Future<void> deleteuser(int id) async {
  final userDB = await Hive.openBox<UserModel>('user_db');
  await userDB.delete(id);
  await getuser();
  userNotifier.notifyListeners();
}

//====================================================SearchText
Future<List<UserModel>> searchText(String searchText) async {
  final userDB = await Hive.openBox<UserModel>('user_db');

  final results = userDB.values
      .where((user) =>
          user.name.contains(searchText) ||
          user.phoneNumber.contains(searchText))
      .toList();

  return results;
}

// ============================================DisposeUser
Future<void> disposeUser(int? userId, int? roomId) async {
  log('entered dispose user');
  log('$roomId');
  
  if (roomId != null) {
    log('entered if condition');
    await setRoomUnoccupied(roomId);
    // Set room as unoccupied
  }

  final userDB = await Hive.openBox<UserModel>('user_db');
  // Delete user from the original box
  await userDB.delete(userId);
  await getuser();
  // Update user information after deletion
  await getRoom();
}