import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rightchat_app/screen/home/controller/home_controller.dart';
import 'package:rightchat_app/screen/profile/model/profile_model.dart';
import 'package:rightchat_app/utils/helper/auth_helper.dart';
import 'package:rightchat_app/utils/helper/db_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    homeController.getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Right Chat"),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            ListTile(
              onTap: () async {
                Get.offAllNamed('/profile');
              },
              title: const Text("Profile"),
              leading: const Icon(Icons.account_circle),
            ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/users');
        },
        child: const Icon(Icons.person),
      ),
      body: StreamBuilder(
        stream: homeController.chatUsers,
        builder: (context, snapshot)  {
          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else if (snapshot.hasData) {
            homeController.userList.clear();
            QuerySnapshot? qs = snapshot.data;

            List<QueryDocumentSnapshot> qsList = qs!.docs;

            for (var x in qsList) {
              Map m1 = x.data() as Map;
              List uidList = m1['uids'];
              String receiverID = "";
              if (uidList[0] == AuthHelper.helper.user!.uid) {
                receiverID = uidList[1];
              } else {
                receiverID = uidList[0];
              }

              //getUserData receiver User UID
              homeController.getUIDUsers(receiverID).then((value) {
                homeController.userList.add(homeController.model!);
              },);
            }

            return Obx(
              () => ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () async {
                      await FireDbHelper.helper.getChatDocID(AuthHelper.helper.user!.uid, homeController.userList[index].uid!);
                      Get.toNamed('/chat',arguments: homeController.userList[index]);
                    },
                    leading: CircleAvatar(
                      child: Text("${homeController.userList[index].name![0]}"),
                    ),
                    title:  Text("${homeController.userList[index].name}"),
                    subtitle: Text("${homeController.userList[index].mobile}"),
                  );
                },
                itemCount: homeController.userList.length,
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
