import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:room_rent_app/model/room_model.dart';
import '../../services/revenue_services.dart';

class Revenue extends StatefulWidget {
  const Revenue({super.key});

  @override
  State<Revenue> createState() => _RevenueState();
}

class _RevenueState extends State<Revenue> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _fromDate;
  DateTime? _toDate;
  double totalRevenue = 0;
  final roomNotifier = ValueNotifier<List<RoomModel>>([]);
  @override
  void initState() {
    _fromDate = DateTime.now();
    _toDate = DateTime.now();
    getRevenueinside();
    super.initState();
  }

  Future<void> getRevenueinside() async {
    totalRevenue = await getRevenue();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Revenue'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildDateForm(),
              const SizedBox(height: 20),
              buildTotalRevenueDisplay(),
              const SizedBox(height: 20),
              buildRevenueList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDateForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildDateFormField(
            labelText: 'From date',
            selectedDate: _fromDate,
            selectDate: (DateTime? date) {
              setState(() {
                _fromDate = date;
              });
            },
          ),
          const SizedBox(height: 20),
          buildDateFormField(
            labelText: 'To date',
            selectedDate: _toDate,
            selectDate: (DateTime? date) {
              setState(() {
                _toDate = date;
              });
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => onSubmitButtonClicked(),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF5E47DD),
            ),
            child: const Text('Submit',style: TextStyle(color: Color(0xFFEFECEC),),)
          ),
        ],
      ),
    );
  }

  Widget buildDateFormField({
    required String labelText,
    required DateTime? selectedDate,
    required void Function(DateTime?) selectDate,
  }) {
    return ListTile(
      title: Text(labelText),
      subtitle: selectedDate != null
          ? Text(DateFormat("dd/MM/yyyy").format(selectedDate))
          : null,
      trailing: IconButton(
        onPressed: () => _selectDate(selectedDate, selectDate),
        icon: const Icon(Icons.calendar_month),
      ),
    );
  }

  Future<void> _selectDate(
    DateTime? initialDate,
    void Function(DateTime?) onDateSelected,
  ) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(2001),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (pickedDate != null) {
      onDateSelected(pickedDate);
    }
  }

  Widget buildTotalRevenueDisplay() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Total Revenue:',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          '₹${totalRevenue.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
           color: Color(0xFF5E47DD),
          ),
        ),
      ],
    );
  }

  Future<void> onSubmitButtonClicked() async {
    if (_fromDate == null || _toDate == null) {
      return;
    }

    if (_fromDate!.isAfter(_toDate!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          margin: EdgeInsets.all(10),
          content: Text('Select From date before To date'),
        ),
      );
      return;
    }

    // Pass DateTime objects to the getRevenue function
    final revenue = await getRevenue(fromDate: _fromDate!, toDate: _toDate!);
    setState(() {
      totalRevenue = revenue;
    });
  }

  Widget buildRevenueList() {
    return ValueListenableBuilder(
        valueListenable: revenueNotifier,
        builder: (context, value, child) {
          if (value.isEmpty) {
            return const Center(child: Text('No data found'));
          }
          return Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final data = value[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
               
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: ListTile(
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: FileImage(File(data.image)),
                                  ))),
                          const SizedBox(height: 5.0),
                          Text(
                            'Room Number: ${data.room}',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w900,),
                          ),
                          const SizedBox(height: 5.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Floor: ${data.floor}',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w900,),
                              ),
                              const SizedBox(height: 5.0),
                              Text(
                                'Rent/month: ₹${data.rent}',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w900,),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5.0),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: value.length,
            ),
          );
        });
  }
}
