import 'package:flutter/material.dart';
import 'package:room_rent_app/category/occupied.dart';
import 'package:room_rent_app/category/paid.dart';
import 'package:room_rent_app/category/unoccupied.dart';
import 'package:room_rent_app/category/unpaid.dart';
import 'package:room_rent_app/screens/notes/notes.dart';
import 'package:room_rent_app/screens/About.dart/about.dart';
import 'package:room_rent_app/screens/Revenue/revenue.dart';
import 'package:room_rent_app/screens/room/add_room.dart';
import 'package:room_rent_app/screens/user/user_list.dart';
import 'package:room_rent_app/services/room_services.dart';
import 'package:room_rent_app/services/user_services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;
  int? id;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    getRoom();
    getuser();
  }

  @override
  Widget build(BuildContext context) {
    // getRoom();
    return SafeArea(
      child: Scaffold(
       
        appBar: AppBar(
          title: const Text('Home'),
          leading: IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AboutApp()));
          }, icon: const Icon(Icons.info_outline,color: Colors.black,)),
          bottom: TabBar(
              controller: _tabController,
              indicatorColor:  const Color(0xFF0C2D57),
              indicatorWeight: 5,
              labelColor:  const Color(0xFF0C2D57),
              unselectedLabelColor:const Color(0xFFEFECEC),
              tabs: const [
                Tab(text: 'Unoccupied '),
                Tab(text: 'Occupied'),
                Tab(text: 'Paid'),
                Tab(text: 'Unpaid'),
              ]),
        ),

        //===================================== TabBarView
        body: TabBarView(
          controller: _tabController,
          children: const [
            Unoccupied(),
            Occupied(),
            Paid(),
            Unpaid(),
          ],
        ),
        //===================================== BottomNavigationBar
   bottomNavigationBar: BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
     backgroundColor:     Colors.indigo,
     currentIndex: _selectedIndex,
     selectedItemColor:  const Color(0xFF0C2D57),
     unselectedItemColor:const Color(0xFFEFECEC),
     showSelectedLabels: true, // Show labels for the selected item
     showUnselectedLabels: true, // Show labels for the unselected items
     onTap: onItemTapped,
     items: const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "Home",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.note_alt_outlined),
      label: "Note",
    ),
    BottomNavigationBarItem(
      icon: SizedBox(width: 60),
      label: '', // Empty label for spacing
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.money_sharp),
      label: "Revenue",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.people),
      label: "Tenants",
    ),
     ],
   ),


        //===================================== FloatingActionButton
        floatingActionButton: FloatingActionButton(
          onPressed: () => addRoom(),
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

 void onItemTapped(int index) {
  setState(() {
    _selectedIndex = index;
    _selectedIndex = index;
    switch (index) {
      case 0:
        //============================== Navigate to Home screen
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  Notes()));
        break;
      case 2:
        //============================== SizedBox in index 2, so it's just spacing,
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Revenue()));
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const UserList()));
        break;
    }
  

  });
}


  //===================================== AddRoom Navigation
  void addRoom() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddRoom(
                tabController: _tabController,
              )),
    );
  }
}
