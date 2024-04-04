import 'package:flutter/material.dart';
import 'package:room_rent_app/model/room_model.dart';
import 'package:room_rent_app/services/room_services.dart';
import 'package:room_rent_app/widgets/refactor_text.dart';

Widget revenuelist() {
  double totalRevenue = 0;
  return Expanded(
      child: ValueListenableBuilder(
          valueListenable: roomNotifier,
          builder: ((BuildContext context, List<RoomModel> revenueList, child) {
            totalRevenue = 0;
            for (var item in revenueList) {
              // totalRevenue = totalRevenue + Widget.revenue(item.rent);
            }

            return ListView.builder(
              itemBuilder: (context, index) {
                final data = revenueList[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: const Color.fromARGB(255, 206, 242, 242),
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: ListTile(
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customText('Room Number', data.room, null),
                          const SizedBox(height: 5.0),
                          customText('Rent', '\$${data.rent}', null),
                          const SizedBox(height: 5.0),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: revenueList.length,
            );
          })));
}
