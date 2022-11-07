import 'package:flutter/material.dart';
import 'package:naqsh_agent/src/ui/auth/register/register_screen.dart';
import 'package:naqsh_agent/src/ui/auth/verification/verfication_screen.dart';
import 'package:naqsh_agent/src/ui/bottom_menu/bottom_menu_screen.dart';
import 'package:naqsh_agent/src/ui/income/income_screen.dart';
import 'package:naqsh_agent/src/ui/language/onboarding/onboarding_screen.dart';
import 'package:naqsh_agent/src/ui/wallet/wallet_history/wallet_history_screen.dart';
import 'package:naqsh_agent/src/ui/wallet/wallet_screen.dart';

import '../ui/auth/login/login_screen.dart';
import '../ui/language/language_screen.dart';

class RouterGenerator {
  Route? onGenerator(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      case '/':
        return _navigate(const LanguageScreen());

      case '/login':
        return _navigate(LoginScreen());

      case '/boarding':
        return _navigate(const OnBoardingScreen());

      case '/register':
        return _navigate(RegisterScreen());

      case '/verfication':
        return _navigate(const VerficationScreen());

      case '/bottomMenu':
        return _navigate(const BottomMenuScreen());

      case '/wallet':
        return _navigate(const WalletScreen());

      case '/wallet_history':
        return _navigate(const WalletHistoryScreen());

      case '/income':
        return _navigate(const IncomeScreen());
    }
  }
}

_navigate(Widget screen) {
  return MaterialPageRoute(builder: (context) => screen);
}
