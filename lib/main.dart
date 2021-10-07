import 'package:flutter/material.dart';
import 'package:news_feed/di/providers.dart';
import 'package:news_feed/models/db/database.dart';
import 'package:news_feed/view/home_screen.dart';
import 'package:news_feed/view/style/style.dart';
import 'package:news_feed/viewmodels/head_line_viewmodel.dart';
import 'package:news_feed/viewmodels/news_list_viewmodel.dart';
import 'package:provider/provider.dart';

late MyDatabase myDatabase;

void main() {
  myDatabase = MyDatabase();
  runApp(
    //Providerは登録する順番が大事。viewModelは並列ではなく、上から順にツリーに置かれる
    MultiProvider(
      // globalProviders(ProxyProvider対応)のため削除
      // providers: [
      //   ChangeNotifierProvider(create: (_) => NewsListViewModel()),
      //   ChangeNotifierProvider(create: (_) => HeadLineViewModel()),
      // ],
      providers: globalProviders,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "NewsFeed",
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: BoldFont,
      ),
      home: HomeScreen(),
    );
  }
}
