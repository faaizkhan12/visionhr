import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:visionhr/view/notifaction/notifaction.dart';
import 'package:visionhr/widgets/roundedButton.dart';

import '../../../utils/colors.dart';
import '../../../widgets/reusetext.dart';
import 'measurement.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                    data: "Measurement",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.txtcolr,
                  ),
                  GestureDetector(
                    onTap: () => Get.to(Notifaction()),
                    child: Container(
                      height: 32.h,
                      width: 32.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColors.nbgcolr,
                      ),
                      child: Icon(Icons.notifications_active_outlined, size: 18, color: AppColors.txtcolr),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 80,),
              Center(child: Image.asset("assets/heartpump.png")),
              SizedBox(height: 20,),
              Center(
                child: RoundedButton(text: "Start",height: 46,width:98,textColor:AppColors.orange,onTap: (){
                  Get.to(Measurement());
                }),
              ),
              SizedBox(height: 20,),
              Center(child: ReuseText(data: "Tap to Measure",color: AppColors.txtcolr,fontSize: 16,fontWeight: FontWeight.w400,)),


            ],
          ),
        ),
      ),
    );
  }
}
