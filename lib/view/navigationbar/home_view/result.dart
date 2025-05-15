import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:visionhr/widgets/roundedButton.dart';

import '../../../utils/colors.dart';
import '../../../widgets/reusetext.dart';
class Result extends StatefulWidget {
  const Result({Key? key}) : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
         child: Padding(
           padding: EdgeInsets.all(20.w),
           child: SingleChildScrollView(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        height: 30.h,
                        width: 30.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: AppColors.nbgcolr,
                        ),
                        child: Icon(Icons.arrow_back, size: 18, color: AppColors.txtcolr),
                      ),
                    ),
                    ReuseText(
                      data: "Result",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.txtcolr,
                    ),
                    const SizedBox(width: 32),
                  ],
                ),
                SizedBox(height: 20.h),
                Center(
                  child: ReuseText(
                    richTextSpan: TextSpan(
                      children: [
                        TextSpan(
                          text: "YOUR ",
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.txtcolr,
                          ),
                        ),
                        TextSpan(
                          text: "RPG ",
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.orange,
                          ),
                        ),
                        TextSpan(
                          text: "ANALYSIS ",
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.txtcolr,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Center(child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: ReuseText(data: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",fontSize: 16,fontWeight: FontWeight.w400,color: AppColors.txtgrey,),
                )),
             Center(
               child: Container(
                 width: 200.w,
                 height: 200.w,
                 decoration: BoxDecoration(
                   shape: BoxShape.circle,
                   gradient: RadialGradient(
                     colors: [Colors.black, Color(0xFF1C1C1E)],
                     center: Alignment.center,
                     radius: 0.8,
                   ),
                 ),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     /// Heart Rate Number + Icon
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.end,
                       children: [
                         Text(
                           "67",
                           style: TextStyle(
                             fontSize: 48.sp,
                             fontWeight: FontWeight.bold,
                             color: Colors.white,
                           ),
                         ),
                         Padding(
                           padding: EdgeInsets.only(left: 4.w, bottom: 40.h),
                           child: Icon(
                             Icons.favorite,
                             color: Colors.redAccent,
                             size: 20.sp,
                           ),
                         ),
                       ],
                     ),
                     Padding(
                       padding:  EdgeInsets.only(left: 36.w,),
                       child: Text(
                         "bpm",
                         style: TextStyle(
                           fontSize: 16.sp,
                           color: Colors.white60,
                         ),
                       ),
                     ),
             
                     SizedBox(height: 16.h),
             
                     Image.asset(
                       "assets/Vector.png",
                       height: 30.h,
                       fit: BoxFit.contain,
                     ),
                   ],
                 ),
               ),
             ),
                SizedBox(height: 10.h),
                Image.asset("assets/Frame 1984077930.png"),
                SizedBox(height: 10.h),
                Image.asset("assets/Frame 1984077931.png"),
                SizedBox(height: 20.h),
                Center(child: RoundedButton(text: "Download Report", onTap: (){},color: AppColors.orange,)),
                SizedBox(height: 20.h),
              ],
                     ),
           ),
         ),
      ),
    );
  }
}
