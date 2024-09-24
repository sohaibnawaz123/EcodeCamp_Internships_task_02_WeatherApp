// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherapp/controller/global_controller.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Obx(() => globalController.checkLoading().isTrue
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  child: Text('Hello'),
                ))),
    );
  }
}
