import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:visionhr/widgets/roundedButton.dart';

import '../../utils/colors.dart';
import '../../widgets/reusetext.dart';
import '../navigationbar/navigationbar.dart';

class Lets_Started extends StatefulWidget {
  const Lets_Started({Key? key}) : super(key: key);

  @override
  State<Lets_Started> createState() => _Lets_StartedState();
}
class _Lets_StartedState extends State<Lets_Started> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgcolr, // Dark background like the design
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              /// Back Button
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
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
              ),

              SizedBox(height: 20.h),

              /// Title
              Center(
                child: ReuseText(
                  data: "How to measure?",
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.txtcolr,
                ),
              ),

              SizedBox(height: 20.h),

              /// Stack with image and text at bottom
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 400,
                    child: Image.asset(
                      "assets/bg.png",
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    bottom: 10.h,
                    left: 25.w,
                    right: 25.w,
                    child: Center(
                      child: ReuseText(
                        data:
                        "Put your face on the camera screen, then wait for a few seconds until the measurement is complete.",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.txtcolr,

                      ),
                    ),
                  ),
                  Center(
                    child: RoundedButton(text: "OK, Got it!",color: AppColors.orange, onTap: (){
                      Get.to(Navigationbar());
                    }),
                  )
                ],
              ),


            ],
          ),
        ),
      ),
    );
  }
}
