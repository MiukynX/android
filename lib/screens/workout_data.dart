import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

List<Map<String, String>> myWorkouts = [];

Future<void> loadMyWorkouts() async {
  final prefs = await SharedPreferences.getInstance();

  final savedData = prefs.getString('myWorkouts');

  if (savedData == null) {
    myWorkouts = [];
    return;
  }

  final List<dynamic> decodedData = jsonDecode(savedData);

  myWorkouts = decodedData.map<Map<String, String>>((item) {
    return Map<String, String>.from(item);
  }).toList();
}

Future<void> saveMyWorkouts() async {
  final prefs = await SharedPreferences.getInstance();

  final data = jsonEncode(myWorkouts);

  await prefs.setString('myWorkouts', data);
}