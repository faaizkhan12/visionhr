import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:visionhr/widgets/roundedButton.dart';

import '../../utils/colors.dart';
import '../lets_started/lets_startded.dart';
import 'onboarding_data_component/HealthReminderPicker.dart';
import 'onboarding_data_component/calnder.dart';
import 'onboarding_data_component/weight.dart';

class OnboardingData extends StatefulWidget {
  const OnboardingData({Key? key}) : super(key: key);

  @override
  State<OnboardingData> createState() => _OnboardingDataState();
}

class _OnboardingDataState extends State<OnboardingData> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      _buildNamePage(),
      _buildGenderPage(),
      BirthdayPickerScreen(),
      WeightPickerScreen(),
      HealthReminderPicker(),
    ]);
  }

  Widget _buildProgressBar() {
    double progressValue = _pages.isNotEmpty ? (_currentPage + 1) / _pages.length : 0;
    return LinearProgressIndicator(
      value: progressValue,
      backgroundColor: Colors.grey.shade800,
      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
    );
  }
  void _handleFinish(BuildContext context) async {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: AppColors.nbgcolr,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
              ),
              const SizedBox(height: 20),
              Text(
                "Creating your Account ...",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );

    await Future.delayed(Duration(seconds: 2));

    Navigator.of(context).pop();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Lets_Started()),
    );
  }



  Widget _buildNamePage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        Center(child: Text("What's your name?", style: _questionStyle())),
        SizedBox(height: 200.h),
        Center(
          child: Container(

            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 30.w),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: Text("Andrew", style: _inputTextStyle()),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        Center(child: Text("What's your gender?", style: _questionStyle())),
        SizedBox(height: 200.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _genderButton(Icons.male, "Male", true),
            SizedBox(width: 30.w),
            _genderButton(Icons.female, "Female", false),
          ],
        ),
        SizedBox(height: 20.h),
        Center(child: RoundedButton(text: "Prefer not to say",
          onTap: () {},)),

      ],
    );
  }

  Widget _genderButton(IconData icon, String label, bool selected) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: selected ? Colors.red : Colors.grey.shade800,
          radius: 30.r,
          child: Icon(icon, color: Colors.white),
        ),
        SizedBox(height: 8.h),
        Text(label, style: TextStyle(color: Colors.white)),
      ],
    );
  }

  Widget _buildPlaceholderPage(String label) {
    return Center(
      child: Text(label, style: TextStyle(color: Colors.white, fontSize: 24.sp)),
    );
  }

  TextStyle _questionStyle() {
    return TextStyle(
      color: Colors.white,
      fontSize: 24.sp,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle _inputTextStyle() {
    return TextStyle(
      color: Colors.white,
      fontSize: 20.sp,
    );
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _controller.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Final action (e.g., save onboarding status)
    }
  }

  void _skipToLastPage() {
    _controller.animateToPage(
      _pages.length - 1,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
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
                  SizedBox(width: 20.w),
                  Expanded(
                    child: _buildProgressBar(),
                  ),
                  SizedBox(width: 20.w),
                  TextButton(
                    onPressed: _skipToLastPage,
                    child: Text("Skip", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),



              // Progress bar

              SizedBox(height: 20.h),

              // Page content
              Expanded(
                child: PageView(
                  controller: _controller,
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  children: _pages,
                ),
              ),

              // Continue button
              SizedBox(height: 20.h),
              Center(
                child: RoundedButton(
                  text: _currentPage == _pages.length - 1 ? "Finish" : "Continue",
                  color: AppColors.orange,
                  onTap: () {
                    if (_currentPage == _pages.length - 1) {
                      _handleFinish(context);
                    } else {
                      _nextPage();
                    }
                  },
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
