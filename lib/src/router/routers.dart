import 'package:flutter/material.dart';
import 'package:naqsh_agent/src/ui/auth/verification/verfication_screen.dart';
import 'package:naqsh_agent/src/ui/language/onboarding/onboarding_screen.dart';

import '../ui/auth/login/login_screen.dart';
import '../ui/language/language_screen.dart';

class RouterGenerator {
  Route? onGenerator(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      case '/':
        return _navigate(const LanguageScreen());

      case '/login':
        return _navigate(const LoginScreen());

      case '/boarding':
        return _navigate(const OnBoardingScreen());

      case '/verfication':
        return _navigate(const VerficationScreen());
    }
  }
}

_navigate(Widget screen) {
  return MaterialPageRoute(builder: (context) => screen);
}
