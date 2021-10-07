import 'package:flutter/material.dart';
import 'package:news_feed/models/model/news_model.dart';
import 'package:news_feed/view/style/style.dart';

class ArticleTileDescription extends StatelessWidget {
  final Article article;
  const ArticleTileDescription({required this.article});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          article.title ?? "",
          style: textTheme.subtitle1?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          article.publishDate ?? "",
          style: textTheme.overline?.copyWith(fontStyle: FontStyle.italic),
        ),
        Text(
          article.description ?? "",
          style: textTheme.bodyText1?.copyWith(fontFamily: RegularFont),
        ),
      ],
    );
  }
}
