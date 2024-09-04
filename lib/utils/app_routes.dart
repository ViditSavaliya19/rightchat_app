import 'package:flutter/cupertino.dart';
import 'package:rightchat_app/screen/chat/view/chat_screen.dart';
import 'package:rightchat_app/screen/profile/view/profile_screen.dart';
import 'package:rightchat_app/screen/users/view/alluser_screen.dart';

import '../screen/home/view/home_screen.dart';
import '../screen/login/view/signIn_screen.dart';
import '../screen/login/view/signup_screen.dart';
import '../screen/splash/view/splash_screen.dart';

Map<String, WidgetBuilder> appRoutes = {
  '/':(c1) => const SplashScreen(),
  '/signIn':(c1) => const SignInScreen(),
  '/signUp':(c1) => const SignUpScreen(),
  '/home':(c1) => const HomeScreen(),
  '/profile':(c1) => const ProfileScreen(),
  '/users':(c1) => const AlluserScreen(),
  '/chat':(c1) => const ChatScreen(),
};
