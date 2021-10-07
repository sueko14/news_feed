import 'package:flutter/material.dart';
import 'package:news_feed/data/category_info.dart';
import 'package:news_feed/data/load_status.dart';
import 'package:news_feed/data/search_type.dart';
import 'package:news_feed/models/model/news_model.dart';
import 'package:news_feed/repository/news_repository.dart';

class NewsListViewModel extends ChangeNotifier {
  //final NewsRepository _repository = NewsRepository();
  final NewsRepository _repository;

  NewsListViewModel({repository}) : _repository = repository;

  SearchType _searchType = SearchType.CATEGORY;
  Category _category = Category.categories[0];
  String _keyword = "";

  Category get category => _category;

  SearchType get searchType => _searchType;

  String get keyword => _keyword;

  List<Article> _articles = [];

  List<Article> get articles => _articles;

  LoadStatus _loadStatus = LoadStatus.DONE;

  LoadStatus get loadStatus => _loadStatus;

  Future<void> getNews(
      {required SearchType searchType,
      String? keyword,
      required Category category}) async {
    _searchType = searchType;
    _keyword = keyword ?? ""; //三項演算子で、nullの場合""を代入
    _category = category;

    await _repository.getNews(
      searchType: _searchType,
      keyword: _keyword,
      category: _category,
    );
    //print("searchType: $_searchType articles:${_articles[0].title}");
  }

  onRepositoryUpdated(NewsRepository repository) {
    _articles = repository.articles;
    _loadStatus = repository.loadStatus;
    notifyListeners();
  }
}
