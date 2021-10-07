import 'package:flutter/material.dart';
import 'package:news_feed/data/category_info.dart';
import 'package:news_feed/data/search_type.dart';
import 'package:news_feed/models/model/news_model.dart';
import 'package:news_feed/repository/news_repository.dart';

class HeadLineViewModel extends ChangeNotifier {
  // DI対応のため削除
  //final NewsRepository _repository = NewsRepository();
  final NewsRepository _repository;
  HeadLineViewModel({repository}) : _repository = repository;

  SearchType _searchType = SearchType.CATEGORY;
  bool _isLoading = false;

  SearchType get searchType => _searchType;

  bool get isLoading => _isLoading;

  List<Article> _articles = [];
  List<Article> get articles => _articles;

  Future<void> getHeadLines({required SearchType searchType}) async{
    _searchType = searchType;
    _isLoading = true;
    notifyListeners();

    _articles = await _repository.getNews(searchType: SearchType.HEAD_LINE);
    //print("searchType: $_searchType articles:${_articles[0].title}");

    _isLoading = false;
    notifyListeners();
  }

}
