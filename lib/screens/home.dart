import 'package:flutter/material.dart';
import 'package:room_rent_app/category/occupied.dart';
import 'package:room_rent_app/category/paid.dart';
import 'package:room_rent_app/category/unoccupied.dart';
import 'package:room_rent_app/category/unpaid.dart';
import 'package:room_rent_app/screens/info.dart/about.dart';
import 'package:room_rent_app/screens/revenue.dart';
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Home'),
          leading: IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const About()));
          }, icon: Icon(Icons.info_outline,color: Colors.white,)),
          bottom: TabBar(
              controller: _tabController,
              indicatorColor: Colors.blue,
              indicatorWeight: 5,
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.white,
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
          children: [
            Unoccupied(tabController: _tabController),
            Occupied(tabController: _tabController),
            const Paid(),
            const Unpaid(),
          ],
        ),

        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.amber,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.indigo,
          onTap: onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.grey,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.filter_alt_outlined,
                  color: Colors.grey,
                ),
                label: "Filter"
                ),
            BottomNavigationBarItem(
                icon: SizedBox(
                  width: 60,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.money_sharp,
                  color: Colors.grey,
                ),
                label: "Revenue"
                ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.people,
                  color: Colors.grey,
                ),
                label: "Users"
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
      if(index == 1){
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Home()));
      }
     else if (index == 2) {
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => Revenue()));
      } else if (index == 3) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Revenue()));
      } else if (index == 4) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const UserList()));
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
