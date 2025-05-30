import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  // List to store conversion history strings
  final List<String> history;
  
  // Constructor that requires a history list
  const HistoryScreen({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with title and blue background
      appBar: AppBar(
        title: const Text(
          'Conversion History',
          style: TextStyle(color: Colors.white), // White text color
        ),
        backgroundColor: Colors.blue[800], // Dark blue background
      ),
      // Body shows either empty message or history list
      body: history.isEmpty
          ? const Center( // Show centered text if history is empty
              child: Text('No conversion history yet'),
            )
          : ListView.builder( // Show list if history has items
              itemCount: history.length, // Number of items in history
              itemBuilder: (context, index) {
                // Creates a ListTile for each history item
                return ListTile(
                  title: Text(history[index]), // Display the conversion string
                );
              },
            ),
    );
  }
}