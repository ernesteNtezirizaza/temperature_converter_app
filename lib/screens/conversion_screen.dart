import 'package:flutter/material.dart';
import '../utils/conversion_utils.dart';

class ConversionScreen extends StatefulWidget {
  final Function(String) onAddToHistory;
  const ConversionScreen({super.key, required this.onAddToHistory});

  @override
  _ConversionScreenState createState() => _ConversionScreenState();
}

class _ConversionScreenState extends State<ConversionScreen> {
  String _selectedConversion = 'Fahrenheit to Celsius';
  final TextEditingController _temperatureController = TextEditingController();
  String _result = '';

  void _convertTemperature() {
    if (_temperatureController.text.isEmpty) {
      setState(() {
        _result = '';
      });
      return;
    }

    final double inputTemp = double.tryParse(_temperatureController.text) ?? 0.0;
    double convertedTemp;
    String conversionText;

    if (_selectedConversion == 'Fahrenheit to Celsius') {
      convertedTemp = ConversionUtils.fahrenheitToCelsius(inputTemp);
      conversionText = 'F to C: ${ConversionUtils.formatTemperature(inputTemp)} => ${ConversionUtils.formatTemperature(convertedTemp)}';
    } else {
      convertedTemp = ConversionUtils.celsiusToFahrenheit(inputTemp);
      conversionText = 'C to F: ${ConversionUtils.formatTemperature(inputTemp)} => ${ConversionUtils.formatTemperature(convertedTemp)}';
    }

    setState(() {
      _result = ConversionUtils.formatTemperature(convertedTemp);
    });

    widget.onAddToHistory(conversionText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Converter',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Conversion:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Inlined radio buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 24,
                  child: Radio<String>(
                    value: 'Fahrenheit to Celsius',
                    groupValue: _selectedConversion,
                    onChanged: (value) {
                      setState(() {
                        _selectedConversion = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 4),
                const Text(
                  'Fahrenheit to Celsius',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(width: 16),
                SizedBox(
                  width: 24,
                  child: Radio<String>(
                    value: 'Celsius to Fahrenheit',
                    groupValue: _selectedConversion,
                    onChanged: (value) {
                      setState(() {
                        _selectedConversion = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 4),
                const Text(
                  'Celsius to Fahrenheit',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 120,
                  child: TextField(
                    controller: _temperatureController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Temperature',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    ),
                    onChanged: (value) {
                      if (value.isEmpty) {
                        setState(() {
                          _result = '';
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[800],
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 48),
                    ),
                    onPressed: _convertTemperature,
                    child: const Text('Convert'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 48,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: _result.isEmpty ? Colors.transparent : Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      _result.isEmpty ? '' : '${_result}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _temperatureController.dispose();
    super.dispose();
  }
}