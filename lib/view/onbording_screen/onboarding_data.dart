// onboarding_data.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:visionhr/widgets/roundedButton.dart';
import '../../utils/colors.dart';

// Import your other picker components
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

  // User input data variables
  String? selectedGender;
  final TextEditingController _nameController = TextEditingController();

  // New state variables to collect data from child pickers:
  DateTime? selectedBirthday;
  double? selectedWeight;
  String? selectedHealthReminder;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _pages = [
      _buildNamePage(),
      _buildGenderPage(),
      BirthdayPickerScreen(
        onBirthdaySelected: (birthday) {
          selectedBirthday = birthday;
        },
      ),
      WeightPickerScreen(
        onWeightSelected: (weight) {
          selectedWeight = weight;
        },
      ),


      HealthReminderPicker(
        onReminderSelected: (reminder) {
          selectedHealthReminder = reminder;
        },
      ),

    ];
  }

  Widget _buildProgressBar() {
    double progressValue = _pages.isNotEmpty ? (_currentPage + 1) / _pages.length : 0;
    return LinearProgressIndicator(
      value: progressValue,
      backgroundColor: Colors.grey.shade800,
      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
    );
  }

  Future<void> _handleFinish() async {
    final name = _nameController.text.trim();
    final uid = FirebaseAuth.instance.currentUser?.uid;

    // List to keep track of missing fields
    List<String> missingFields = [];

    if (uid == null) {
      // Optional: handle user not logged in case
      missingFields.add("User login");
    }
    if (name.isEmpty) missingFields.add("Name");
    if (selectedGender == null) missingFields.add("Gender");
    if (selectedBirthday == null) missingFields.add("Birthday");
    if (selectedWeight == null) missingFields.add("Weight");
    if (selectedHealthReminder == null) missingFields.add("Health Reminder");

    if (missingFields.isNotEmpty) {
      final message = "Please fill the following fields:\n" + missingFields.join(", ");
      Get.snackbar(
        "Missing Info",
        message,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Show saving dialog and save data
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
              CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppColors.orange)),
              const SizedBox(height: 20),
              Text("Saving your data...", style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );

    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'name': name,
        'gender': selectedGender,
        'birthday': selectedBirthday!.toIso8601String(),
        'weight': selectedWeight,
        'healthReminder': selectedHealthReminder,
      }, SetOptions(merge: true));

      Navigator.of(context).pop(); // Close dialog
      Get.snackbar("Success", "Data saved", backgroundColor: Colors.green, colorText: Colors.white);

      // Navigate to next phase or home
    } catch (e) {
      Navigator.of(context).pop(); // Close dialog
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red, colorText: Colors.white);
    }
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
            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: TextField(
              controller: _nameController,
              textAlign: TextAlign.center,
              style: _inputTextStyle(),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter your name',
                hintStyle: _inputTextStyle().copyWith(color: Colors.grey),
              ),
              cursorColor: Colors.white,
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
            _genderButton(Icons.male, "Male"),
            SizedBox(width: 30.w),
            _genderButton(Icons.female, "Female"),
          ],
        ),
        SizedBox(height: 20.h),
        Center(
          child: RoundedButton(
            text: "Prefer not to say",
            width: 200,
            color: selectedGender == "Prefer not to say" ? Colors.orange : Colors.grey.shade800,
            onTap: () => setState(() => selectedGender = "Prefer not to say"),
          ),
        ),
      ],
    );
  }

  Widget _genderButton(IconData icon, String label) {
    final isSelected = selectedGender == label;
    return GestureDetector(
      onTap: () => setState(() => selectedGender = label),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: isSelected ? Colors.orange : Colors.grey.shade800,
            radius: 30.r,
            child: Icon(icon, color: Colors.white),
          ),
          SizedBox(height: 8.h),
          Text(label, style: TextStyle(color: Colors.white)),
        ],
      ),
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
      _controller.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void _skipToLastPage() {
    _controller.animateToPage(_pages.length - 1, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
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
                  Expanded(child: _buildProgressBar()),
                  SizedBox(width: 20.w),
                  TextButton(
                    onPressed: _skipToLastPage,
                    child: Text("Skip", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
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
              SizedBox(height: 20.h),
              Center(
                child: RoundedButton(
                  text: _currentPage == _pages.length - 1 ? "Finish" : "Continue",
                  color: AppColors.orange,
                  onTap: () {
                    if (_currentPage == _pages.length - 1) {
                      _handleFinish();
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
