import 'package:flutter/material.dart';

class NewsDetailScreen extends StatelessWidget {
  final String title;
  final String newsPhoto;
  final String description;
  final String source;

  NewsDetailScreen({
    required this.title,
    required this.newsPhoto,
    required this.description,
    required this.source,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Detail'),
      ),
      body: Card(
        child: Column(
          children: [
            Image.network(newsPhoto),
            ListTile(
              title: Text(title),
              subtitle: Text(description),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Source: $source'),
            ),
          ],
        ),
      ),
    );
  }
}
