import 'package:flutter/material.dart';

void main() => runApp(const ListApp());

class ListApp extends StatelessWidget {
  const ListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 4 - Task 7',
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const ListScreen(),
    );
  }
}

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  static List<String> _generateItems() {
    return List.generate(20, (index) => 'Item ${index + 1}');
  }

  final List<String> _items = _generateItems();

  void _removeItem(int index) {
    final String removed = _items[index];
    setState(() => _items.removeAt(index));

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('$removed dismissed'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              final int position = index > _items.length ? _items.length : index;
              setState(() => _items.insert(position, removed));
            },
          ),
        ),
      );
  }

  void _restoreAll() {
    setState(() {
      _items
        ..clear()
        ..addAll(_generateItems());
    });
  }

  Widget _swipeBackground(Alignment alignment) {
    return Container(
      color: Colors.red,
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: const Icon(Icons.delete, color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scrollable List (${_items.length})')),
      body: _items.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.inbox, size: 64, color: Colors.grey),
                  const SizedBox(height: 12),
                  const Text('All items dismissed'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _restoreAll,
                    child: const Text('Restore list'),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final String item = _items[index];
                return Dismissible(
                  key: ValueKey(item),
                  background: _swipeBackground(Alignment.centerLeft),
                  secondaryBackground: _swipeBackground(Alignment.centerRight),
                  onDismissed: (direction) => _removeItem(index),
                  child: ListTile(
                    leading: CircleAvatar(child: Text('${index + 1}')),
                    title: Text(item),
                    subtitle: const Text('Swipe left or right to dismiss'),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                );
              },
            ),
    );
  }
}
