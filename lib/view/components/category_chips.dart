import 'package:flutter/material.dart';
import 'package:news_feed/data/category_info.dart';

class CategoryChips extends StatefulWidget {
  final ValueChanged onCategorySelected;
  CategoryChips({required this.onCategorySelected});

  @override
  _CategoryChipsState createState() => _CategoryChipsState();
}

class _CategoryChipsState extends State<CategoryChips> {
  var value = 0;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
        children: List<Widget>.generate(Category.categories.length, (int index) {
      return ChoiceChip(
        label: Text(Category.categories[index].nameJp),
        selected: value == index,
        onSelected: (bool isSelected) {
          setState(() {
            value = isSelected ? index : 0;
            widget.onCategorySelected(Category.categories[index]);
          });
        },
      );
    }).toList());
  }
}
