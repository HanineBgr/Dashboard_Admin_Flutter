import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/News.dart';

class NewsService {
  static const String baseUrl =
      'https://recycleconnect.onrender.com/api/news'; // Replace with your actual API base URL

  // Scrape and save news
  static Future<void> scrapeAndSaveNews() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/scrape-news'));

      if (response.statusCode == 200) {
        print('News scraped and saved successfully');
      } else {
        throw Exception('Failed to scrape and save news');
      }
    } catch (error) {
      print('Error scraping and saving news: $error');
      throw error;
    }
  }

  // Get all news
  static Future<List<News>> getAllNews() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl'));

      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);

        if (data['success'] == true && data['news'] is List) {
          List<News> news = (data['news'] as List)
              .map((news) => News.fromJson(news))
              .toList();
          return news;
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception(
            'Failed to load news. Server response: ${response.body}');
      }
    } catch (error) {
      print('Error getting all news: $error');
      throw error;
    }
  }

  //delete news by id
  static Future<void> deleteNews(String newsId) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/delete/$newsId'));

      if (response.statusCode == 200) {
        print('News deleted successfully');
      } else {
        throw Exception('Failed to delete news');
      }
    } catch (error) {
      print('Error deleting news: $error');
      // Handle error as needed
    }
  }
}
