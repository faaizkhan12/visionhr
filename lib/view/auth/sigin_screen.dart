import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:visionhr/view/auth/signup_screen.dart';

import '../../controller/auth_controller.dart' as controller;
import '../../utils/colors.dart';
import '../../widgets/reusetext.dart';
import '../../widgets/roundedButton.dart';
import '../../widgets/socialbutton.dart';
import '../../widgets/txtfield.dart';
import '../onbording_screen/onbording_screen.dart';
import 'forgotpassword.dart';
class SiginScreen extends StatefulWidget {
  const SiginScreen({Key? key}) : super(key: key);

  @override
  State<SiginScreen> createState() => _SiginScreenState();
}

class _SiginScreenState extends State<SiginScreen> {

  final authController = Get.put(controller.AuthController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RxBool isTermsAccepted = false.obs;

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back Button
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
                  SizedBox(height: 30.h),

                  ReuseText(
                    data: "Welcome Back! 👋",
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.txtcolr,
                  ),
                  SizedBox(height: 10.h),
                  ReuseText(
                    data: "Log in to continue your health journey.",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.txtcolr,
                  ),
                  SizedBox(height: 25.h),

                  // Email Field
                  TxtField(
                    hintText: "Enter your email",
                    controller: email,
                    labelText: "Email",
                    showLabelText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Email is required";
                      if (!GetUtils.isEmail(value)) return "Enter a valid email";
                      return null;
                    },
                  ),
                  SizedBox(height: 15.h),
                  TxtField(
                    hintText: "Enter your password",
                    controller: password,
                    labelText: "Password",
                    showLabelText: true,
                    showSuffixIcon: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Password is required";
                      if (value.length < 6) return "Password must be at least 6 characters";
                      return null;
                    },
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: (){
                          Get.to(Forgotpassword());
                        },
                          child: ReuseText(data: "Forgot password?",color: AppColors.orange,fontSize: 14,fontWeight: FontWeight.w600,)),
                    ],
                  ),
                  SizedBox(height: 25.h),

                  Center(
                    child: RoundedButton(
                      color: AppColors.orange,
                      text: "Sign In",
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          Get.offAll(() => Onboarding_Screen());
                        } else {
                          Get.snackbar("Error", "Please complete the form properly.", colorText: AppColors.txtcolr);
                        }
                      },


                    ),
                  ),
                  SizedBox(height: 25.h),

                  // Divider
                  Row(
                    children: [
                      Expanded(child: Divider(color: AppColors.txtgrey)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: ReuseText(
                          data: "Or continue with",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.txtcolr,
                        ),
                      ),
                      Expanded(child: Divider(color: AppColors.txtgrey)),
                    ],
                  ),
                  SizedBox(height: 30.h),

                  // Social Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SocialButton(
                        imagePath: "assets/Google.png",
                        width: 90,
                        onTap: authController.signInWithGoogle,
                      ),
                      SocialButton(
                        imagePath: "assets/fb.png",
                        width: 90,
                        onTap: authController.signInWithFacebook,
                      ),
                      SocialButton(
                        imagePath: "assets/apple.png",
                        onTap: authController.signInWithApple,
                        width: 90,
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  Center(
                    child: ReuseText(
                      richTextSpan: TextSpan(
                        children: [
                          TextSpan(
                            text: "Don’t have an account?",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.txtcolr,
                            ),
                          ),
                          TextSpan(
                            text: " Sign Up",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.orange,
                            ),
                          ),
                        ],
                      ),
                      onClick: () {
                        Get.to(SignupScreen());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
