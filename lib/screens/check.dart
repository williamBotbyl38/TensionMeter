import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class BeltMass {
  String pitch;
  Map<String, double> mass;

  BeltMass({required this.pitch, required this.mass});

  factory BeltMass.fromJson(Map<String, dynamic> json) {
    return BeltMass(
      pitch: json['pitch'],
      // Convert each value in the 'mass' map to double explicitly
      mass: (json['mass'] as Map<String, dynamic>).map<String, double>(
        (key, value) =>
            MapEntry(key, (value is int) ? value.toDouble() : value as double),
      ),
    );
  }
}

class CheckScreen extends StatefulWidget {
  @override
  _CheckScreenState createState() => _CheckScreenState();
}

class _CheckScreenState extends State<CheckScreen> {
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _spanController = TextEditingController();
  final TextEditingController _tensionController = TextEditingController();
  final TextEditingController _frequencyController = TextEditingController();

  String? _selectedPitchType;
  String? _selectedPitchSize;
  String? _selectedMaterial;

  String _widthUnit = 'mm';
  String _spanUnit = 'm';
  String _tensionUnit = 'N';

  List<BeltMass> _beltMasses = [];

  final Map<String, List<String>> _pitchSeries = {
    "AT": [
      "AT3",
      "AT5",
      "AT5-DL",
      "ATL5",
      "ATN12.7",
      "ATN10",
      "AT10",
      "AT10-DL",
      "AT10 MOV",
      "ATL10",
      "BAT10",
      "BATK10",
      "ATP10",
      "ATP10-DL",
      "SFAT10",
      "ATS15",
      "ATS15-DL",
      "BAT15",
      "BATK15",
      "ATP15",
      "ATP15-DL",
      "SFAT15",
      "AT15 MOV",
      "ATN20",
      "AT20",
      "AT20-DL",
      "ATL20",
      "SFAT20"
    ],
    "T": [
      "T2",
      "T2.5",
      "T5",
      "T5-DL",
      "T10",
      "T10-DL",
      "T20",
      "T20-DL",
    ],
    "English": ["MXL", "T1/5\"", "T3/8\"", "T1/2\"", "T1/2\"-DL", "T7/8\""],
    "HTD": [
      "HTD3M-HP",
      "HTD5M-HP",
      "HTD5M-HF",
      "HTD8M-HP",
      "HTD8M-HF",
      "HTD14M-HP"
    ],
    "Flat Belts": ["F1", "F2", "F2.2", "F3", "F4", "F5", "F6", "F8"]
  };

  final List<String> _materials = ['Steel/Stainless/HiFlex', 'kevlar'];
  final List<String> _lengthUnits = ['mm', 'cm', 'm', 'inch'];
  final List<String> _widthUnits = ['mm', 'cm', 'm', 'inch'];
  final List<String> _tensionUnits = ['N', 'lbf'];

  @override
  void initState() {
    super.initState();
    _loadBeltMassData();
  }

  Future<void> _loadBeltMassData() async {
    final String response = await rootBundle.loadString('assets/mass.json');
    final data = json.decode(response) as List;
    setState(() {
      _beltMasses = data.map((item) => BeltMass.fromJson(item)).toList();
    });
  }

  List<String> _getAvailableMaterialsForSelectedPitch(String selectedPitch) {
    BeltMass? beltMass = _beltMasses.firstWhere(
        (element) => element.pitch == selectedPitch,
        orElse: () => BeltMass(pitch: '', mass: {}));

    return beltMass.mass.entries
        .where((entry) => entry.value != -1)
        .map((entry) => entry.key)
        .toList();
  }

  void _clearInputs() {
    _widthController.clear();
    _spanController.clear();
    _tensionController.clear();
    _frequencyController.clear();

    setState(() {
      _selectedPitchType = null;
      _selectedPitchSize = null;
      _selectedMaterial = null;
    });
  }

  // void _calculateTension() {
  //   if (_selectedPitchSize == null) {
  //     _showErrorDialog("Please select a valid belt pitch size.");
  //     return;
  //   }
  //   if (_selectedMaterial == null) {
  //     _showErrorDialog("Please select a valid material.");
  //     return;
  //   }
  //   if (_widthController.text.isEmpty ||
  //       _spanController.text.isEmpty ||
  //       _frequencyController.text.isEmpty) {
  //     _showErrorDialog("Please fill in all fields.");
  //     return;
  //   }

  //   double width = double.tryParse(_widthController.text) ?? 0;
  //   double span = double.tryParse(_spanController.text) ?? 0;
  //   double frequency = double.tryParse(_frequencyController.text) ?? 0;

  //   if (_widthUnit == 'mm') {
  //     width = width / 10;
  //   } else if (_widthUnit == 'inches') {
  //     width = width * 2.54;
  //   } else if (_widthUnit == 'meters') {
  //     width = width * 100;
  //   }

