// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/sevicesController.dart';
import '../utils/constant.dart';

class ForecastScreen extends StatefulWidget {
  String city;
  ForecastScreen({super.key, required this.city});

  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  final ServiceController serviceController = Get.put(ServiceController());
  List<dynamic>? forecastday;

  @override
  void initState() {
    super.initState();
    _fetchForecast();
  }

  Future<void> _fetchForecast() async {
    try {
      final forecastdata =
          await serviceController.fetch7dayWeather(widget.city);
      setState(() {
        forecastday = forecastdata['forecast']['forecastday'];
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 10,
          shadowColor: AppColor.appbarColor,
          toolbarHeight: 80,
          backgroundColor: AppColor.appbarColor,
          title: Text(
            '7 Days Forecast ',
            style: text(32, AppColor.appMainColor),
          ),
        ),
        body: SafeArea(
          child: forecastday == null
              ? Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration:
                      const BoxDecoration(gradient: AppColor.background),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Container(
                  height: Get.height,
                  width: Get.width,
                  decoration:
                      const BoxDecoration(gradient: AppColor.background),
                  child: ListView.builder(itemCount: forecastday!.length,itemBuilder: (context, index) {
                    final day = forecastday![index];
                    String iconUrl = "http:${day['day']['condition']['icon']}";
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                      decoration: BoxDecoration(
                          color: AppColor.tilebgColor,
                          borderRadius: BorderRadius.circular(20),
                          border:
                              Border.all(width: 3, color: AppColor.textColor),
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(3, 3),
                                blurRadius: 10,
                                color: AppColor.appbarColor,
                                spreadRadius: 0)
                          ]),
                      child: ListTile(
                        isThreeLine: true,
                        leading: Image.network(iconUrl),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                      '${day['date']}',
                                      style: text(24, AppColor.headingColor)),
                            Text(
                                      '${day['day']['avgtemp_c']}°C',
                                      style: text(24, AppColor.headingColor)),
                          ],
                        ),
                                  subtitle:Text(
                                  '${day['day']['condition']['text']}',
                                  style: text(20, AppColor.headingColor)),
                        trailing:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                      'Max: ${day['day']['maxtemp_c']}°C',
                                      style: text(16, AppColor.headingColor)),
                            Text(
                                      'Min: ${day['day']['mintemp_c']}°C',
                                      style: text(16, AppColor.headingColor)),
                          ],
                        ) ,          

                      ),
                    );
                  }),
                ),
        ));
  }
}
