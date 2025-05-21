import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../utils/colors.dart';
import '../../widgets/loader.dart';
import '../../widgets/reusetext.dart';
import '../../widgets/roundedButton.dart';
import '../../widgets/txtfield.dart';
import 'otp_screen.dart';
class Forgotpassword extends StatefulWidget {
  const Forgotpassword({Key? key}) : super(key: key);

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {

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
                    data: "Forgot Password? 🔑",
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.txtcolr,
                  ),
                  SizedBox(height: 10.h),
                  ReuseText(
                    data: "Don’t worry. we’ve got you covered. Enter your registered email address and we’ll send you an OTP code to reset your password.",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.txtcolr,
                  ),
                  SizedBox(height: 30.h),

                  // Email Field
                  TxtField(
                    hintText: "Enter your email",
                    controller: email,
                    labelText: "Registered email address",
                    showLabelText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Email is required";
                      if (!GetUtils.isEmail(value)) return "Enter a valid email";
                      return null;
                    },
                  ),

                  SizedBox(height: 35.h),

                  Center(
                    child: RoundedButton(
                      color: AppColors.orange,
                      text: "Send Password Reset Email",
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          CustomLoader.showLoadingDialog(context, message: "Sending reset email...");
                          try {
                            await FirebaseAuth.instance.sendPasswordResetEmail(
                              email: email.text.trim(),
                            );

                            CustomLoader.hideLoadingDialog(context);
                            Get.snackbar(
                              "Success",
                              "If this email is registered, you will receive a password reset link. Please check your inbox.",
                            );
                          } on FirebaseAuthException catch (e) {
                            CustomLoader.hideLoadingDialog(context);
                            String message = e.message ?? "Failed to send reset email.";
                            Get.snackbar("Error", message, colorText: Colors.red);
                          }
                        } else {
                          Get.snackbar("Error", "Please enter a valid email.");
                        }
                      },
                    ),
                  ),


                  SizedBox(height: 25.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