  //   if (_spanUnit == 'm') {
  //     span = span;
  //   } else if (_spanUnit == 'mm') {
  //     span = span / 1000;
  //   } else if (_spanUnit == 'cm') {
  //     span = span / 100;
  //   }

  //   if (width <= 0 || span <= 0 || frequency <= 0) {
  //     _showErrorDialog("Width, span, and frequency must be positive numbers.");
  //     return;
  //   }

  //   BeltMass? beltMass = _beltMasses.firstWhere(
  //       (element) => element.pitch == _selectedPitchSize,
  //       orElse: () => BeltMass(pitch: '', mass: {}));

  //   if (beltMass.mass[_selectedMaterial] == null) {
  //     _showErrorDialog(
  //         "No data available for the selected pitch size and material.");
  //     return;
  //   }

  //   double massPerUnitLength = beltMass.mass[_selectedMaterial] ?? 0;

  //   if (massPerUnitLength <= 0) {
  //     _showErrorDialog("Invalid mass value for the selected material.");
  //     return;
  //   }

  //   double tension =
  //       pow(frequency, 2) * pow(span, 2) * 4 * massPerUnitLength * width;

  //   // Convert tension to appropriate units if necessary
  //   if (_tensionUnit == 'lbf') {
  //     tension /= 4.44822; // Convert Newtons to lbf (pounds-force)
  //   }

