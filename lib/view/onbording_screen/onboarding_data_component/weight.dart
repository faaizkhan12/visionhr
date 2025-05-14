import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visionhr/utils/colors.dart';

class WeightPickerScreen extends StatefulWidget {
  @override
  State<WeightPickerScreen> createState() => _WeightPickerScreenState();
}

class _WeightPickerScreenState extends State<WeightPickerScreen> {
  int selectedWeight = 70;
  bool isKg = true;

  final List<int> weights = List.generate(100, (index) => 30 + index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Text(
                "What's your body weight?",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _unitButton("kg", isKg),
                  SizedBox(width: 12.w),
                  _unitButton("lb", !isKg),
                ],
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 50.h,
                  scrollController: FixedExtentScrollController(
                      initialItem: weights.indexOf(selectedWeight)),
                  onSelectedItemChanged: (index) {
                    setState(() {
                      selectedWeight = weights[index];
                    });
                  },
                  backgroundColor: Colors.transparent,
                  children: weights
                      .map((val) => Center(
                    child: Text(
                      "$val ${isKg ? "kg" : "lb"}",
                      style: TextStyle(
                        color: val == selectedWeight
                            ? AppColors.orange
                            : Colors.white,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _unitButton(String unit, bool selected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isKg = unit == "kg";
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: selected ? AppColors.orange : Colors.transparent,
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(color: AppColors.orange),
        ),
        child: Text(
          unit,
          style: TextStyle(
            color: selected ? Colors.white : AppColors.orange,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
