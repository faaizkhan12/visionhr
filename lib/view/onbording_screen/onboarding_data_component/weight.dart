import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visionhr/utils/colors.dart';

class WeightPickerScreen extends StatefulWidget {
  final Function(double)? onWeightSelected; // Callback to pass weight

  const WeightPickerScreen({Key? key, this.onWeightSelected}) : super(key: key);

  @override
  State<WeightPickerScreen> createState() => _WeightPickerScreenState();
}

class _WeightPickerScreenState extends State<WeightPickerScreen> {
  int selectedWeight = 70;
  bool isKg = true;

  final List<int> weights = List.generate(100, (index) => 30 + index);

  @override
  void initState() {
    super.initState();
    // Initial callback
    widget.onWeightSelected?.call(selectedWeight.toDouble());
  }

  void _handleWeightChange(int index) {
    setState(() {
      selectedWeight = weights[index];
    });
    widget.onWeightSelected?.call(selectedWeight.toDouble());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
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
              backgroundColor: Colors.black,
              itemExtent: 50.h,
              scrollController: FixedExtentScrollController(
                initialItem: weights.indexOf(selectedWeight),
              ),
              onSelectedItemChanged: _handleWeightChange,
              children: weights
                  .map((weight) => Center(
                child: Text(
                  '$weight ${isKg ? "kg" : "lb"}',
                  style: TextStyle(color: Colors.white, fontSize: 20.sp),
                ),
              ))
                  .toList(),
            ),
          ),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }

  Widget _unitButton(String label, bool selected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isKg = label == "kg";
        });
        widget.onWeightSelected?.call(selectedWeight.toDouble());
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
        decoration: BoxDecoration(
          color: selected ? AppColors.orange : Colors.grey.shade800,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
