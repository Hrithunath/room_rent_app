import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:room_rent_app/services/room_services.dart';
import 'package:room_rent_app/widgets/refactor_button.dart';
import 'package:room_rent_app/widgets/refactor_calender.dart';
import 'package:room_rent_app/widgets/refactor_revenue.dart';

class Revenue extends StatefulWidget {
  const Revenue({super.key});

  @override
  State<Revenue> createState() => _RevenueState();
}

class _RevenueState extends State<Revenue> {
  final _formKey = GlobalKey<FormState>();
  final _fromDateController = TextEditingController();
  final _toDateController = TextEditingController();
  final Widget divider = const SizedBox(
    height: 20,
  );
  double totalRevenue = 0;

  @override
  void initState() {
    _fromDateController.text = DateFormat('MM d, yyyy')
        .format(DateTime.now().subtract(const Duration(days: 7)));
    _toDateController.text = DateFormat('MM d, yyyy').format(DateTime.now());
    fetchdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Revenue')),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  divider,
                  customtextFeildcalender(
                      controller: _fromDateController,
                      onTapcalender: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(
                              2001), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime.now(),
                        );
                        if (pickedDate != null) {
                          String toDate =
                              DateFormat('MM d, yyyy').format(pickedDate);
                          setState(() {
                            _toDateController.text = toDate;
                          });
                        }
                      },
                      labeltext: 'From date',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'From date should not be empty';
                        } else {
                          return null;
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction),
                  const SizedBox(
                    height: 20,
                  ),
                  customtextFeildcalender(
                      controller: _toDateController,
                      onTapcalender: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(
                              2001), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime.now(),
                        );
                        if (pickedDate != null) {
                          String toDate =
                              DateFormat('MM d, yyyy').format(pickedDate);
                          setState(() {
                            _toDateController.text = toDate;
                          });
                        }
                      },
                      labeltext: 'To date',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'To date should not be empty';
                        } else {
                          return null;
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction),
                  button(
                      buttonText: 'Submit',
                      buttonPressed: () => onSubmitButtonClicked(context)),
                ],
              ),

            ),
             revenuelist(),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Total : ₹${totalRevenue.toStringAsFixed(2)}',
                style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> onSubmitButtonClicked(BuildContext context) async {
    final fromdate = _fromDateController.text.trim();
    final todate = _toDateController.text.trim();

    if (fromdate.isEmpty || todate.isEmpty) {
      return;
    }

    final DateFormat dateFormat = DateFormat("M/d/yyyy 'at' H");
    DateTime fromDate;
    DateTime toDate;

    try {
      fromDate = dateFormat.parse(fromdate);
      toDate = dateFormat.parse(todate);
    } catch (e) {
      // ignore: avoid_print
      print('Error parsing date: $e');
      return;
    }
    if (fromDate.isAfter(toDate)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        margin: EdgeInsets.all(10),
        content: Text('Select From date before To date'),
      ));
      _fromDateController.text = DateFormat('MM d, yyyy')
          .format(DateTime.now().subtract(const Duration(days: 7)));
      _toDateController.text = DateFormat('MM d, yyyy').format(DateTime.now());
    }

    getRevenue(fromdate, todate);
    fetchdata();
  }

  void _updateTotalRevenue() async {
    final rev =
        await getRevenue(_fromDateController.text, _toDateController.text);
    setState(() {
      totalRevenue = rev;
    });
  }

 void  fetchdata() async {
    _updateTotalRevenue();
  }
}
