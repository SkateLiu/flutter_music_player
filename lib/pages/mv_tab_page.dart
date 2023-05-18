import 'package:flutter/material.dart';
import 'package:flutter_music_player/dao/music_163.dart';
import 'package:flutter_music_player/widget/mv_item.dart';
import 'package:flutter_music_player/model/color_provider.dart';
import 'package:provider/provider.dart';

class MVTabPage extends StatefulWidget {
  final String url;
  ScrollController _controller = new ScrollController();
  MVTabPage({Key key, this.url}) : super(key: key);

  @override
  _MVTabPageState createState() => _MVTabPageState();
}

class _MVTabPageState extends State<MVTabPage> {
  List _mvList = [];

  _getMVList() async {
    await MusicDao.getMVList(widget.url).then((result) {
      // 界面未加载，返回。
      if (!mounted) return;

      setState(() {
        _mvList = result;
      });
    }).catchError((e) {
      print('Failed: ${e.toString()}');
    });
  }

  @override
  void initState() {
    super.initState();

    widget._controller.addListener(() {
      if (widget._controller.position.pixels ==
          widget._controller.position.maxScrollExtent) {
        _loadMoreData();
      }
    });
    _getMVList();
  }

  // _onRefresh 下拉刷新回调
  Future<Null> _onRefresh() async {
    await _getMVList();
    return Future.value(null);
  }

  //上拉加载函数
  Future<Null> _loadMoreData() async {
    await _getMVList();
    return Future.value(null);
  }

  @override
  Widget build(BuildContext context) {
    return _mvList.length == 0
        ? Center(child: CircularProgressIndicator())
        : RefreshIndicator(
            onRefresh: _onRefresh, //下拉刷新回调
            displacement: 40, //指示器显示时距顶部位置
            color: Provider.of<ColorStyleProvider>(context)
                .getCurrentColor(), //指示器颜色，默认ThemeData.accentColor
            backgroundColor: null, //指示器背景颜色，默认ThemeData.canvasColor
            notificationPredicate:
                defaultScrollNotificationPredicate, //是否应处理滚动通知的检查（是否通知下拉刷新动作）
            child: ListView.builder(
              cacheExtent: 10.0, // 缓存区域，滚出多远后回收item，调用其dispose
              itemCount: this._mvList.length,
              //itemExtent: 70.0, // 设定item的高度，这样可以减少高度计算。
              itemBuilder: (context, index) => MVItem(this._mvList[index]),
              controller: widget._controller, //上啦加载更多
              /* separatorBuilder: (context, index) => Divider(
              color: Color(0x0f000000),
              height: 12.0, // 间隔的高度
              thickness: 8.0, // 绘制的线的厚度
            ), */
            ),
          );
  }
}
