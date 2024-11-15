import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

Future<List<String>> loadBeltPitches() async {
  // Load the JSON file
  final String response = await rootBundle.loadString('assets/mass.json');
  final List<dynamic> data = jsonDecode(response);

  // Extract pitches from the JSON data
  List<String> pitches =
      data.map<String>((item) => item['pitch'] as String).toList();
  return pitches;
}
