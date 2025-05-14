import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:visionhr/utils/colors.dart';
import 'package:visionhr/view/auth/sigin_screen.dart';
import 'package:visionhr/widgets/reusetext.dart';
import 'package:visionhr/widgets/socialbutton.dart';
import 'package:visionhr/widgets/txtfield.dart';
import '../../controller/auth_controller.dart' as controller;
import '../../widgets/roundedButton.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  final authController = Get.put(controller.AuthController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RxBool isTermsAccepted = false.obs;

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    data: "Join Vision HR Today ✨",
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.txtcolr,
                  ),
                  SizedBox(height: 10.h),
                  ReuseText(
                    data: "Create your account and start monitoring your health",
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

                  // Password Field
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

                  // Confirm Password Field
                  TxtField(
                    hintText: "Confirm your password",
                    controller: confirmPassword,
                    labelText: "Confirm Password",
                    showLabelText: true,
                    showSuffixIcon: true,
                    validator: (value) {
                      if (value != password.text) return "Passwords do not match";
                      return null;
                    },
                  ),
                  SizedBox(height: 10.h),
                  Obx(() => Row(
                    children: [
                      Checkbox(
                        value: isTermsAccepted.value,
                        onChanged: (val) {
                          isTermsAccepted.value = val ?? false;
                        },
                        activeColor: AppColors.orange,
                      ),
                      Expanded(
                        child: ReuseText(
                          richTextSpan: TextSpan(
                            children: [
                              TextSpan(
                                text: "I agree to the Vision HR ",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.txtcolr,
                                ),
                              ),
                              TextSpan(
                                text: "Terms & Conditions",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.orange,
                                ),
                              ),
                            ],
                          ),
                          onClick: () {
                            // Navigate to terms screen
                          },
                        ),
                      ),
                    ],
                  )),
                  SizedBox(height: 15.h),

                  // Signup Button
                  Center(
                    child: RoundedButton(
                      color: AppColors.orange,
                      text: "Sign Up",
                      onTap: () {
                        if (_formKey.currentState!.validate() &&
                            isTermsAccepted.value) {
                          // Proceed with signup
                        } else {
                          Get.snackbar("Error", "Please complete the form properly.",colorText: AppColors.txtcolr);
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
                            text: "Already have an account? ",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.txtcolr,
                            ),
                          ),
                          TextSpan(
                            text: "Log in",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.orange,
                            ),
                          ),
                        ],
                      ),
                      onClick: () {
                        Get.to(SiginScreen());
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
