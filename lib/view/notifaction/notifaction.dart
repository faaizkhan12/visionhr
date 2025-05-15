import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../utils/colors.dart';
import '../../widgets/reusetext.dart';
class Notifaction extends StatefulWidget {
  const Notifaction({Key? key}) : super(key: key);

  @override
  State<Notifaction> createState() => _NotifactionState();
}

class _NotifactionState extends State<Notifaction> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      height: 32.h,
                      width: 32.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColors.nbgcolr,
                      ),
                      child: Icon(Icons.arrow_back, size: 18, color: AppColors.txtcolr),
                    ),
                  ),
                  ReuseText(
                    data: "Notifaction",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.txtcolr,
                  ),
                  const SizedBox(width: 32),
                ],
              ),
              SizedBox(height: 200,),
              Center(child: Image.asset("assets/notif.png",height: 150,)),
            ],
          ),
        ),
      ),
    );
  }
}
