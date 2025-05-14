import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:visionhr/view/auth/password_confirmation.dart';

import '../../controller/auth_controller.dart' as controller;
import '../../utils/colors.dart';
import '../../widgets/reusetext.dart';
import '../../widgets/roundedButton.dart';
import '../../widgets/txtfield.dart';
class NewpasswordCreation extends StatefulWidget {
  const NewpasswordCreation({Key? key}) : super(key: key);

  @override
  State<NewpasswordCreation> createState() => _NewpasswordCreationState();
}

class _NewpasswordCreationState extends State<NewpasswordCreation> {
  final authController = Get.put(controller.AuthController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RxBool isTermsAccepted = false.obs;

  final TextEditingController confirmpassword = TextEditingController();
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
                    data: "Secure your Account 🔒",
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.txtcolr,
                  ),
                  SizedBox(height: 10.h),
                  ReuseText(
                    data: "Enter a new password for your account. Ensure it’s strong and unique for enhanced security.",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.txtcolr,
                  ),
                  SizedBox(height: 25.h),
                  TxtField(
                    hintText: "Enter New Password",
                    controller: password,
                    labelText: "Create New Password",
                    showLabelText: true,
                    showSuffixIcon: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Password is required";
                      if (value.length < 6) return "Password must be at least 6 characters";
                      return null;
                    },
                  ),
                  SizedBox(height: 15.h),
                  TxtField(
                    hintText: "Enter New Password",
                    controller: confirmpassword,
                    labelText: "Confirm New Password",
                    showLabelText: true,
                    showSuffixIcon: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Password is required";
                      if (value.length < 6) return "Password must be at least 6 characters";
                      return null;
                    },
                  ),
                  SizedBox(height: 25.h),

                  Center(
                    child: RoundedButton(
                      color: AppColors.orange,
                      text: "Save New Password",
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          if (password.text != confirmpassword.text) {
                            Get.snackbar("Error", "Passwords do not match");
                            return;
                          }

                          // Passwords are valid and match
                          Get.to(() => PasswordConfirmation());
                        } else {
                          Get.snackbar("Error", "Please complete the form properly.");
                        }
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
