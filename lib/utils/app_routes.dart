import 'package:flutter/cupertino.dart';

import '../screen/home/view/home_screen.dart';
import '../screen/login/view/signIn_screen.dart';
import '../screen/login/view/signup_screen.dart';
import '../screen/splash/view/splash_screen.dart';

Map<String, WidgetBuilder> appRoutes = {
  '/':(c1) => const SplashScreen(),
  '/signIn':(c1) => const SignInScreen(),
  '/signUp':(c1) => const SignUpScreen(),
  '/home':(c1) => const HomeScreen(),
};
