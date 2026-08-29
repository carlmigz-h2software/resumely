import 'package:flutter/material.dart';
import 'package:resumely/app/components/bottom_nav_bar.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/features/home/presentation/pages/home_page.dart';
import 'package:resumely/features/profile/presentation/pages/profile_page.dart';
import 'package:resumely/features/resume/presentation/pages/resumes_page.dart';

class MainNavigationPage extends StatefulWidget {
  static const path = '/home';
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    ResumesPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
