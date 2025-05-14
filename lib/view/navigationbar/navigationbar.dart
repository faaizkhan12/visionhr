import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:visionhr/view/navigationbar/view/home_page.dart';
import '../../utils/colors.dart';

const TextStyle _textStyle = TextStyle(
  fontSize: 38,
  fontWeight: FontWeight.bold,
  letterSpacing: 2,
  fontStyle: FontStyle.italic,
);


class Navigationbar extends StatefulWidget {
  final int initialIndex;

  const Navigationbar({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  State<Navigationbar> createState() => _NavigationbarState();
}

class _NavigationbarState extends State<Navigationbar> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: SafeArea(
            child: Center(
              child: pages[_currentIndex],
            ),
          ),
          bottomNavigationBar: CurvedNavigationBar(
            index: _currentIndex,
            height: 60.0,
            backgroundColor: AppColors.nbgcolr,
            buttonBackgroundColor: AppColors.orange,
            color: AppColors.bgcolr,
            animationDuration: const Duration(milliseconds: 300),
            onTap: (int newIndex) {
              setState(() {
                _currentIndex = newIndex;
              });
            },
            items: [
              ImageIcon(
                AssetImage('assets/scannericon.png'),
                color: _currentIndex == 2 ? Colors.white : AppColors.txtcolr,
              ),
              ImageIcon(
                AssetImage('assets/Icon (1).png'),
                color: _currentIndex == 2 ? Colors.white : AppColors.txtcolr,
              ),
              ImageIcon(
                AssetImage('assets/Icon (2).png'),
                color: _currentIndex == 2 ? Colors.white : AppColors.txtcolr,
              ),
              ImageIcon(
                AssetImage('assets/Icon (3).png'),
                color: _currentIndex == 3 ? Colors.white : AppColors.txtcolr,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> get pages {
    return [
      const HomePage(),
      const Text("Page 2"),
      const Text("Page 3"),
      const Text("Page 4"),
    ];
  }
}
