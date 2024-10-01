// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/controller/sevicesController.dart';
import 'package:weatherapp/utils/constant.dart';
import 'package:weatherapp/utils/widgets/weatherDetail.dart';
import 'package:weatherapp/view/7dayforecast.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  final ServiceController serviceController = Get.put(ServiceController());
  String _city = "Karachi";
  Map<String, dynamic>? currentWeather;
  String date = DateFormat('yMMMMd').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    try {
      final weatherdata = await serviceController.fetchCurrentWeather(_city);
      setState(() {
        currentWeather = weatherdata;
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
          'WeatherApp',
          style: text(32, AppColor.appMainColor),
        ),
      ),
      body: SafeArea(
          child: currentWeather == null
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
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 10),
                        child: InkWell(
                            onTap: _showCitySelection,
                            child: Text(
                              "${_city} ->",
                              style: text(36, AppColor.headingColor),
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.all(20),
                        width: Get.width - 50,
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
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  '${currentWeather!['current']['temp_c'].round()}°C',
                                  style: text(40, AppColor.headingColor)),
                              Text(
                                  '${currentWeather!['current']['condition']['text']}, $_city',
                                  style: text(24, AppColor.headingColor)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      'Max Temp :${currentWeather!['forecast']['forecastday'][0]['day']['maxtemp_c'].round()}°C',
                                      style: text(16, AppColor.headingColor)),
                                  Text(
                                      'Min Temp :${currentWeather!['forecast']['forecastday'][0]['day']['mintemp_c'].round()}°C',
                                      style: text(16, AppColor.headingColor)),
                                ],
                              ),
                            ],
                          ),
                          subtitle: Text(date,
                              style: text(20, AppColor.headingColor)),
                          leading: Image.network(
                            'http:${currentWeather!['current']['condition']['icon']}',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.height / 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          weatherDetail(
                              'SunRise',
                              Icons.wb_sunny,
                              currentWeather!['forecast']['forecastday'][0]
                                  ['astro']['sunrise'],
                              Colors.yellow),
                          weatherDetail(
                              'SunSet',
                              Icons.brightness_2,
                              currentWeather!['forecast']['forecastday'][0]
                                  ['astro']['sunset'],
                              Colors.white),
                          weatherDetail(
                              'Humidity',
                              Icons.opacity,
                              currentWeather!['current']['humidity'],
                              Colors.blue),
                          weatherDetail(
                              'Wind',
                              Icons.wind_power,
                              currentWeather!['current']['wind_kph'],
                              Colors.grey),
                        ],
                      ),
                      SizedBox(
                        height: Get.height / 10,
                      ),
                      Center(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shadowColor: AppColor.headingColor,
                                elevation: 10,
                                minimumSize:
                                    Size(Get.width - 50, Get.height / 15),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor: AppColor.appbarColor),
                            onPressed: () {
                              Get.to(ForecastScreen(city: _city));
                            },
                            child: Text(
                              '7 days Forecast',
                              style: text(24, AppColor.headingColor),
                            )),
                      )
                    ],
                  ),
                )),
    );
  }

  void _showCitySelection() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Enter The City',
              style: text(20, AppColor.textColor),
            ),
            content: TypeAheadField(
              suggestionsCallback: (pattern) async {
                return await serviceController.fetchCitySuggestion(pattern) ??
                    [];
              },
              textFieldConfiguration: TextFieldConfiguration(
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Enter city name',
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
                controller:
                    TextEditingController(), // If you want to provide a controller
              ),
              itemBuilder: (context, suggestion) {
                return ListTile(
                  title: Text(suggestion['name']),
                );
              },
              onSuggestionSelected: (city) {
                setState(() {
                  _city = city['name'];
                });
              },
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    'Cancel',
                    style: text(20, AppColor.textColor),
                  )),
              TextButton(
                  onPressed: () {
                    Get.back();
                    _fetchWeather();
                  },
                  child: Text(
                    'Submit',
                    style: text(20, AppColor.textColor),
                  )),
            ],
          );
        });
  }
}
