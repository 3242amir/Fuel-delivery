import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_utils/custom_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fuel_delivery/views/screens/delivery_home.dart';
import 'package:flutter_fuel_delivery/views/screens/on_boarding.dart';
import 'package:get/get.dart';

import '../../models/user.dart' as model;
import '../widgets/custom_radio.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  int value = 2;
  String userType = "User";
  var loading = false;
  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFEFEFE),
        body: CustomProgressWidget(
          loading: loading,
          child: SingleChildScrollView(
            child: Column(
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
                      "Create Account",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28.0,
                        fontFamily: 'Oxygen',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: Get.width * 0.9,
                          ),
                          child: const Text(
                            "Signup to keep exploring amazing\n destinations around the area!",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontFamily: 'Oxygen',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.05),
                      TextFormField(
                        controller: fullNameController,
                        decoration: InputDecoration(
                          hintText: "Full Name",
                          hintStyle: const TextStyle(
                            fontSize: 17.0,
                            fontFamily: 'Oxygen',
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          prefixIcon: const Icon(Icons.account_circle),
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
                        keyboardType: TextInputType.text,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      SizedBox(height: Get.height * 0.02),
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
                      Container(
                        height: Get.height * 0.06,
                        width: Get.width * 0.9,
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 237, 237, 237),
                              blurRadius: 3,
                              spreadRadius: 0.3,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Delivery Boy',
                              style: TextStyle(
                                fontFamily: 'Oxygen',
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            CustomRadio(
                              value: 1,
                              groupValue: value,
                              onPressed: (int v) {
                                setState(() {
                                  value = v;
                                  userType = "Delivery Boy";
                                });
                              },
                              color: Colors.grey,
                              selectedColor: const Color(0xFFFF681B),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Container(
                        height: Get.height * 0.06,
                        width: Get.width * 0.9,
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 237, 237, 237),
                              blurRadius: 3,
                              spreadRadius: 0.3,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Other',
                              style: TextStyle(
                                fontFamily: 'Oxygen',
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            CustomRadio(
                              value: 2,
                              groupValue: value,
                              onPressed: (int v) {
                                setState(() {
                                  value = v;
                                  userType = "User";
                                });
                              },
                              color: Colors.grey,
                              selectedColor: const Color(0xFFFF681B),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Get.height * 0.02),
                      ElevatedButton(
                        onPressed: () async {
                          String fullName = fullNameController.text;
                          String email = emailController.text;
                          String password = passwordController.text;
                          if (fullName.isEmpty ||
                              email.isEmpty ||
                              password.isEmpty) {
                            Get.snackbar("Alert", "All field required");
                            return;
                          }
                          setState(() {
                            loading = true;
                          });
                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: email, password: password)
                              .then((value) async {
                            var user = model.User(
                              name: fullName,
                              uid: value.user!.uid,
                              email: email,
                              password: password,
                              type: userType,
                              imgUrl: "",
                              token: "",
                            );
                            await FirebaseFirestore.instance
                                .collection("users")
                                .doc(user.uid)
                                .set(user.toMap());
                            if (user.type == "User") {
                              Get.offAll(const OnBoarding());
                            } else {
                              Get.offAll(const DeliveryHome());
                            }
                          }).catchError((error) {
                            setState(() {
                              loading = false;
                            });
                            Get.snackbar("Error", error.toString());
                          });
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
                          "LET'S GET STARTED",
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
        ),
      ),
    );
  }
}
