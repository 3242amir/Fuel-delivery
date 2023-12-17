import 'package:custom_utils/custom_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:messagepro/working/plant.dart';

import '../Widgets/COLORS.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("User Information"),
        ),
        body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 20.sp,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                        color: COLORS.light,
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "First Name",
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          border: InputBorder.none),
                    ),
                  ),
                ),SizedBox(
                  height: 20.sp,
                ),
                Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                      color: COLORS.light, borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: "Last Name",
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        border: InputBorder.none),
                  ),
                ),SizedBox(
                  height: 20.sp,
                ),
                Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                      color: COLORS.light, borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        hintText: "Phone Number",
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        border: InputBorder.none),
                  ),
                ),SizedBox(
                  height: 20.sp,
                ),
                Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                      color: COLORS.light, borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: "Email",
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        border: InputBorder.none),
                  ),
                ),SizedBox(
                  height: 20.sp,
                ),
                Container(
                  alignment: Alignment.topCenter,
                  height: 150,
                  width: 300,
                  decoration: BoxDecoration(
                      color: COLORS.light, borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: "Comments (Optional)",
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  height: 20.sp,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(PlantBooking());
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 120,
                        decoration: BoxDecoration(
                            color: Colors.light,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text("Continue"),
                      ),
                    ),
                    SizedBox(
                      width: 58,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 120,
                      decoration: BoxDecoration(
                          color: COLORS.light,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text("Cancel"),
                    ),
                  ],
                ),
                SizedBox(
                  height: 100.sp,
                )
              ],
            ),
             ),
            );
      }
}