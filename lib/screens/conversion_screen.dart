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
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight - 16, // subtract padding
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Conversion:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  // Radio buttons
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Radio<String>(
                            value: 'Fahrenheit to Celsius',
                            groupValue: _selectedConversion,
                            onChanged: (value) {
                              setState(() {
                                _selectedConversion = value!;
                              });
                            },
                          ),
                          const Text('Fahrenheit to Celsius'),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'Celsius to Fahrenheit',
                            groupValue: _selectedConversion,
                            onChanged: (value) {
                              setState(() {
                                _selectedConversion = value!;
                              });
                            },
                          ),
                          const Text('Celsius to Fahrenheit'),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Responsive input area
                  if (constraints.maxWidth > 600) 
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _buildInputWidgets(true),
                    )
                  else 
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _buildInputWidgets(false),
                    ),
                  // Spacer to push content up
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildInputWidgets(bool isWide) {
    return [
      SizedBox(
        width: isWide ? 200 : double.infinity,
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
      SizedBox(height: isWide ? 0 : 8, width: isWide ? 8 : 0),
      SizedBox(
        width: isWide ? 150 : double.infinity,
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
      SizedBox(height: isWide ? 0 : 8, width: isWide ? 8 : 0),
      Container(
        width: isWide ? 150 : double.infinity,
        height: 48,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: _result.isEmpty ? Colors.transparent : Colors.grey),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          _result.isEmpty ? '' : '$_result',
          style: const TextStyle(fontSize: 16),
        ),
      ),
    ];
  }

  @override
  void dispose() {
    _temperatureController.dispose();
    super.dispose();
  }
}