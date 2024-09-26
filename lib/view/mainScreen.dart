// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherapp/controller/global_controller.dart';
import 'package:weatherapp/utils/constant.dart';
import 'package:weatherapp/utils/widgets/headerWidget.dart';

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
      appBar: AppBar(
        elevation: 10,
        shadowColor: AppColor.appbarColor,
        toolbarHeight: 80,
        backgroundColor: AppColor.appbarColor,title: Text('WeatherApp',style: text(32, AppColor.appMainColor),),),
      body: SafeArea(
          child: Obx(() => globalController.checkLoading().isTrue
              ? Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: AppColor.background
                ),
                child: const Center(
                    child: CircularProgressIndicator(),
                  ),
              )
              : Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: AppColor.background
                ),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    const HeaderWidget()
                  ],
                ),
                ))),
    );
  }
}
