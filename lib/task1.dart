import 'package:flutter/material.dart';

void main() => runApp(const SettingsApp());

/// Root app. Holds the dark-mode state so the whole theme can change.
class SettingsApp extends StatefulWidget {
  const SettingsApp({super.key});

  @override
  State<SettingsApp> createState() => _SettingsAppState();
}

class _SettingsAppState extends State<SettingsApp> {
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 4 - Task 1',
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      themeMode: _darkMode ? ThemeMode.dark : ThemeMode.light,
      home: SettingsScreen(
        darkMode: _darkMode,
        onDarkModeChanged: (value) => setState(() => _darkMode = value),
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  final bool darkMode;
  final ValueChanged<bool> onDarkModeChanged;

  const SettingsScreen({
    super.key,
    required this.darkMode,
    required this.onDarkModeChanged,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _agreedToTerms = false;

  void _onContinuePressed() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Settings saved!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Exercise 1.1: Dark Mode switch
            SwitchListTile(
              title: const Text('Dark Mode'),
              subtitle: const Text('Switch between light and dark theme'),
              secondary: Icon(
                widget.darkMode ? Icons.dark_mode : Icons.light_mode,
              ),
              value: widget.darkMode,
              onChanged: widget.onDarkModeChanged,
            ),

            // Exercise 1.1: Agree to Terms checkbox
            CheckboxListTile(
              title: const Text('Agree to Terms'),
              subtitle: const Text('You must agree to continue'),
              controlAffinity: ListTileControlAffinity.leading,
              value: _agreedToTerms,
              onChanged: (value) {
                setState(() => _agreedToTerms = value ?? false);
              },
            ),

            const SizedBox(height: 24),

            // Exercise 1.2: button enabled only when checkbox is ticked.
            // onPressed: null  ->  Flutter automatically shows it as disabled.
            ElevatedButton(
              onPressed: _agreedToTerms ? _onContinuePressed : null,
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}