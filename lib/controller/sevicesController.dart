// ignore_for_file: file_names

import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class ServiceController extends GetxController{
  final String apiKey = '29f1c8b605804f4f8eb60737242609';
  final String forcastBaseURl = 'http://api.weatherapi.com/v1/forecast.json';
  final String searchBaseURl = 'http://api.weatherapi.com/v1/search.json';

  Future<Map<String, dynamic>> fetchCurrentWeather(String city) async {
    final url = "$forcastBaseURl?key=$apiKey&q=$city&days=1&aqi=no&alerts=no";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Faild to load Weather');
    }
  }

  Future<Map<String, dynamic>> fetch7dayWeather(String city) async {
    final url = "$forcastBaseURl?key=$apiKey&q=$city&days=7&aqi=no&alerts=no";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Faild to load 7 Day Weather');
    }
  }

  Future<List<dynamic>?> fetchCitySuggestion(String query) async {
    final url = "$searchBaseURl?key=$apiKey&q=$query";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }
}