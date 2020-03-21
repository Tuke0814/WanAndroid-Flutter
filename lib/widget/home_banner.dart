import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wanandroidflutter/data/data_utils.dart';
import 'package:wanandroidflutter/data/model/banner_data.dart';
import 'package:wanandroidflutter/util/log_util.dart';

///首页的banner
///2020年03月21日21:08:20
///xfhy

class HomeBanner extends StatefulWidget {
  //TODO 点击事件
  final List<BannerData> bannerList;

  HomeBanner(this.bannerList, {Key key}) : super(key: key);

  @override
  State createState() {
    return _HomeBannerState();
  }
}

class _HomeBannerState extends State<HomeBanner> {
  int _realIndex = 1;
  int virtualIndex = 0;
  PageController _pageController;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    LogUtil.d('initState');
    _pageController = PageController(initialPage: _realIndex);
    //周期性的计时
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      //计时然后滑动
      _pageController.animateToPage(_realIndex + 1,
          //线性的动画
          duration: Duration(milliseconds: 300),
          curve: Curves.linear);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 226.0,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          //一个类似ViewPager的PageView+小圆点+右上角索引
          PageView(
            controller: _pageController,
            //当从一个page滑动到另一个page的时候会回调
            onPageChanged: _onPageChanged,
            children: _buildItems(),
          ),
        ],
      ),
    );
  }

  ///当从一个page滑动到另一个page的时候会回调
  ///模拟无限滚动   d abcd a
  void _onPageChanged(int index) {
    _realIndex = index;
    int count = widget.bannerList.length;
    if (index == 0) {
      virtualIndex = count - 1;
      _pageController.jumpToPage(count);
    } else if (index == count + 1) {
      virtualIndex = 0;
      _pageController.jumpToPage(1);
    } else {
      virtualIndex = index - 1;
    }
    setState(() {});
  }

  ///构建PageView的childs
  _buildItems() {
    if (widget.bannerList.length == 0) {
      return [
        Container(
          color: Colors.red,
          width: 200,
          height: 200,
        )
      ];
    }
    List<Widget> childWidget = [];
    //头部添加一个尾部Item,模拟循环
    childWidget
        .add(_buildBannerItem(widget.bannerList[widget.bannerList.length - 1]));
    for (var bannerData in widget.bannerList) {
      childWidget.add(_buildBannerItem(bannerData));
    }
    // 尾部 添加上第一个
    childWidget.add(_buildBannerItem(widget.bannerList[0]));
    return childWidget;
  }

  ///构建某一个item
  Widget _buildBannerItem(BannerData bannerData) {
    return Center(
      child: Text(bannerData.toString()),
    );
  }
}
