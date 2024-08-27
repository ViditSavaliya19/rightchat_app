import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rightchat_app/utils/helper/auth_helper.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Right Chat",
              style: TextStyle(
                  fontSize: 35,
                  color: Colors.green,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Sign In",
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              controller: txtEmail,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: txtPassword,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                String msg = await AuthHelper.helper
                    .signInEmailPassword(txtEmail.text, txtPassword.text);
                if(msg =="Success")
                  {
                    Get.offAndToNamed('/home');
                    Get.snackbar("Success", "RightApp");
                  }
                else
                  {
                    Get.snackbar(msg, "Failed");
                  }
              },
              child: const Text("SingIn"),
            ),
            const SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: ()async {
                String msg = await AuthHelper.helper.signWithGoogle();
                if(msg =="Success")
                {
                  Get.offAndToNamed('/home');
                  Get.snackbar("Success", "RightApp");
                }
                else
                {
                  Get.snackbar(msg, "Failed");
                }
              },
              child: Card(
                child: Image.asset(
                  "assets/images/google.png",
                  width: 200,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextButton(
                onPressed: () {
                  Get.toNamed('/signUp');
                },
                child: const Text("Create new Account? Sign Up"))
          ],
        ),
      ),
    );
  }
}
