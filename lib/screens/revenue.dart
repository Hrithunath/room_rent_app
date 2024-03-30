import 'package:flutter/material.dart';
import 'package:room_rent_app/services/room_services.dart';

class Revenue extends StatefulWidget {
  final DateTime? selectedMonth;
  final DateTimeRange? selectedDateRange;
  const Revenue({super.key, this.selectedMonth, this.selectedDateRange});

  @override
  State<Revenue> createState() => _RevenueState();
}

class _RevenueState extends State<Revenue> {
  Set<String> uniqueEntries = Set();
  List<MapEntry<String, double>> TotalAmountsList = [];
  DateTime? selectedMonth;
  DateTimeRange? selectedDateRange;
  @override
  void initState() {
    super.initState();
    getRoom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Revenue'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () async {
                DateTime? pickeddate = await showDatePicker(
                    context: context,
                    initialDate: widget.selectedMonth ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100));
                if (pickeddate != null && pickeddate != selectedMonth) {
                  setState(() {
                    selectedMonth = pickeddate;
                    selectedDateRange = null;
                  });
                }
              },
              child: const Text('Select Month')),
          SizedBox(
            width: 10,
          ),
          ElevatedButton(
            onPressed: () async {
              DateTimeRange? pickedDateRange = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now(),
                  currentDate:
                      widget.selectedDateRange?.start ?? DateTime.now());
              if (pickedDateRange != null) {
                setState(() {
                  selectedDateRange = pickedDateRange;
                  selectedMonth = null;
                });
              }
            },
            child: Text('select Date'),
          ),
          SizedBox(
            width: 10,
          ),
          ElevatedButton(
              onPressed: () async {
                setState(() {
                  selectedMonth = null;
              selectedDateRange == null;
                });
              },
              child: Text('All'))
        ],
      ),
    );
  }
}
