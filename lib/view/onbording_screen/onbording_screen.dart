import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../utils/colors.dart';
import '../../widgets/roundedButton.dart';
import 'onboarding_data.dart';
class Onboarding_Screen extends StatefulWidget {
  const Onboarding_Screen({Key? key}) : super(key: key);

  @override
  State<Onboarding_Screen> createState() => _Onboarding_ScreenState();
}

class _Onboarding_ScreenState extends State<Onboarding_Screen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
         child: Padding(
           padding: EdgeInsets.all(20.w),
           child: Column(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(),
              Center(child: Image.asset("assets/Frame 48095978.png")),
              Center(child: RoundedButton(text: "Ok, Lets’s Start", onTap: (){
                Get.to(OnboardingData());
              },color: AppColors.orange,))
            ],
                   ),
         ),
      ),
    );
  }
}
