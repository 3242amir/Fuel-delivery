import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fuel_delivery/models/user.dart' as model;
import 'package:flutter_fuel_delivery/utils/image_uploader.dart';
import 'package:flutter_fuel_delivery/views/screens/login.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileLayout extends StatefulWidget {
  const ProfileLayout({super.key});

  @override
  State<ProfileLayout> createState() => _ProfileLayoutState();
}

class _ProfileLayoutState extends State<ProfileLayout> {
  @override
  Widget build(BuildContext context) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final ImagePicker imagePicker = ImagePicker();
    String imagePath = '';

    Future<void> pickImageFromGallery() async {
      final image = await imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        imagePath = image.path.toString();
        String uid = FirebaseAuth.instance.currentUser!.uid;
        String url = await ImageUploader.uploadImage(
            imagePath, "Fuel Delivery/$uid/image");
        await FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .update({"imgUrl": url})
            .then((value) => {})
            .catchError((onError) {
              Get.snackbar("Error", onError.toString());
            });

        setState(() {});
      }
    }

    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('users').doc(uid).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 3.8,
              backgroundColor: Color.fromARGB(255, 165, 180, 209),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          var user =
              model.User.fromMap(snapshot.data!.data() as Map<String, dynamic>);
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Profile",
                  style: TextStyle(
                      color: Color(0xFF393939),
                      fontSize: 25.0,
                      fontFamily: 'Oxygen',
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: Get.height * 0.07),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    imagePath.isNotEmpty
                        ? CircleAvatar(
                            radius: 45.0,
                            backgroundImage: FileImage(File(imagePath)),
                          )
                        : (user.imgUrl!.isNotEmpty)
                            ? CachedNetworkImage(
                                imageUrl: user.imgUrl!,
                                imageBuilder: (context, imageProvider) =>
                                    CircleAvatar(
                                  radius: 45.0,
                                  backgroundImage: imageProvider,
                                ),
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              )
                            : const CircleAvatar(
                                radius: 45.0,
                                backgroundImage: AssetImage(
                                  'assets/images/default_profile.png',
                                ),
                              ),
                    Positioned(
                      right: -3,
                      bottom: -3,
                      child: GestureDetector(
                        onTap: () {
                          pickImageFromGallery();
                        },
                        child: Container(
                          width: 34,
                          height: 34,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFF6F6FB),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 0.3,
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/icons/camera.svg',
                              width: 22.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.04),
                Container(
                  width: double.infinity,
                  height: 65.0,
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 236, 236, 236),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/person.svg',
                        width: 24.0,
                        colorFilter: const ColorFilter.mode(
                            Color(0xFFFF681B), BlendMode.srcIn),
                      ),
                      SizedBox(width: Get.width * 0.02),
                      Expanded(
                        child: Text(
                          user.name,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'Oxygen',
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 20.0,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Get.height * 0.03),
                Container(
                  width: double.infinity,
                  height: 65.0,
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 236, 236, 236),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/mail.svg',
                        width: 24.0,
                        colorFilter: const ColorFilter.mode(
                            Color(0xFFFF681B), BlendMode.srcIn),
                      ),
                      SizedBox(width: Get.width * 0.02),
                      Expanded(
                        child: Text(
                          user.email,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'Oxygen',
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 20.0,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Get.height * 0.03),
                Container(
                  width: double.infinity,
                  height: 65.0,
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 236, 236, 236),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/information.svg',
                        width: 24.0,
                        colorFilter: const ColorFilter.mode(
                            Color(0xFFFF681B), BlendMode.srcIn),
                      ),
                      SizedBox(width: Get.width * 0.02),
                      const Expanded(
                        child: Text(
                          'App Version 1.0',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'Oxygen',
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 20.0,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Get.height * 0.03),
                GestureDetector(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Get.offAll(const LoginScreen());
                  },
                  child: Container(
                    width: double.infinity,
                    height: 65.0,
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 236, 236, 236),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/logout.svg',
                          width: 24.0,
                          colorFilter: const ColorFilter.mode(
                              Color(0xFFFF681B), BlendMode.srcIn),
                        ),
                        SizedBox(width: Get.width * 0.02),
                        const Expanded(
                          child: Text(
                            'Log Out',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'Oxgyen',
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 20.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
