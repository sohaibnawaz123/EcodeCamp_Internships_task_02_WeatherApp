
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant.dart';

Widget weatherDetail(String data, IconData icon, dynamic value,Color color) {
  return Container(
    width: Get.width/4.5,
    height: Get.height/7,
    decoration:BoxDecoration(
      border: Border.all(width: 2,color: AppColor.textColor),
      color: AppColor.appbarColor,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      boxShadow: const [
        BoxShadow(offset: Offset(0, 1),
        color: AppColor.headingColor,blurRadius: 5,
        spreadRadius: 0),
        
      ]
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,color: color,size: 36,),
          const SizedBox(height: 10,),
          Text(data,style: text(20, AppColor.textColor),),
          const SizedBox(height: 10,),
          Text(value is String?value:value.toString(),style: text(18, AppColor.textColor),),
        ],
      ),
    ),
  );
}
