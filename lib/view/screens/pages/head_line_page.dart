import 'package:flutter/material.dart';
import 'package:news_feed/data/search_type.dart';
import 'package:news_feed/models/model/news_model.dart';
import 'package:news_feed/view/components/head_line_item.dart';
import 'package:news_feed/view/components/page_transformer.dart';
import 'package:news_feed/viewmodels/head_line_viewmodel.dart';
import 'package:provider/provider.dart';

import 'news_web_page_screen.dart';

class HeadLinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<HeadLineViewModel>();

    if (!viewModel.isLoading && viewModel.articles.isEmpty) {
      Future(() => viewModel.getHeadLines(searchType: SearchType.HEAD_LINE));
    }

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<HeadLineViewModel>(
            builder: (context, model, child) {
              if (model.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return PageTransformer(
                  pageViewBuilder: (context, pageVisibilityResolver) {
                    return PageView.builder(
                      itemCount: model.articles.length,
                      controller: PageController(
                        viewportFraction: 0.85,
                      ),
                      itemBuilder: (context, index) {
                        final article = model.articles[index];
                        final pageVisibility =
                            pageVisibilityResolver.resolvePageVisibility(index);
                        final visibleFraction = pageVisibility.visibleFraction;
                        return HeadLineItem(
                          article: model.articles[index],
                          pageVisibility: pageVisibility,
                          onArticleClicked: (article) =>
                              _openArticleWebPage(context, article),
                        );
                      },
                    );
                  },
                );
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: () => _onRefresh(context),
        ),
      ),
    );
  }

  _onRefresh(BuildContext context) async {
    print("HeadLinePage.onRefresh");
    final viewModel = context.read<HeadLineViewModel>();
    await viewModel.getHeadLines(searchType: SearchType.HEAD_LINE);
  }

  // WEBページ開く
  _openArticleWebPage(BuildContext context,Article article, ) {
    print("_openArticleWebPage: ${article.url}");
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NewsWebPageScreen(article: article),
      ),
    );
  }
}
