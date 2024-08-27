import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rightchat_app/utils/helper/auth_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Right Chat"),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const Spacer(),
            ListTile(
              onTap: () async {
                await AuthHelper.helper.signOut();
                Get.offAllNamed('/signIn');
              },
              title: const Text("logout"),
              leading: const Icon(Icons.logout),
            )
          ],
        ),
      ),
    );
  }
}
