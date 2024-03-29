import 'package:flutter/material.dart';
import 'package:room_rent_app/model/room_model.dart';

class Revenue extends StatefulWidget {
  const Revenue({super.key});

  @override
  State<Revenue> createState() => _RevenueState();
}

class _RevenueState extends State<Revenue> {
  @override
  late List<RoomModel> filteredRoomList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Revenue'),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            final data = filteredRoomList[index];

            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                elevation: 15,
                child: SizedBox(
                  height: 100,
                  width: 300,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: CircleAvatar(
                          // backgroundImage: FileImage(File(user.image)),
                          radius: 30,
                          backgroundColor: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Muhammad Faisal',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  'RoomNo 34',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(width: 50),
                                Text('₹5000', style: TextStyle(fontSize: 20)),
                                Text('/month',
                                    style: TextStyle(color: Colors.grey)),
                                Text(
                                  'Paid',
                                  style: TextStyle(color: Colors.green),
                                ),
                                SizedBox(width: 10),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const Divider(
                height: 10,
              ),
          itemCount: 3),
    );
  }
}
