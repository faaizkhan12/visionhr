import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:visionhr/view/auth/newPassword_creation.dart';
import '../../utils/colors.dart';
import '../../widgets/reusetext.dart';
import '../../widgets/roundedButton.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();
  int _start = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _start = 60;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 0) {
        timer.cancel();
      } else {
        if (mounted) {
          setState(() {
            _start--;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    otpController.dispose();
    super.dispose();
  }

  void verifyOtp() {
    if (otpController.text.length != 4 || !RegExp(r'^[0-9]+$').hasMatch(otpController.text)) {
      Get.snackbar("Invalid OTP", "Please enter a 4-digit numeric OTP.");
      return;
    }

    // If OTP is valid, navigate to NewPasswordCreation screen
    Get.to(() => NewpasswordCreation());
  }

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
                  /// Back Button
                  GestureDetector(
                    onTap: () {
                      _timer?.cancel();
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
                  SizedBox(height: 30.h),

                  /// Title
                  ReuseText(
                    data: "Enter OTP Code 🔐",
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.txtcolr,
                  ),
                  SizedBox(height: 10.h),
                  ReuseText(
                    data: "We’ve sent an OTP code to your email. Please enter it below to verify your account.",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.txtcolr,
                  ),
                  SizedBox(height: 25.h),

                  /// OTP Field
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: PinCodeTextField(
                      appContext: context,
                      length: 4,
                      controller: otpController,
                      keyboardType: TextInputType.number, // only number input
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(10),
                        fieldHeight: 50.h,
                        fieldWidth: 50.w,
                        inactiveColor: Colors.grey,
                        selectedColor: AppColors.orange,
                        selectedFillColor: AppColors.orange.withOpacity(0.2),
                        activeColor: AppColors.orange,
                        activeFillColor: AppColors.orange.withOpacity(0.1),
                        inactiveFillColor: Colors.transparent,
                      ),
                      textStyle: TextStyle(
                        color: AppColors.txtcolr,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      animationDuration: Duration(milliseconds: 300),
                      enableActiveFill: true,
                      onChanged: (value) {},
                      beforeTextPaste: (text) => true,
                    ),
                  ),

                  SizedBox(height: 15.h),

                  /// Timer
                  Center(
                    child: Column(
                      children: [
                        ReuseText(
                          data: "A code has been sent to your phone",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.txtcolr,
                        ),
                        SizedBox(height: 8.h),
                        ReuseText(
                          data: _start > 0
                              ? "Resend in 00:${_start.toString().padLeft(2, '0')}"
                              : "Resend Code",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.orange,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25.h),

                  /// Verify Button
                  Center(
                    child: RoundedButton(
                      color: AppColors.orange,
                      text: "Verify",
                      onTap: verifyOtp,
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
