import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../utils/colors.dart';
import '../../../../widgets/reusetext.dart';
import '../../../../widgets/roundedButton.dart';
import '../../../../widgets/txtfield.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  XFile? _image;
  String? _base64Image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _image = pickedFile;
        _base64Image = base64Encode(bytes);
      });
    }
  }

  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) return;

    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      Get.snackbar("Error", "User not logged in",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'firstName': firstNameController.text.trim(),
        'lastName': lastNameController.text.trim(),
        'age': ageController.text.trim(),
        'weight': weightController.text.trim(),
        if (_base64Image != null) 'imageBase64': _base64Image,
      });

      Get.snackbar("Success", "Profile updated",
          backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          child: Icon(
                            Icons.arrow_back,
                            size: 18,
                            color: AppColors.txtcolr,
                          ),
                        ),
                      ),
                      ReuseText(
                        data: "Edit Profile",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.txtcolr,
                      ),
                      const SizedBox(width: 32),
                    ],
                  ),
                  SizedBox(height: 40),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: _image != null
                            ? FileImage(File(_image!.path))
                            : const AssetImage('assets/placeholder.jpg')
                        as ImageProvider,
                        backgroundColor: Colors.grey[800],
                      ),
                      Positioned(
                        bottom: 30,
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.black45,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(8),
                            child: const Icon(Icons.camera_alt, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  TxtField(
                    hintText: "Enter First Name",
                    controller: firstNameController,
                    labelText: "First Name",
                    showLabelText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return "First Name is required";
                      return null;
                    },
                  ),
                  SizedBox(height: 15.h),
                  TxtField(
                    hintText: "Enter Last Name",
                    controller: lastNameController,
                    labelText: "Last Name",
                    showLabelText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return "Last Name is required";
                      return null;
                    },
                  ),
                  SizedBox(height: 15.h),
                  TxtField(
                    hintText: "Enter Age",
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    labelText: "Age",
                    showLabelText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Age is required";
                      return null;
                    },
                  ),
                  SizedBox(height: 15.h),
                  TxtField(
                    hintText: "Enter Weight",
                    controller: weightController,
                    labelText: "Weight",
                    keyboardType: TextInputType.number,
                    showLabelText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return "Weight is required";
                      return null;
                    },
                  ),
                 SizedBox(height: 70,),
                  RoundedButton(
                    text: "Save Changes",
                    onTap: _saveChanges,
                    color: AppColors.orange,
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
