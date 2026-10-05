import 'package:flutter/material.dart';

void main() => runApp(const DialogsApp());

class DialogsApp extends StatelessWidget {
  const DialogsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 4 - Task 5',
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const DialogsScreen(),
    );
  }
}

class DialogsScreen extends StatefulWidget {
  const DialogsScreen({super.key});

  @override
  State<DialogsScreen> createState() => _DialogsScreenState();
}

class _DialogsScreenState extends State<DialogsScreen> {
  bool _itemExists = true;

  // Exercise 5.1: AlertDialog with Cancel / Delete
  Future<void> _confirmDelete() async {
    // showDialog returns a Future that completes when the dialog is closed.
    // The value passed to Navigator.pop becomes the result.
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete item?'),
        content: const Text(
          'This will permanently delete "Holiday Photo.jpg". '
          'This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (!mounted) return;

    if (confirmed == true) {
      setState(() => _itemExists = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Item deleted')),
      );
    }
  }

  // Exercise 5.2: bottom sheet with share options (ListTile items)
  void _showShareSheet() {
    showModalBottomSheet(
      context: context,
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Share via',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              _shareOption(sheetContext, Icons.link, 'Copy link'),
              _shareOption(sheetContext, Icons.email_outlined, 'Email'),
              _shareOption(sheetContext, Icons.message_outlined, 'Messages'),
              _shareOption(sheetContext, Icons.more_horiz, 'More options'),
            ],
          ),
        );
      },
    );
  }

  Widget _shareOption(BuildContext sheetContext, IconData icon, String label) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: () {
        Navigator.pop(sheetContext); // close the sheet first
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Shared via $label')),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dialogs & Modals')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _itemExists
            ? Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const ListTile(
                        leading: Icon(Icons.image, size: 40),
                        title: Text('Holiday Photo.jpg'),
                        subtitle: Text('2.4 MB'),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton.icon(
                            onPressed: _showShareSheet,
                            icon: const Icon(Icons.share),
                            label: const Text('Share'),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton.icon(
                            onPressed: _confirmDelete,
                            icon: const Icon(Icons.delete),
                            label: const Text('Delete'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            : Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.inbox, size: 64, color: Colors.grey),
                    const SizedBox(height: 12),
                    const Text('No items left'),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () => setState(() => _itemExists = true),
                      child: const Text('Restore item'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}