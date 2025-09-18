import 'package:flutter/material.dart';
import 'package:room_rent_app/category/occupied.dart';
import 'package:room_rent_app/category/paid.dart';
import 'package:room_rent_app/category/unoccupied.dart';
import 'package:room_rent_app/category/unpaid.dart';
import 'package:room_rent_app/screens/About.dart/about.dart';
import 'package:room_rent_app/screens/notes/notes.dart';
import 'package:room_rent_app/screens/Revenue/revenue.dart';
import 'package:room_rent_app/screens/room/add_room.dart';
import 'package:room_rent_app/screens/user/user_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  void _addRoom() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddRoom(tabController: _tabController),
      ),
    );
  }

  Widget _getScreen(int index) {
    switch (index) {
      case 0:
        return Column(
          children: [
            Container(
              color: const Color(0xffF7F6FF),
              child: Column(
                children: [
                 Container(
  height: 56,
  color: const Color(0xFF5E47DD),
  padding: const EdgeInsets.symmetric(horizontal: 16),
  child: Row(
    children: [
      Expanded(
        child: Center(
          child: Text(
            "Home",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      IconButton(
        icon: const Icon(Icons.info_outline, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AboutApp()),
          );
        },
      ),
    ],
  ),
),

                  TabBar(
                    controller: _tabController,
                    indicatorColor: const Color(0xFF5E47DD),
                    labelColor: const Color(0xFF5E47DD),
                    unselectedLabelColor: const Color(0xFF5E47DD),
                    labelStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    indicator: const UnderlineTabIndicator(
                      borderSide:
                          BorderSide(width: 5, color: Color(0xFF5E47DD)),
                      insets: EdgeInsets.symmetric(horizontal: 50),
                    ),
                    tabs: const [
                      Tab(text: 'Unoccupied'),
                      Tab(text: 'Occupied'),
                      Tab(text: 'Paid'),
                      Tab(text: 'Unpaid'),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  Unoccupied(),
                  Occupied(),
                  Paid(),
                  Unpaid(),
                ],
              ),
            ),
          ],
        );

      case 1:
        return const Notes();

      case 3:
        return const Revenue();

      case 4:
        return const UserList();

      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // Root Scaffold without AppBar
        body: _getScreen(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFF5E47DD),
          unselectedItemColor: const Color(0xFF7D7F88),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle:
              const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          unselectedLabelStyle:
              const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.note_alt_outlined), label: "Notes"),
            BottomNavigationBarItem(icon: SizedBox(width: 60), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.money_sharp), label: "Revenue"),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: "Tenants"),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addRoom,
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
