import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visionhr/utils/colors.dart';
import 'package:visionhr/view/auth/sigin_screen.dart';
import 'package:visionhr/view/auth/signup_screen.dart';
import 'package:visionhr/widgets/reusetext.dart';
import 'package:visionhr/widgets/roundedButton.dart';
import 'package:visionhr/widgets/socialbutton.dart';

import '../../controller/auth_controller.dart';
import '../../widgets/loader.dart';
import '../onbording_screen/onbording_screen.dart';


class OnboardingAuth extends StatelessWidget {
  const OnboardingAuth({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());


    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40.h),
              Center(
                child: Image.asset(
                  "assets/logo.png",
                  height: 100.h,
                  width: 100.w,
                ),
              ),
              SizedBox(height: 30.h),
              ReuseText(
                data: "Let’s Get Started!",
                fontSize: 30.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.txtcolr,
              ),
              SizedBox(height: 10.h),
              ReuseText(
                data: "Let’s dive into your account",
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.txtgrey,
              ),
              SizedBox(height: 40.h),
          SocialButton(
            imagePath: "assets/Google.png",
            buttonText: "Continue with Google",
            onTap: () async {
              CustomLoader.showLoadingDialog(context);
              final success = await authController.signInWithGoogle();
              CustomLoader.hideLoadingDialog(context);
              if (success) {
                Get.off(() => const Onboarding_Screen());
              }
            },
          ),

              SizedBox(height: 25.h),
              SocialButton(
                imagePath: "assets/apple.png",
                buttonText: "Continue with Apple",
                onTap: (){},
              ),
              SizedBox(height: 30.h),
              Row(
                children: [
                  Expanded(child: Divider(color: AppColors.txtgrey)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: ReuseText(
                      data: "Or",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.txtcolr,
                    ),
                  ),
                  Expanded(child: Divider(color: AppColors.txtgrey)),
                ],
              ),
              SizedBox(height: 40.h),
              RoundedButton(
                text: "Sign up",
                onTap: () {
                  Get.to(SignupScreen());
                },
                color: AppColors.orange,
              ),
              SizedBox(height: 20.h),
              RoundedButton(
                text: "Sign in",
                onTap: () {
                   Get.to(SiginScreen());
                },
                color: AppColors.nbgcolr,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
