import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naqsh_agent/src/ui/bottom_menu/home/home_screen.dart';

class BottomMenuScreen extends StatefulWidget {
  const BottomMenuScreen({Key? key}) : super(key: key);

  @override
  State<BottomMenuScreen> createState() => _BottomMenuScreenState();
}
int _selectedIndex = 0;

class _BottomMenuScreenState extends State<BottomMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons/profile.svg'),label: 'salom'),
          BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons/profile.svg'),label: 'salom'),
          BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons/profile.svg'),label: 'salom'),
        ],
      ),
      body: [
        HomeScreen(),
      ][_selectedIndex],
    );
  }
}
