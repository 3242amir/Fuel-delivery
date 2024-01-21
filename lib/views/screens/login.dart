import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_utils/custom_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fuel_delivery/views/screens/admin/admin.dart';
import 'package:flutter_fuel_delivery/views/screens/forgot_password.dart';
import 'package:flutter_fuel_delivery/views/screens/sign_up.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/firebase_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var loading = false;

  Future<void> saveAdminValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAdmin', true);
    Get.offAll(const AdminScreen());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFEFEFE),
        body: CustomProgressWidget(
          loading: loading,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Log In",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28.0,
                      fontFamily: 'Oxygen',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    "Welcome back!\nPlease log in to continue!",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontFamily: 'Oxygen',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: Get.height * 0.05),
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
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: const TextStyle(
                        fontSize: 17.0,
                        fontFamily: 'Oxygen',
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      prefixIcon: const Icon(Icons.lock),
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
                    keyboardType: TextInputType.visiblePassword,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  SizedBox(height: Get.height * 0.02),
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        Get.to(const ForgotPassword());
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17.0,
                            fontFamily: 'Oxygen'),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.02),
                  ElevatedButton(
                    onPressed: () async {
                      String email = emailController.text;
                      String password = passwordController.text;
                      if (email.isEmpty || password.isEmpty) {
                        Get.snackbar('Alert', 'All fields required');
                        return;
                      }
                      setState(() {
                        loading = true;
                      });

                      if (email == "admin") {
                        await saveAdminValue();
                      } else {
                        await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: email, password: password)
                            .then((value) {
                          FirebaseFirestore.instance
                              .collection("users")
                              .doc(value.user!.uid)
                              .update({"password": password});
                          getScreen().then((value) {
                            Get.off(value);
                          });
                        }).catchError((onError) {
                          setState(() {
                            loading = false;
                          });
                          Get.snackbar('Error', onError.toString());
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
                      'LOG IN',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17.0, fontFamily: 'Oxygen'),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.03),
                  Align(
                    alignment: Alignment.center,
                    child: Text.rich(
                      TextSpan(
                        text: "Don't have an account? ",
                        style: const TextStyle(
                          fontFamily: 'Oxygen',
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: 'SignUp',
                            style: const TextStyle(
                              fontFamily: 'Oxygen',
                              fontSize: 18.0,
                              color: Color(0xFFFF681B),
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.to(const SignUp());
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
