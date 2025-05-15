import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visionhr/widgets/roundedButton.dart';
import '../../../utils/colors.dart';
import '../../../widgets/reusetext.dart';
class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              SizedBox(height: 20,),
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/profile.jpg'), // Add your image
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
                  style: TextStyle( color: AppColors.txtgrey,),
                ),
              ),
              const SizedBox(height: 10),
             Center(
               child: RoundedButton(text: "Edit Ptofile", onTap: (){},
               textColor: AppColors.orange,height: 22,width: 110,
               ),
             ),
              const SizedBox(height: 30),
              // Settings list
              Expanded(
                child: ListView(
                  children: const [
                    SettingsTile(icon: Icons.language, title: 'Language', subtitle: 'English'),
                    SettingsTile(icon: Icons.notifications_none, title: 'Notification'),
                    SettingsTile(icon: Icons.phone, title: 'Contact Us'),
                    SettingsTile(icon: Icons.privacy_tip_outlined, title: 'Terms & Privacy Policy'),
                    SettingsTile(icon: Icons.logout, title: 'Log Out'),
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


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Profile picture

          ],
        ),
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
  });

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
      onTap: () {},
    );
  }
}
