import 'package:flutter/material.dart';
import 'screens/conversion_screen.dart';
import 'screens/history_screen.dart';

void main() {
  // Entry point of the Flutter application
  runApp(const MyApp());
}
 
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Main application widget that sets up the MaterialApp
    return MaterialApp(
      title: 'Converter',
      theme: ThemeData(
        // Setting up the app's color scheme with blue as the primary color
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true, // Enabling Material 3 design
      ),
      home: const MainAppScreen(), // Setting the home screen
      debugShowCheckedModeBanner: false, // Disabling debug banner
    );
  }
}

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  _MainAppScreenState createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  // List to store conversion history entries
  final List<String> _conversionHistory = [];
  // Index to track the currently selected tab
  int _currentIndex = 0;

  // Method to add a new conversion to the history
  void _addToHistory(String conversion) {
    setState(() {
      // Insert new conversions at the beginning of the list
      _conversionHistory.insert(0, conversion);
    });
  }

  @override
  Widget build(BuildContext context) {
    // List of screens corresponding to bottom navigation items
    final List<Widget> _screens = [
      // Conversion screen with callback to add to history
      ConversionScreen(onAddToHistory: _addToHistory),
      // History screen that displays all past conversions
      HistoryScreen(history: _conversionHistory),
    ];

    return Scaffold(
      // Display the current screen based on selected index
      body: _screens[_currentIndex],
      // Bottom navigation bar for switching between screens
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            // Update current index when tab is tapped
            _currentIndex = index;
          });
        },
        items: const [
          // Converter tab with home icon
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Converter',
          ),
          // History tab with history icon
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
      ),
    );
  }
}