import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rightchat_app/screen/users/controller/users_controller.dart';
import 'package:rightchat_app/utils/helper/auth_helper.dart';
import 'package:rightchat_app/utils/helper/db_helper.dart';

class AlluserScreen extends StatefulWidget {
  const AlluserScreen({super.key});

  @override
  State<AlluserScreen> createState() => _AlluserScreenState();
}

class _AlluserScreenState extends State<AlluserScreen> {
  UserController controller = Get.put(UserController());
  @override
  void initState() {
    controller.getUsers();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      body: Obx(
        () =>  ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () async {
                await FireDbHelper.helper.getChatDocID(AuthHelper.helper.user!.uid, controller.userList[index].uid!);
                Get.toNamed('/chat',arguments: controller.userList[index]);
              },
              leading: CircleAvatar(
                child: Text(controller.userList[index].name![0]),
              ),
              title: Text("${controller.userList[index].name}"),
              subtitle: Text("${controller.userList[index].mobile}"),
            );
          },
          itemCount: controller.userList.length,
        ),
      ),
    );
  }
}
