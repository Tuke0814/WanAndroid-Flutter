import 'package:flutter/material.dart';

///搜索结果列表
///2020年03月29日15:31:15
///xfhy

class SearchResultWidget extends StatefulWidget {
  final String inputKey;

  SearchResultWidget(this.inputKey);

  @override
  State createState() {
    return _SearchResultWidgetState();
  }
}

class _SearchResultWidgetState extends State<SearchResultWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
      ),
    );
  }
}