  //   _tensionController.text = tension.toStringAsFixed(2);
  // }
  void _calculateTension() {
    if (_selectedPitchSize == null) {
      _showErrorDialog("Please select a valid belt pitch size.");
      return;
    }
    if (_selectedMaterial == null) {
      _showErrorDialog("Please select a valid material.");
      return;
    }
    if (_widthController.text.isEmpty ||
        _spanController.text.isEmpty ||
        _frequencyController.text.isEmpty) {
      _showErrorDialog("Please fill in all fields.");
      return;
    }

    // Parse the inputs from text fields
    double width = double.tryParse(_widthController.text) ?? 0;
    double span = double.tryParse(_spanController.text) ?? 0;
    double frequency = double.tryParse(_frequencyController.text) ?? 0;

    // // Width unit conversion
    // if (_widthUnit == 'mm') {
    //   width = width / 1000; // Convert mm to meters
    // } else if (_widthUnit == 'cm') {
    //   width = width / 100; // Convert cm to meters
    // } else if (_widthUnit == 'inch') {
    //   width = width * 0.0254; // Convert inches to meters
    // } else if (_widthUnit == 'm') {
    //   // width is already in meters, no conversion needed
    // }

    // // Span unit conversion
    // if (_spanUnit == 'm') {
    //   span = span; // Already in meters, no conversion needed
    // } else if (_spanUnit == 'mm') {
    //   span = span / 1000; // Convert mm to meters
    // } else if (_spanUnit == 'cm') {
    //   span = span / 100; // Convert cm to meters
    // }
    // Width unit conversion to centimeters

    if (_widthUnit == 'mm') {
      width = width / 10;
    } else if (_widthUnit == 'cm') {
      width = width;
    } else if (_widthUnit == 'inch') {
      width = width * 2.54;
    } else if (_widthUnit == 'm') {
      width = width * 100;
    }

    if (_spanUnit == 'm') {
      span = span;
    } else if (_spanUnit == 'mm') {
      span = span / 1000;
    } else if (_spanUnit == 'cm') {
      span = span / 100;
    } else if (_spanUnit == 'inch') {
      span = span * 0.0254;
    }

    // Validate positive values for the calculations
    if (width <= 0 || span <= 0 || frequency <= 0) {
      _showErrorDialog("Width, span, and frequency must be positive numbers.");
      return;
    }

    // Get mass per unit length for the selected material
    BeltMass? beltMass = _beltMasses.firstWhere(
        (element) => element.pitch == _selectedPitchSize,
        orElse: () => BeltMass(pitch: '', mass: {}));

    if (beltMass.mass[_selectedMaterial] == null) {
      _showErrorDialog(
          "No data available for the selected pitch size and material.");
      return;
    }

    double massPerUnitLength = beltMass.mass[_selectedMaterial] ?? 0;

    if (massPerUnitLength <= 0) {
      _showErrorDialog("Invalid mass value for the selected material.");
      return;
    }

    // Calculate tension using the mass, width, span, and frequency
    double tension =
        pow(frequency, 2) * pow(span, 2) * 4 * massPerUnitLength * width;

    // Convert tension to the selected unit (lbf or N)
    if (_tensionUnit == 'lbf') {
      tension /= 4.44822; // Convert Newtons to lbf (pounds-force)
    }

    // Display the calculated tension in the tension input field
    _tensionController.text = tension.toStringAsFixed(2);
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Input Error"),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF579039),
        title: const Text(
          "Check Tension",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/BRECOflexBackground.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.7),
                  BlendMode.dstATop,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<String>(
                  value: _selectedPitchType,
                  hint: Text(languageProvider.translate('select_belt_series')),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedPitchType = newValue;
                      _selectedPitchSize = null;
                      _tensionController.clear(); // Clear the input field
                    });
                  },
                  items: _pitchSeries.keys
                      .map<DropdownMenuItem<String>>((String pitchType) {
                    return DropdownMenuItem<String>(
                      value: pitchType,
                      child: Text(pitchType),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                if (_selectedPitchType != null)
                  DropdownButtonFormField<String>(
                    value: _selectedPitchSize,
                    hint: Text(languageProvider.translate('select_pitch')),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedPitchSize = newValue;
                      });
                    },
                    items: _pitchSeries[_selectedPitchType]!
                        .map<DropdownMenuItem<String>>((String pitchSize) {
                      return DropdownMenuItem<String>(
                        value: pitchSize,
                        child: Text(pitchSize),
                      );
                    }).toList(),
                  ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedMaterial,
                  hint: Text(languageProvider.translate('select_material')),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedMaterial = newValue;
                      _tensionController.clear(); // Clear the input field
                    });
                  },
                  items: _selectedPitchSize != null
                      ? _getAvailableMaterialsForSelectedPitch(
                              _selectedPitchSize!)
                          .map<DropdownMenuItem<String>>((String material) {
                          return DropdownMenuItem<String>(
                            value: material,
                            child: Text(material),
                          );
                        }).toList()
                      : [],
                ),
                const SizedBox(height: 16),
                // Row(
                //   children: [
                //     Container(
                //       width: 250,
                //       // Expanded(
                //       child: TextFormField(
                //         controller: _widthController,
                //         decoration: InputDecoration(
                //           labelText: languageProvider.translate('belt_width'),
                //           border: const OutlineInputBorder(),
                //         ),
                //         keyboardType: TextInputType.number,
                //       ),
                //     ),
                //     // ),
                //     const SizedBox(width: 16),
                //     DropdownButton<String>(
                //       value: _widthUnit,
                //       items: _lengthUnits
                //           .map<DropdownMenuItem<String>>((String unit) {
                //         return DropdownMenuItem<String>(
                //           value: unit,
                //           child: Text(unit),
                //         );
                //       }).toList(),
                //       onChanged: (String? newValue) {
                //         setState(() {
                //           _widthUnit = newValue!;
                //         });
                //       },
                //     ),
                //   ],
                // ),
                Row(
                  children: [
                    Container(
                      width: 250,
                      child: TextFormField(
                        controller: _widthController,
                        decoration: InputDecoration(
                          labelText: languageProvider.translate('belt_width'),
                          border: const OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 16),
                    DropdownButton<String>(
                      value:
                          _widthUnit, // This should be a state variable for selected width unit
                      items: _widthUnits
                          .map<DropdownMenuItem<String>>((String unit) {
                        return DropdownMenuItem<String>(
                          value: unit,
                          child: Text(unit),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _widthUnit = newValue!;
                          _tensionController.clear(); // Clear the input field
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Container(
                      width: 250,
                      // Expanded(
                      child: TextFormField(
                        controller: _spanController,
                        decoration: InputDecoration(
                          labelText:
                              languageProvider.translate('free_span_length'),
                          border: const OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    // ),
                    const SizedBox(width: 16),
                    DropdownButton<String>(
                      value: _spanUnit,
                      items: _lengthUnits
                          .map<DropdownMenuItem<String>>((String unit) {
                        return DropdownMenuItem<String>(
                          value: unit,
                          child: Text(unit),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _spanUnit = newValue!;
                          _tensionController.clear(); // Clear the input field
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      width: 250,
                      child: TextFormField(
                        controller: _frequencyController,
                        decoration: InputDecoration(
                          labelText: languageProvider.translate('frequency'),
                          border: const OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Hz',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _calculateTension,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 20,
                          ),
                          backgroundColor: const Color(0xFF579039),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          languageProvider.translate('check_tension'),
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: _clearInputs,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 20,
                          ),
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          languageProvider.translate('clear'),
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                  width: 240,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 250,
                      child: TextFormField(
                        controller: _tensionController,
                        decoration: InputDecoration(
                          labelText: languageProvider.translate('tension'),
                          border: const OutlineInputBorder(),
                        ),
                        readOnly: true,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 16),
                    DropdownButton<String>(
                      value: _tensionUnit,
                      items: _tensionUnits
                          .map<DropdownMenuItem<String>>((String unit) {
                        return DropdownMenuItem<String>(
                          value: unit,
                          child: Text(unit),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _tensionUnit = newValue!;
                          _tensionController.clear(); // Clear the input field
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
