import 'package:flutter/material.dart';

void main() => runApp(const GalleryApp());

class GalleryApp extends StatelessWidget {
  const GalleryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 4 - Task 8',
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const GalleryScreen(),
    );
  }
}

class PhotoTile extends StatelessWidget {
  final int index;
  final BoxFit fit;

  const PhotoTile({super.key, required this.index, this.fit = BoxFit.cover});

  static String urlFor(int index) {
    return 'https://picsum.photos/id/${index + 10}/600/600';
  }

  @override
  Widget build(BuildContext context) {
    final MaterialColor color =
        Colors.primaries[(index * 3) % Colors.primaries.length];

    return Image.network(
      urlFor(index),
      fit: fit,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Container(
          color: Colors.grey[200],
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: color.shade400,
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.photo, size: 48, color: Colors.white),
              const SizedBox(height: 8),
              Text(
                'Photo ${index + 1}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  static const int _photoCount = 12;

  void _openPreview(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PreviewScreen(index: index)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Gallery')),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        padding: const EdgeInsets.all(12),
        children: List.generate(_photoCount, (index) {
          return GestureDetector(
            onTap: () => _openPreview(context, index),
            child: Hero(
              tag: 'photo_$index',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: PhotoTile(index: index),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class PreviewScreen extends StatelessWidget {
  final int index;

  const PreviewScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text('Photo ${index + 1}'),
      ),
      body: Center(
        child: Hero(
          tag: 'photo_$index',
          child: InteractiveViewer(
            child: PhotoTile(index: index, fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
