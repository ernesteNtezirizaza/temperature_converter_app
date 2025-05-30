import 'package:flutter/material.dart';
import '../utils/conversion_utils.dart';

// ConversionScreen is a StatefulWidget that handles temperature conversion
class ConversionScreen extends StatefulWidget {
  // Callback function to add conversion results to history
  final Function(String) onAddToHistory;
  const ConversionScreen({super.key, required this.onAddToHistory});

  @override
  _ConversionScreenState createState() => _ConversionScreenState();
}

class _ConversionScreenState extends State<ConversionScreen> {
  // Default conversion type
  String _selectedConversion = 'Fahrenheit to Celsius';
  // Controller for temperature input field
  final TextEditingController _temperatureController = TextEditingController();
  // Stores the conversion result
  String _result = '';
  // Stores error message for input validation
  String? _errorText;

  // Method to perform temperature conversion
  void _convertTemperature() {
    // Clear previous error
    setState(() {
      _errorText = null;
    });

    // Return if input is empty
    if (_temperatureController.text.isEmpty) {
      setState(() {
        _result = '';
      });
      return;
    }

    final input = _temperatureController.text;
    // Try to parse input as double
    final double? inputTemp = double.tryParse(input);

    // Validate input
    if (inputTemp == null) {
      setState(() {
        _errorText = 'Please enter a valid number';
        _result = '';
      });
      return;
    }

    double convertedTemp;
    String conversionText;

    // Perform conversion based on selected type
    if (_selectedConversion == 'Fahrenheit to Celsius') {
      convertedTemp = ConversionUtils.fahrenheitToCelsius(inputTemp);
      conversionText = 'F to C: ${ConversionUtils.formatTemperature(inputTemp)} => ${ConversionUtils.formatTemperature(convertedTemp)}';
    } else {
      convertedTemp = ConversionUtils.celsiusToFahrenheit(inputTemp);
      conversionText = 'C to F: ${ConversionUtils.formatTemperature(inputTemp)} => ${ConversionUtils.formatTemperature(convertedTemp)}';
    }

    // Update result and add to history
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
      // Using LayoutBuilder for responsive design
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight - 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Conversion:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  // Radio buttons for conversion type selection
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
                  // Responsive layout - switches between row and column based on screen width
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
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Helper method to build input widgets with responsive layout
  List<Widget> _buildInputWidgets(bool isWide) {
    return [
      // Temperature input field
      SizedBox(
        width: isWide ? 200 : double.infinity,
        child: TextField(
          controller: _temperatureController,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            labelText: 'Temperature',
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            errorText: _errorText,
          ),
          onChanged: (value) {
            if (value.isEmpty) {
              setState(() {
                _result = '';
                _errorText = null;
              });
            }
          },
        ),
      ),
      // Spacer - behaves differently in wide vs narrow layout
      SizedBox(height: isWide ? 0 : 8, width: isWide ? 8 : 0),
      // Convert button
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
      // Spacer - behaves differently in wide vs narrow layout
      SizedBox(height: isWide ? 0 : 8, width: isWide ? 8 : 0),
      // Result display container
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
    // Clean up controller when widget is disposed
    _temperatureController.dispose();
    super.dispose();
  }
}