import 'package:flutter/material.dart';

void main() => runApp(const FeedbackApp());

class FeedbackApp extends StatelessWidget {
  const FeedbackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 4 - Task 4',
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const FeedbackScreen(),
    );
  }
}

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  bool _isLoading = false;
  bool _isSaved = false;

  // Exercise 4.1: show spinner for 3 seconds, then finish
  Future<void> _startOperation() async {
    setState(() => _isLoading = true);

    // Simulates an asynchronous task (network call, file save, etc.)
    await Future.delayed(const Duration(seconds: 3));

    // If the user left the screen during the delay, do nothing
    if (!mounted) return;

    setState(() {
      _isLoading = false;
      _isSaved = true;
    });

    _showDoneSnackBar();
  }

  // Exercise 4.2: SnackBar with an "Undo" action
  void _showDoneSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Operation completed'),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() => _isSaved = false);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Action undone')),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Indicators & Feedback')),
      body: Center(
        child: _isLoading
            // Centered spinner while "working"
            ? const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Working...'),
                ],
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _isSaved ? Icons.check_circle : Icons.circle_outlined,
                    size: 64,
                    color: _isSaved ? Colors.green : Colors.grey,
                  ),
                  const SizedBox(height: 12),
                  Text(_isSaved ? 'Saved' : 'Not saved yet'),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _startOperation,
                    child: const Text('Start Operation'),
                  ),
                ],
              ),
      ),
    );
  }
}