import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:room_rent_app/model/room_model.dart';
import 'package:room_rent_app/model/user_model.dart';
import 'package:room_rent_app/services/room_services.dart';

ValueNotifier<List<UserModel>> userNotifier = ValueNotifier([]);
ValueNotifier<List<UserModel>> ispaidNotifier = ValueNotifier([]);
ValueNotifier<List<UserModel>> isunpaidNotifier = ValueNotifier([]);

//===================================== AddUser
Future<void> addUserAsync(UserModel value, int roomId) async {
  print('enter function');
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
  userNotifier.notifyListeners();
  ispaidNotifier.notifyListeners();
  isunpaidNotifier.notifyListeners();
}

Future<void> setuserStatus(int id) async {
  final userDB = await Hive.openBox<UserModel>('user_db');
  await Future.forEach(userDB.values, (element) async {
    if (element.id == id) {
      UserModel data = element;
      data.ispaid = !data.ispaid;
      await userDB.put(id, data);
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


Future<List<UserModel>>searchText(String searchText)async{
 
  final UserDB= await Hive.openBox<UserModel>('user_db');
  
    final results=UserDB.values
    .where((user) =>
    
    user.name.contains(searchText)||
    user.phoneNumber.contains(searchText)
   ).toList();
   
    return results;
  
  }



Future<void> disposeUser(int? userId, int? roomId) async {
  final userDB = await Hive.openBox<UserModel>('user_db');

  // Delete the user from the database
  await userDB.delete(userId);

  // Mark the room as unoccupied
  if (roomId != null) {
    await setRoomUnoccupied(roomId);
  }

  // Update room and user lists
  await getuser();
  await getRoom();
}
