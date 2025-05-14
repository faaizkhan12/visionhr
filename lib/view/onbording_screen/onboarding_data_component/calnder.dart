import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visionhr/utils/colors.dart';

class BirthdayPickerScreen extends StatefulWidget {
  @override
  State<BirthdayPickerScreen> createState() => _BirthdayPickerScreenState();
}

class _BirthdayPickerScreenState extends State<BirthdayPickerScreen> {
  int selectedMonth = 1;
  int selectedDay = 1;
  int selectedYear = 1990;

  final List<int> months = List.generate(12, (index) => index + 1);
  final List<int> days = List.generate(31, (index) => index + 1);
  final List<int> years = List.generate(100, (index) => 2025 - index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Text(
              "When is your birthday?",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 40.h),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildPicker("Month", months, selectedMonth, (val) {
                    setState(() => selectedMonth = val);
                  }),
                  _buildPicker("Day", days, selectedDay, (val) {
                    setState(() => selectedDay = val);
                  }),
                  _buildPicker("Year", years, selectedYear, (val) {
                    setState(() => selectedYear = val);
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPicker(String label, List<int> items, int selectedValue, Function(int) onSelected) {
    return Expanded(
      child: Column(
        children: [
          Text(label, style: TextStyle(color: AppColors.txtcolr,fontSize: 16,fontWeight: FontWeight.w500)),
          Expanded(
            child: CupertinoPicker(
              itemExtent: 50.h,
              scrollController: FixedExtentScrollController(
                  initialItem: items.indexOf(selectedValue)),
              onSelectedItemChanged: (index) {
                onSelected(items[index]);
              },
              backgroundColor: Colors.transparent,
              children: items
                  .map((val) => Center(
                child: Text(
                  val.toString().padLeft(2, '0'),
                  style: TextStyle(
                    color: val == selectedValue ? AppColors.orange : Colors.white,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
