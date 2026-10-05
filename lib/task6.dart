import 'package:flutter/material.dart';

void main() => runApp(const SlidersApp());

class SlidersApp extends StatelessWidget {
  const SlidersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 4 - Task 6',
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const SlidersScreen(),
    );
  }
}

class SlidersScreen extends StatefulWidget {
  const SlidersScreen({super.key});

  @override
  State<SlidersScreen> createState() => _SlidersScreenState();
}

class _SlidersScreenState extends State<SlidersScreen> {
  double _volume = 50;

  DateTime? _selectedDate;

  IconData get _volumeIcon {
    if (_volume == 0) return Icons.volume_off;
    if (_volume < 50) return Icons.volume_down;
    return Icons.volume_up;
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final String dateText = _selectedDate == null
        ? 'No date selected'
        : MaterialLocalizations.of(context).formatMediumDate(_selectedDate!);

    return Scaffold(
      appBar: AppBar(title: const Text('Sliders & Pickers')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Volume',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(_volumeIcon, size: 32),
                Expanded(
                  child: Slider(
                    value: _volume,
                    min: 0,
                    max: 100,
                    divisions: 100,
                    label: '${_volume.round()}%',
                    onChanged: (value) {
                      setState(() => _volume = value);
                    },
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: Text(
                    '${_volume.round()}%',
                    textAlign: TextAlign.end,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            const Text(
              'Date',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _pickDate,
              icon: const Icon(Icons.calendar_today),
              label: const Text('Pick a date'),
            ),
            const SizedBox(height: 16),
            Text(
              'Selected: $dateText',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
