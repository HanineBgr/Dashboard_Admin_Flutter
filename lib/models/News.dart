import 'package:admin/models/Event.dart';

class News {
  String id;
  String title;
  String newsPhoto;
  String description;
  String url;
  String source;

  News({
    required this.id,
    required this.title,
    required this.newsPhoto,
    required this.description,
    required this.url,
    required this.source,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['_id'] ?? '', // Use an empty string if '_id' is null
      title: json['title'] ?? '', // Use an empty string if 'title' is null
      newsPhoto:
          json['newsPhoto'] ?? '', // Use an empty string if 'newsPhoto' is null
      description: json['description'] ??
          '', // Use an empty string if 'description' is null
      url: json['url'] ?? '', // Use an empty string if 'url' is null
      source: json['source'] ?? '', // Use an empty string if 'source' is null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'newsPhoto': newsPhoto,
      'description': description,
      'url': url,
      'source': source,
      // Add other fields as needed
    };
  }
}
