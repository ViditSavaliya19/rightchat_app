import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rightchat_app/utils/app_color.dart';
import 'package:rightchat_app/utils/helper/auth_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {

    bool isLogin = AuthHelper.helper.checkUser();

    Timer(
      const Duration(seconds: 3),
      () => Get.offAllNamed(isLogin?'/home':'/signIn'),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Icon(
          Icons.message,
          color: green,
          size: 100,
        ),
      ),
    );
  }
}
