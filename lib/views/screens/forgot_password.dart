import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  var emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFEFEFE),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Get.height * 0.015),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  splashRadius: 22.0,
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                  ),
                ),
                SizedBox(width: Get.width * 0.01),
                const Text(
                  "Forgot Password",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28.0,
                    fontFamily: 'Oxygen',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.02),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "Email Address",
                      hintStyle: const TextStyle(
                        fontSize: 17.0,
                        fontFamily: 'Oxygen',
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      prefixIcon: const Icon(Icons.email_rounded),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFFF6F6FB),
                          width: 0.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFFF6F6FB),
                          width: 0.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      fillColor: const Color(0xFFF6F6FB),
                      filled: true,
                    ),
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  SizedBox(height: Get.height * 0.02),
                  ElevatedButton(
                    onPressed: () async {
                      String email = emailController.text.toString();
                      if (email.isEmpty) {
                        Get.snackbar("Alert", "Field is required");
                      } else {
                        await FirebaseAuth.instance
                            .sendPasswordResetEmail(email: email)
                            .then((value) {
                          Get.snackbar("Alert", "Check your email");
                        }).catchError((onError) {
                          Get.snackbar("Error", onError.toString());
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFFFF681B),
                      minimumSize: Size(Get.width * 0.9, 52.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text(
                      "Forgot Password",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Oxygen',
                        fontSize: 17.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
