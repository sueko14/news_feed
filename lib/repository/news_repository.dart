import 'dart:convert';
import 'package:news_feed/models/db/dao.dart';
import 'package:news_feed/util/extensions.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_feed/data/category_info.dart';
import 'package:news_feed/data/search_type.dart';
import 'package:news_feed/main.dart';
import 'package:news_feed/models/model/news_model.dart';

class NewsRepository {
  // NEWS API https://newsapi.org
  static const API_KEY = "b1bc0c65e49d45a9bb15c284e27c8bca";
  static const BASE_URL = "https://newsapi.org/v2/top-headlines?country=jp";


  //DI対応
  final NewsDao _dao;
  NewsRepository({dao}): _dao = dao;

  Future<List<Article>> getNews({
    required SearchType searchType,
    String? keyword,
    Category? category,
  }) async {
    List<Article> results = [];
    http.Response? response;

    switch (searchType) {
      case SearchType.HEAD_LINE:
        final requestUrl = Uri.parse(BASE_URL + "&apiKey=$API_KEY");
        response = await http.get(requestUrl);
        break;
      case SearchType.KEYWORD:
        final requestUrl =
            Uri.parse(BASE_URL + "&q=$keyword&pageSize=30&apiKey=$API_KEY");
        response = await http.get(requestUrl);
        break;
      case SearchType.CATEGORY:
        final requestUrl = Uri.parse(
            BASE_URL + "&category=${category?.nameEn}&apiKey=$API_KEY");
        response = await http.get(requestUrl);
        break;
    }

    if(response.statusCode == 200){
      final responseBody = response.body;
      //print("responseBody: $responseBody");
      //results = News.fromJson(jsonDecode(responseBody)).articles;
      results = await insertAndReadFromDB(jsonDecode(responseBody));
    }else{
      throw Exception("failed to load news");
    }

    return results;
  }

  Future<List<Article>>insertAndReadFromDB(responseBody) async {
    //final dao = myDatabase.newsDao; DI対応のため削除
    final articles = News.fromJson(responseBody).articles;

    // Webから取得した記事リスト（Article）をDBのテーブルクラス(ArticleRecord)に変換してDB登録・DBから取得
    final articleRecords = await _dao.insertAndReadNewsFromDB(articles.toArticleRecords(articles));

    // DBから取得したデータをモデルクラスに再変換して返す
    return articleRecords.toArticles(articleRecords);
  }
}
