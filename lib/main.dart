import 'package:flutter/material.dart';
import 'screens/conversion_screen.dart';
import 'screens/history_screen.dart';

void main() {
  runApp(const MyApp());
}
 
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Converter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MainAppScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  _MainAppScreenState createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  final List<String> _conversionHistory = [];
  int _currentIndex = 0;

  void _addToHistory(String conversion) {
    setState(() {
      _conversionHistory.insert(0, conversion);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      ConversionScreen(onAddToHistory: _addToHistory),
      HistoryScreen(history: _conversionHistory),
    ];

    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Converter',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
      ),
    );
  }
}