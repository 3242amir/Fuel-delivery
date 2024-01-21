import 'package:flutter/material.dart';
import 'package:flutter_fuel_delivery/views/screens/admin/delivery_tab.dart';
import 'package:flutter_fuel_delivery/views/screens/admin/home_tab.dart';
import 'package:get/get.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFEFEFE),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Get.height * 0.02),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Admin Dashboard",
                style: TextStyle(
                  color: Color(0xFF0F0F0F),
                  fontSize: 22.0,
                  fontFamily: 'Oxygen',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.02),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 50,
                width: Get.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 237, 237, 237),
                      blurRadius: 3,
                      spreadRadius: 0.3,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TabBar(
                    controller: tabController,
                    indicatorColor: const Color(0xFFFF681B),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    indicator: BoxDecoration(
                      color: const Color(0xFFFF681B),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    tabs: const [
                      Tab(
                        child: Text(
                          "Home",
                          style: TextStyle(
                            fontFamily: 'Oxygen',
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Delivery",
                          style: TextStyle(
                            fontFamily: 'Oxygen',
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.02),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const [
                  HomeTab(),
                  DeliveryTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
