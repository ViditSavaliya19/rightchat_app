import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rightchat_app/utils/helper/auth_helper.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
              "Sign Up",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
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
                    .signUpWithEmailPassword(txtEmail.text, txtPassword.text);

                if (msg == "Success") {
                  Get.back();
                  Get.snackbar("Successful Register", "RightChat");
                } else {
                  Get.snackbar(msg, "Failed");
                }
              },
              child: const Text("SingUp"),
            ),

            const SizedBox(
              height: 50,
            ),
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("Yop have already account! Sign In"))
          ],
        ),
      ),
    );
  }
}
