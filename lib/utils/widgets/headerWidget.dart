import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/utils/constant.dart';

import '../../controller/global_controller.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  String city = '';
  String country = '';
  String date = DateFormat('yMMMMd').format(DateTime.now());
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  @override
  void initState() {
    getLocation(globalController.getlatitude().value,
        globalController.getlongitude().value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: const BorderSide(
              width: 2, color: AppColor.tilebgColor, style: BorderStyle.solid)),
      title: Text(
        city,
        style: text(32, AppColor.appMainColor),
      ),
      subtitle: Text(
        date,
        style: text(20, AppColor.textColor),
      ),
    );
  }

  void getLocation(lat, long) async {
    List<Placemark> placemark = await placemarkFromCoordinates(lat, long);
    Placemark place = placemark[0];
    setState(() {
      city = place.locality!;
      country = place.country!;
    });
  }
}
