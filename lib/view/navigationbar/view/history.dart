import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visionhr/widgets/histor_item.dart';

import '../../../utils/colors.dart';
import '../../../widgets/reusetext.dart';
class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 32),
                  ReuseText(
                    data: "History",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.txtcolr,
                  ),
                  const SizedBox(width: 32),
                ],
              ),
              SizedBox(height: 20,),
              HistoryItem(dateTime: "20/2/2022", id: "12222", bpm: "23 bpm", name: "faaiz", duration: "30", onTap: (){}, onDelete: (){}),
              HistoryItem(dateTime: "20/2/2022", id: "12222", bpm: "23 bpm", name: "faaiz", duration: "30", onTap: (){}, onDelete: (){}),
              HistoryItem(dateTime: "20/2/2022", id: "12222", bpm: "23 bpm", name: "faaiz", duration: "30", onTap: (){}, onDelete: (){}),
              HistoryItem(dateTime: "20/2/2022", id: "12222", bpm: "23 bpm", name: "faaiz", duration: "30", onTap: (){}, onDelete: (){}),
              HistoryItem(dateTime: "20/2/2022", id: "12222", bpm: "23 bpm", name: "faaiz", duration: "30", onTap: (){}, onDelete: (){}),
            ],
          ),
        ),
      ),
    );
  }
}
