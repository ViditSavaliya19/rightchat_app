import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rightchat_app/screen/login/controller/login_controller.dart';
import 'package:rightchat_app/screen/profile/model/profile_model.dart';
import 'package:rightchat_app/utils/helper/db_helper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtBio = TextEditingController();
  LoginController controller =Get.put(LoginController());
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData()async
  {
    await controller.getProfileData();
    if(controller.profileModel!=null) {
      txtName.text = controller.profileModel!.name!;
      txtMobile.text = controller.profileModel!.mobile!;
      txtEmail.text = controller.profileModel!.email!;
      txtBio.text = controller.profileModel!.bio!;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Column(
        children: [
          TextField(
            controller: txtName,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), labelText: "Name"),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: txtBio,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), labelText: "Bio"),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: txtMobile,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), labelText: "Mobile"),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: txtEmail,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), labelText: "Email"),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton.icon(
            onPressed: () async {

              ProfileModel model=ProfileModel(
                name: txtName.text,
                email: txtEmail.text,
                mobile: txtMobile.text,
                bio: txtBio.text
              );

             await FireDbHelper.helper.setProfile(model);
             Get.offAllNamed('/home');
            },
            label: const Text("Next"),
            icon: const Icon(Icons.arrow_forward),
          )
        ],
      ),
    );
  }
}
