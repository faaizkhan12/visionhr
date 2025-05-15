import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:visionhr/widgets/reusetext.dart';
import '../utils/colors.dart';

class HistoryItem extends StatefulWidget {
  final String dateTime;
  final String id;
  final String bpm;
  final String name;
  final String duration;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final IconData actionIcon; // Add a new parameter for custom icon

  const HistoryItem({
    Key? key,
    required this.dateTime,
    required this.id,
    required this.bpm,
    required this.name,
    required this.duration,
    this.isSelected = false,
    required this.onTap,
    required this.onDelete,
    this.actionIcon = Icons.delete, // Default to delete icon
  }) : super(key: key);

  @override
  _HistoryItemState createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryItem> {




  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.nbgcolr,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: widget.isSelected ? AppColors.orange : Colors.transparent,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Get.width * 0.38,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/heart.png'),
                        const SizedBox(width: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReuseText(
                              data: 'Name: ${widget.name}',
                              color: AppColors.txtcolr,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(height: 5.h,),
                            ReuseText(
                              data: widget.bpm,
                              color: AppColors.txtcolr,
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                            ),
                          ],
                        ),

                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 30),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReuseText(
                          data: '(ID: ${widget.id})',
                          color: AppColors.txtcolr,
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                        ),
                        GestureDetector(
                          onTap: widget.onDelete,
                          child: Icon(
                            widget.actionIcon, // Use the custom icon here
                            color: AppColors.orange,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    ReuseText(
                      data: widget.dateTime,
                      color: AppColors.txtcolr,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                    ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
