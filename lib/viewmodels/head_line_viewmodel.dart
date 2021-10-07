import 'package:flutter/material.dart';
import 'package:news_feed/data/category_info.dart';
import 'package:news_feed/data/load_status.dart';
import 'package:news_feed/data/search_type.dart';
import 'package:news_feed/models/model/news_model.dart';
import 'package:news_feed/repository/news_repository.dart';

class HeadLineViewModel extends ChangeNotifier {
  // DI対応のため削除
  //final NewsRepository _repository = NewsRepository();
  final NewsRepository _repository;
  HeadLineViewModel({repository}) : _repository = repository;

  SearchType _searchType = SearchType.CATEGORY;
  SearchType get searchType => _searchType;

  List<Article> _articles = [];
  List<Article> get articles => _articles;

  LoadStatus _loadStatus = LoadStatus.DONE;
  LoadStatus get loadStatus => _loadStatus;

  Future<void> getHeadLines({required SearchType searchType}) async{
    _searchType = searchType;
    await _repository.getNews(searchType: SearchType.HEAD_LINE);
    //print("searchType: $_searchType articles:${_articles[0].title}");
  }

  onRepositoryUpdated(NewsRepository repository) {
    _articles = repository.articles;
    _loadStatus = repository.loadStatus;
    notifyListeners();
  }

}
