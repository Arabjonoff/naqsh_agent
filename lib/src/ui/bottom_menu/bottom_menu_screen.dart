import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naqsh_agent/src/theme/app_theme.dart';
import 'package:naqsh_agent/src/ui/bottom_menu/home/home_screen.dart';
import 'package:naqsh_agent/src/ui/debt/debt_screen.dart';
import 'package:naqsh_agent/src/ui/income/income_screen.dart';

import '../expense/expense_screen.dart';

class BottomMenuScreen extends StatefulWidget {
  const BottomMenuScreen({Key? key}) : super(key: key);

  @override
  State<BottomMenuScreen> createState() => _BottomMenuScreenState();
}
int _selectedIndex = 2;

class _BottomMenuScreenState extends State<BottomMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
         setState(() {
           _selectedIndex = index;
         });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppTheme.purple,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons/profile.svg',color: _selectedIndex == 0?AppTheme.purple:null,),label: 'Profile'),
          BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons/receipt.svg',color: _selectedIndex == 1?AppTheme.purple:null,),label: 'Harajat'),
          BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons/home.svg'),label: 'Asosiy'),
          BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons/money.svg',color: _selectedIndex == 3?AppTheme.purple:null,),label: 'Kirim'),
          BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons/money_send.svg',color: _selectedIndex == 4?AppTheme.purple:null,),label: 'Chiqim'),
        ],
      ),
      body: [
        HomeScreen(),
        ExpenseScreen(),
        HomeScreen(),
        IncomeScreen(),
        DebtScreen(),
      ][_selectedIndex],
    );
  }
}
