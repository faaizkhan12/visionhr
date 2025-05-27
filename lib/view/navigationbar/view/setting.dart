import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visionhr/view/navigationbar/view/seeting_view/edit_profle.dart';
import 'package:visionhr/widgets/roundedButton.dart';
import '../../../utils/colors.dart';
import '../../../widgets/dilougBox.dart';
import '../../../widgets/reusetext.dart';
import '../../splash_screen/splash_screen.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _logout() async {
    try {
      // Google sign-out
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
      }

      // Firebase sign-out
      await FirebaseAuth.instance.signOut();

      // Clear shared preferences safely
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      // Navigate to splash
      Get.offAll(() => const SplashScreen());
    } catch (e) {
      print("Logout error: $e");
      Get.snackbar("Logout Failed", e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 32),
                  ReuseText(
                    data: "Setting",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.txtcolr,
                  ),
                  const SizedBox(width: 32),
                ],
              ),
              const SizedBox(height: 20),
              // Profile picture
              Center(
                child: const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/profile.jpg'),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: const Text(
                  'Ali Khan',
                  style: TextStyle(
                    color: AppColors.txtcolr,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: const Text(
                  'alikhan67@gmail.com',
                  style: TextStyle(color: AppColors.txtgrey),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: RoundedButton(
                  text: "Edit Profile",
                  onTap: () {
                    Get.to(EditProfileScreen());
                  },
                  textColor: AppColors.orange,
                  height: 22,
                  width: 110,
                ),
              ),
              const SizedBox(height: 30),

              // Settings list
              Expanded(
                child: ListView(
                  children: [
                    SettingsTile(
                      icon: Icons.language,
                      title: 'Language',
                      subtitle: 'English',
                    ),
                    SettingsTile(
                      icon: Icons.notifications_none,
                      title: 'Notification',
                    ),
                    SettingsTile(
                      icon: Icons.phone,
                      title: 'Contact Us',
                    ),
                    SettingsTile(
                      icon: Icons.privacy_tip_outlined,
                      title: 'Terms & Privacy Policy',
                    ),
                    SettingsTile(
                      icon: Icons.logout,
                      title: 'Log Out',
                      onTap: () {
                        showCustomDialog(
                          context: context,
                          message: "Are you sure you want to log out?",
                          cancelText: "Cancel",
                          confirmText: "Confirm",
                          onCancel: () {},
                          onConfirm: () {
                            _logout();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;

  const SettingsTile({
    Key? key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: subtitle != null
          ? Text(subtitle!, style: const TextStyle(color: Colors.white54))
          : null,
      trailing: const Icon(Icons.arrow_forward_ios, color: AppColors.orange, size: 16),
      onTap: onTap,
    );
  }
}
