// import 'package:flutter/material.dart';
// import '../models/belt.dart';

// class MassProvider extends ChangeNotifier {
//   final List<Belt> _belts = [];

//   List<Belt> get belts => _belts;

//   void addBelt(Belt belt) {
//     _belts.add(belt);
//     notifyListeners(); // Notify listeners about the change
//   }

//   void removeBelt(String pitch) {
//     _belts.removeWhere((belt) => belt.pitch == pitch);
//     notifyListeners(); // Notify listeners about the change
//   }

//   Belt? getBelt(String pitch) {
//     return _belts.firstWhere(
//       (belt) => belt.pitch == pitch,
//       orElse: () => Belt(pitch: '', mass: 0.0),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import '../models/belt.dart';

class MassProvider extends ChangeNotifier {
  final List<Belt> _belts = [];

  List<Belt> get belts => _belts;

  Future<void> loadBelts() async {
    // Load the JSON file
    final String response = await rootBundle.loadString('assets/mass.json');
    final List<dynamic> data = jsonDecode(response);

    // Extract belts from the JSON data
    _belts.clear();
    for (var item in data) {
      String pitch = item['pitch'];
      Map<String, dynamic> massMap = item['mass'];
      for (var entry in massMap.entries) {
        String material = entry.key;
        double mass = entry.value;
        _belts.add(Belt(pitch: pitch, material: material, mass: mass));
      }
    }
    notifyListeners(); // Notify listeners about the change
  }

  void addBelt(Belt belt) {
    _belts.add(belt);
    notifyListeners(); // Notify listeners about the change
  }

  void removeBelt(String pitch) {
    _belts.removeWhere((belt) => belt.pitch == pitch);
    notifyListeners(); // Notify listeners about the change
  }

  Belt? getBelt(String pitch, String material) {
    return _belts.firstWhere(
      (belt) => belt.pitch == pitch && belt.material == material,
      orElse: () => Belt(pitch: '', material: '', mass: 0.0),
    );
  }
}



// import 'package:flutter/material.dart';
// import '../models/belt.dart';

// class MassProvider with ChangeNotifier {
//   List<Belt> _belts = [];

//   List<Belt> get belts => _belts;

//   void addBelt(Belt belt) {
//     _belts.add(belt);
//     notifyListeners();
//   }

//   void removeBelt(Belt belt) {
//     _belts.remove(belt);
//     notifyListeners();
//   }

//   void updateBelt(Belt oldBelt, Belt newBelt) {
//     final index = _belts.indexOf(oldBelt);
//     if (index != -1) {
//       _belts[index] = newBelt;
//       notifyListeners();
//     }
//   }
// }
