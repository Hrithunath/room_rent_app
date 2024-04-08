import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:room_rent_app/model/room_model.dart';
import 'package:room_rent_app/model/user_model.dart';
import 'package:room_rent_app/services/room_services.dart';

class Revenue extends StatefulWidget {
  const Revenue({Key? key}) : super(key: key);

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
    // getRevenue();
  //  Hive.box<UserModel>('disposed_users');
    super.initState();
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
              buildRevenueList(roomNotifier.value),
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
            child: const Text('Submit'),
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
          ? Text(DateFormat('MM d, yyyy').format(selectedDate))
          : null,
      trailing: IconButton(
        onPressed: () => _selectDate(selectedDate, selectDate),
        icon: Icon(Icons.calendar_month),
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
      lastDate: DateTime.now(),
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
            color: Colors.blue,
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
    final revenue = await getRevenue(_fromDate!, _toDate!);
    setState(() {
      totalRevenue = revenue;
    });

    // Fetch revenue list separately if needed
    final list = await fetchRevenueList(_fromDate!, _toDate!);
    setState(() {
      roomNotifier.value = list; // Update roomNotifier value
      print('revenueList:- $list');
    });
  }

  Widget buildRevenueList(List<RoomModel> revenueList) {
    if (revenueList.isEmpty) {
      return const Center(child: Text('No data found'));
    }
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          final data = revenueList[index];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Color.fromARGB(255, 139, 136, 136),
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: ListTile(
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Room Number: ${data.room}'),
                    const SizedBox(height: 5.0),
                    Text('Rent: \$${data.rent}'),
                    const SizedBox(height: 5.0),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: revenueList.length,
      ),
    );
  }
}
