import 'package:flutter/material.dart';


class DateSelector extends StatefulWidget {
  const DateSelector({Key? key});

  @override
  _DateSelectorState createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () => _selectDate(context),
          child: Text(
            _selectedDate == null
                ? 'Select Date'
                : 'Selected Date: ${_selectedDate!.toString().split(' ')[0]}',
          ),
        ),
      ],
    );
  }
}
