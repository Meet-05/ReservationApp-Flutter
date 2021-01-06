import 'package:flutter/material.dart';
import 'package:reservationApp/constants.dart';

class DatePicker extends StatefulWidget {
  void Function(DateTime time) fetchTime;
  DateTime initialDateTime;
  DatePicker({this.fetchTime, this.initialDateTime});
  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // widget.initialDateTime == null
    //     ? DateTime.now()
    //     :
    // widget.initialDateTime;
    return Row(
      children: [
        OutlineButton.icon(
          padding: EdgeInsets.all(10.0),
          borderSide: BorderSide(color: Colors.black),
          onPressed: () async {
            DateTime selectedDate = await buildShowDatePicker(context);
            TimeOfDay selectedTime = await buildShowTimePicker(context);
            // print(selectedDate);
            if (selectedDate != null && selectedTime != null) {
              // print(selectedTime);
              setState(() {
                print(dateformat.format(_selectedDate));
                _selectedDate = DateTime(selectedDate.year, selectedDate.month,
                    selectedDate.day, selectedTime.hour, selectedTime.minute);
                widget.initialDateTime = _selectedDate;
              });
              widget.fetchTime(_selectedDate);
            }
          },
          icon: Icon(Icons.date_range),
          label: Text(
            dateformat.format(widget.initialDateTime == null
                ? _selectedDate
                : widget.initialDateTime),
            style: ktitleStyle.copyWith(fontSize: 15.0),
          ),
        ),
      ],
    );
  }

  Future<TimeOfDay> buildShowTimePicker(BuildContext context) {
    return showTimePicker(
        context: context,
        initialTime: widget.initialDateTime == null
            ? TimeOfDay.now()
            : TimeOfDay(
                hour: widget.initialDateTime.hour,
                minute: widget.initialDateTime.minute));
  }

  Future<DateTime> buildShowDatePicker(BuildContext context) {
    return showDatePicker(
        context: context,
        initialDate: widget.initialDateTime == null
            ? DateTime.now().add(Duration(seconds: 1))
            : DateTime(widget.initialDateTime.year,
                widget.initialDateTime.month, widget.initialDateTime.day),
        firstDate: DateTime.now(),
        lastDate: DateTime(2025));
  }
}
