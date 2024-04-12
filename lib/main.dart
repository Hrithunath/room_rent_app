import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:room_rent_app/model/notes_model.dart';
import 'package:room_rent_app/model/room_model.dart';
import 'package:room_rent_app/model/user_model.dart';
import 'package:room_rent_app/screens/Home/splash.dart';
import 'package:room_rent_app/services/room_services.dart';
import 'package:room_rent_app/services/user_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(RoomModelAdapter().typeId)) {
    Hive.registerAdapter(RoomModelAdapter());
  }

  if (!Hive.isAdapterRegistered(UserModelAdapter().typeId)) {
    Hive.registerAdapter(UserModelAdapter());
  }
  if (!Hive.isAdapterRegistered(NoteModelAdapter().typeId)
  ) {
    Hive.registerAdapter(NoteModelAdapter());
  }
  await getuser();
  await getRoom();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
              color: Color(0xFFFC6736),
                titleTextStyle: TextStyle(
                    color: Color(0xFFEFECEC),
                    fontWeight: FontWeight.w900,
                    fontSize: 20),
                    iconTheme: IconThemeData( color: Color(0xFF0C2D57),),
                centerTitle: true)),
        home: const SplashScreen());
  }
}
