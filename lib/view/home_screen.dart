import 'package:flutter/material.dart';
import 'package:news_feed/view/screens/pages/about_us_page.dart';
import 'package:news_feed/view/screens/pages/head_line_page.dart';
import 'package:news_feed/view/screens/pages/news_list_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final _pages = [
    HeadLinePage(),
    NewsListPage(),
    AboutUsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],//TODO
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: const Icon(Icons.highlight),
            label: "トップニュース",
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.list),
            label: "ニュース一覧",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: "このアプリについて",
          ),
        ],
      ), //TODO
    );
  }
}
