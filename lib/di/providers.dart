import 'package:flutter/material.dart';
import 'package:news_feed/models/db/dao.dart';
import 'package:news_feed/models/db/database.dart';
import 'package:news_feed/repository/news_repository.dart';
import 'package:news_feed/viewmodels/head_line_viewmodel.dart';
import 'package:news_feed/viewmodels/news_list_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

// ...はseparated operator。
List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...viewModels
];

List<SingleChildWidget> independentModels = [
  Provider<MyDatabase>(
    create: (_) => MyDatabase(),
    dispose: (_, db) => db.close(),
  ),
];

List<SingleChildWidget> dependentModels = [
  ProxyProvider<MyDatabase, NewsDao>(
    update: (_, db, dao) => NewsDao(db),
  ),
  ChangeNotifierProvider<NewsRepository>(
    create: (context) => NewsRepository(
      dao: context.read<NewsDao>(),
    ),
  ),
  // ProxyProvider<NewsDao, NewsRepository>(
  //   update: (_, dao, repository) => NewsRepository(dao: dao),
  // ),
];


//
List<SingleChildWidget> viewModels = [
  ChangeNotifierProxyProvider<NewsRepository, HeadLineViewModel>(
    create: (context) => HeadLineViewModel(
      repository: Provider.of<NewsRepository>(context, listen: false),
    ),
    update: (context, repository, viewModel) =>
        // updateメソッドは必ずcreateされてから呼ばれるから、viewModel!でOK。
        // ..はcascade notation。1つのオブジェクトに複数操作を行う際に利用
        // updateメソッドはviewModelを返さないと行けない。でもonRepositoryUpdatedメソッドは返り値がないからNULLになってしまう。
        // cascade notationは戻り値を無視する。そのやった結果のviewModelを返す って動きになる。
        // だから.onRepositoryUpdatedで実行すると死ぬけど、..で呼び出すと動く。
        // https://news.dartlang.org/2012/02/method-cascades-in-dart-posted-by-gilad.html
        viewModel!..onRepositoryUpdated(repository),
  ),
  ChangeNotifierProxyProvider<NewsRepository, NewsListViewModel>(
      create: (context) => NewsListViewModel(
            repository: Provider.of<NewsRepository>(context, listen: false),
          ),
      update: (context, repository, viewModel) =>
          viewModel!..onRepositoryUpdated(repository)),
];
