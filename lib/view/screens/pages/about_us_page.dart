import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AboutUsPage extends StatefulWidget {
  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: AnimatedContainer(
            color: _selected ? Colors.black54 : Colors.black12,
            duration: Duration(milliseconds: 1000),
            width: _selected ? 300 : 50,
            height: _selected ? 200 : 25,
            //Animated Containerは小Widgetたちはアニメーションしない。
            // //だから枠のサイズに合わせて文字をなめらかに変化させるwidgetにすればよい
            // child: _selected
            //     ? Text("News Feed App", style: TextStyle(fontSize: 40.0))
            //     : Text("News Feed App", style: TextStyle(fontSize: 10.0)),
            child: AutoSizeText(
              "News Feed App",
              style: TextStyle(fontSize: 40.0),
              minFontSize: 6.0,
              maxLines: 1,
              overflow: TextOverflow.visible,
            ),
            alignment: _selected ? Alignment.center : Alignment.topCenter,
            curve: Curves.fastOutSlowIn,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.play_arrow),
          tooltip: "飛び出します",
          onPressed: () {
            setState(() {
              _selected = !_selected;
            });
          },
        ),
      ),
    );
  }
}
