import 'package:newsapp/models/catagories_news_models.dart';
import 'package:newsapp/repositry/news_repositry.dart';

import '../models/news_channels_headlines_models.dart';

class NewsViewsModels {
  final _rep = NewsRepositry();
  Future<NewsChannelsHeadlinesModels> fetchNewsChanellsHeadlinesApi() async {
    final response = await _rep.fetchNewsChanellsHeadlinesApi();
    return response;
  }

  Future<CategoriesNewsModels> fetchCatagoriesNewsApi(String catagory) async {
    final response = await _rep.fetchCatagoriesNewsApi(catagory);
    return response;
  }
}
