import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:visionhr/view/auth/sigin_screen.dart';
import 'package:visionhr/widgets/roundedButton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/colors.dart';
class PasswordConfirmation extends StatefulWidget {
  const PasswordConfirmation({Key? key}) : super(key: key);

  @override
  State<PasswordConfirmation> createState() => _PasswordConfirmationState();
}

class _PasswordConfirmationState extends State<PasswordConfirmation> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
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
              Center(child: Image.asset("assets/allset.png")),
              Center(child: RoundedButton(text: "Back to Login", onTap: (){
                Get.to(SiginScreen());
              },color: AppColors.orange,))
            ],
          ),
        ),
      ),
    );
  }
}
