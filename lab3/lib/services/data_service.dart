import 'dart:convert';
import 'package:flutter/services.dart';

class DataService {
  static Future<Map<String, dynamic>> loadJson(String assetPath) async {
    final raw = await rootBundle.loadString(assetPath);
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> loadNews() => loadJson('assets/data/news.json');
  static Future<Map<String, dynamic>> loadPublishers() => loadJson('assets/data/news_details.json');
}
