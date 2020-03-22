import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:wanandroidflutter/page/args/route_web_page_data.dart';
import 'package:wanandroidflutter/util/tool_utils.dart';

///网页详情
///2020年03月22日08:15:28
///xfhy

class WebViewPage extends StatefulWidget {
  @override
  State createState() {
    return _WebViewPageState();
  }
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  Widget build(BuildContext context) {
    RouteWebPageData pageData =
        ModalRoute.of(context).settings.arguments as RouteWebPageData;
    return new WebviewScaffold(
      url: pageData.url,
      appBar: new AppBar(
        title: Text(ToolUtils.signToStr(pageData.title)),
      ),
      withZoom: true,
      withLocalStorage: true,
      hidden: true,
    );
  }
}