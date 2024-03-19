import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:room_rent_app/model/user_model.dart';

ValueNotifier<List<UserModel>> userNotifier = ValueNotifier([]);

//===================================== AddUser
Future<void> addUserAsync(UserModel value) async {
  print('enter function');
  final userDB = await Hive.openBox<UserModel>('user_db');
  final userId = await userDB.add(value);
  value.id = userId;
  await userDB.put(value.id, value);
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
  // roomNotifier.value.clear(); // Clear the list before updating
  // roomNotifier.value.addAll(roomDB.values);
  // roomNotifier.notifyListeners();
}

//===================================== GetUser
Future<void> getuser() async {
  final userDB = await Hive.openBox<UserModel>('user_db');
  userNotifier.value.clear();
  userNotifier.value.addAll(userDB.values);
  userNotifier.notifyListeners();
}

//=====================================DeleteUser
Future<void> deleteuser(int id) async {
  final userDB = await Hive.openBox<UserModel>('user_db');
  await userDB.delete(id);
  await getuser();
  userNotifier.notifyListeners();
}
