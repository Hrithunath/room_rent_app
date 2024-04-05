import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:room_rent_app/services/room_services.dart';
import 'package:room_rent_app/widgets/refactor_button.dart';
import 'package:room_rent_app/widgets/refactor_revenue.dart';

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
              _buildDateForm(),
              const SizedBox(height: 20),
              _buildTotalRevenueDisplay(),
              const SizedBox(height: 20),
              Expanded(child: revenuelist()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildDateFormField(
            labelText: 'From date',
            selectedDate: _fromDate,
            selectDate: (DateTime? date) {
              setState(() {
                _fromDate = date;
              });
            },
          ),
          const SizedBox(height: 20),
          _buildDateFormField(
            labelText: 'To date',
            selectedDate: _toDate,
            selectDate: (DateTime? date) {
              setState(() {
                _toDate = date;
              });
            },
          ),
          const SizedBox(height: 20),
          button(
            buttonText: 'Submit',
            buttonPressed: _onSubmitButtonClicked,
          ),
        ],
      ),
    );
  }

  Widget _buildDateFormField({
    required String labelText,
    required DateTime? selectedDate,
    required void Function(DateTime?) selectDate,
  }) {
    return ListTile(
      title: Text(labelText),
      trailing: ElevatedButton(
        onPressed: () => _selectDate(context, selectedDate, selectDate),
        child: const Text('Select Date'),
      ),
      subtitle: selectedDate != null
          ? Text(DateFormat('MM d, yyyy').format(selectedDate))
          : null,
    );
  }

  Future<void> _selectDate(
    BuildContext context,
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

  Widget _buildTotalRevenueDisplay() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Total Revenue:',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          '₹${totalRevenue.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }

  Future<void> _onSubmitButtonClicked() async {
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
  }
}
