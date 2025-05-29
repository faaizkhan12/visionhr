import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HealthReminderPicker extends StatefulWidget {
  final ValueChanged<String> onReminderSelected;

  const HealthReminderPicker({Key? key, required this.onReminderSelected}) : super(key: key);

  @override
  _HealthReminderPickerState createState() => _HealthReminderPickerState();
}

class _HealthReminderPickerState extends State<HealthReminderPicker> {
  int selectedHour = 9;
  int selectedMinute = 0;
  String selectedPeriod = 'AM';

  final List<int> hours = List.generate(12, (index) => index + 1); // 1 - 12
  final List<int> minutes = List.generate(60, (index) => index);   // 0 - 59
  final List<String> periods = ['AM', 'PM'];

  void _updateReminder() {
    final reminder = '$selectedHour:${selectedMinute.toString().padLeft(2, '0')} $selectedPeriod';
    widget.onReminderSelected(reminder);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            "When would you like to\nreceive health check\nreminders?",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 40),
        SizedBox(
          height: 400,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildPicker(hours, selectedHour, (value) {
                setState(() {
                  selectedHour = value;
                  _updateReminder();
                });
              }),
              buildPicker(minutes, selectedMinute, (value) {
                setState(() {
                  selectedMinute = value;
                  _updateReminder();
                });
              }),
              buildPicker(periods, selectedPeriod, (value) {
                setState(() {
                  selectedPeriod = value;
                  _updateReminder();
                });
              }),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          "You can always change this later",
          style: TextStyle(color: Colors.white70),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget buildPicker<T>(List<T> items, T selectedItem, ValueChanged<T> onSelectedItemChanged) {
    return Expanded(
      child: CupertinoPicker(
        itemExtent: 40,
        scrollController: FixedExtentScrollController(
          initialItem: items.indexOf(selectedItem),
        ),
        onSelectedItemChanged: (index) {
          onSelectedItemChanged(items[index]);
        },
        magnification: 1.2,
        useMagnifier: true,
        diameterRatio: 1.1,
        backgroundColor: Colors.transparent,
        children: items.map((item) {
          return Center(
            child: Text(
              item.toString().padLeft(2, '0'),
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          );
        }).toList(),
      ),
    );
  }
}
