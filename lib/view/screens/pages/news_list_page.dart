import 'package:flutter/material.dart';
import 'package:news_feed/data/category_info.dart';
import 'package:news_feed/data/search_type.dart';
import 'package:news_feed/view/components/article_tile.dart';
import 'package:news_feed/view/components/category_chips.dart';
import 'package:news_feed/view/components/search_bar.dart';
import 'package:news_feed/view/screens/pages/news_web_page_screen.dart';
import 'package:news_feed/viewmodels/news_list_viewmodel.dart';
import 'package:provider/provider.dart';

class NewsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<NewsListViewModel>();
    if (viewModel.isLoading && viewModel.articles.isEmpty) {
      Future(() => viewModel.getNews(
          searchType: SearchType.CATEGORY, category: Category.categories[0]));
    }

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          tooltip: "更新",
          onPressed: () => onRefresh(context),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              SearchBar(
                onSearch: (keyword) => getKeywordNews(context, keyword),
              ),
              CategoryChips(
                onCategorySelected: (category) =>
                    getCategoryNews(context, category),
              ),
              //TODO 記事表示
              Expanded(
                child: Consumer<NewsListViewModel>(
                  builder: (context, model, child) {
                    return model.isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemCount: model.articles.length,
                            itemBuilder: (context, int position) => ArticleTile(
                              article: model.articles[position],
                              onArticleClicked: (article) =>
                                  _openArticleWebPage(article, context),
                            ),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //TODO 記事更新処理
  Future<void> onRefresh(BuildContext context) async {
    final viewModel = context.read<NewsListViewModel>();
    await viewModel.getNews(
      searchType: viewModel.searchType,
      keyword: viewModel.keyword,
      category: viewModel.category,
    );
    print("NewsListPage.onRefresh");
  }

  // キーワード記事取得処理
  Future<void> getKeywordNews(BuildContext context, keyword) async {
    final viewModel = context.read<NewsListViewModel>();
    await viewModel.getNews(
      searchType: SearchType.KEYWORD,
      keyword: keyword,
      category: Category.categories[0],
    );
    print("NewsListPage.getKeywordNews keyword: $keyword");
  }

  // カテゴリー絞り込み
  Future<void> getCategoryNews(BuildContext context, Category category) async {
    final viewModel = context.read<NewsListViewModel>();
    await viewModel.getNews(
      searchType: SearchType.CATEGORY,
      category: category,
    );
    print("NewsListPage.getCategoryNews category: ${category.nameJp}");
  }

  // WEBページ開く
  _openArticleWebPage(article, BuildContext context) {
    print("_openArticleWebPage: ${article.url}");
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NewsWebPageScreen(article: article),
      ),
    );
  }
}
