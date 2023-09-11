import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/models/catagories_news_models.dart';
import 'package:newsapp/models/news_channels_headlines_models.dart';

class NewsRepositry {
  Future<NewsChannelsHeadlinesModels> fetchNewsChanellsHeadlinesApi() async {
    try {
      String url =
          "https://newsapi.org/v2/top-headlines?country=us&apiKey=ae739577b56c46baa6f90975a6ae465a";
      final response = await http.get(Uri.parse(url));
      if (kDebugMode) {
        print(response.body);
      }
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        return NewsChannelsHeadlinesModels.fromJson(body);
      }
      throw Exception("error");
    } catch (e) {
      throw e.toString();
    }
  }

  Future<CategoriesNewsModels> fetchCatagoriesNewsApi(String catagory) async {
    try {
      String url =
          // ignore: unnecessary_brace_in_string_interps
          "https://newsapi.org/v2/everything?q=${catagory}&apiKey=ae739577b56c46baa6f90975a6ae465a";
      final response = await http.get(Uri.parse(url));
      if (kDebugMode) {
        print(response.body);
      }
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        return CategoriesNewsModels.fromJson(body);
      }
      throw Exception("error");
    } catch (e) {
      throw e.toString();
    }
  }
}
