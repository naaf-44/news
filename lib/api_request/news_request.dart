import 'dart:convert';

import 'package:news/api_request/api_request.dart';
import 'package:news/costants/api_urls.dart';
import 'package:news/model_class/news_list_model.dart';
import 'package:news/utils/string_utils.dart';

class NewsRequest {
  static getNewsList() async {
    String date = StringUtils.urlDateFormat(DateTime.now().subtract(const Duration(days: 1)));
    var response = await ApiRequest.getRequest("${ApiUrls.baseUrl}${ApiUrls.query.replaceAll("{date}", date)}${ApiUrls.apiKey}");
    var responseBody = jsonDecode(response.body);
    NewsListModel newsListModel = NewsListModel.fromJson(responseBody);
    return newsListModel;
  }
}
