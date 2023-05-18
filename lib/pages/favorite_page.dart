import 'package:flutter/material.dart';
import 'package:flutter_music_player/model/color_provider.dart';
import 'package:flutter_music_player/pages/play_list_tab_page.dart';
import 'package:provider/provider.dart';
import 'favorite_music.dart';

class FavoritePage extends StatefulWidget {
  FavoritePage({Key key}) : super(key: key);

  _FavoritePageState createState() => _FavoritePageState();
}

const types = ['单曲', '歌单'];

class _FavoritePageState extends State<FavoritePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController tabController; //tab控制器

  @override
  bool get wantKeepAlive => false;

  @override
  void initState() {
    super.initState();
    //初始化controller并添加监听
    tabController = TabController(length: types.length, vsync: this);
  }

  Widget mWidget;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    ColorStyleProvider colorStyleProvider =
        Provider.of<ColorStyleProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0x07000000),
        elevation: 0,
        title: TabBar(
          controller: tabController, //控制器
          indicatorColor: colorStyleProvider.getIndicatorColor(),
          labelColor: colorStyleProvider.getCurrentColor(),
          unselectedLabelColor: Colors.white54,
          labelStyle: TextStyle(fontWeight: FontWeight.w600), //选中的样式
          unselectedLabelStyle: TextStyle(fontSize: 14), //未选中的样式
          isScrollable: true, //是否可滑动
          //tab标签
          tabs: types
              .map((name) => Tab(
                    text: name,
                  ))
              .toList(),
          //点击事件
          onTap: (int i) {
            tabController.animateTo(i);
          },
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          FavoriteMusic(),
          PlayListTabPage(
              type: PlayListTabPage.TYPE_DB,
              heroTag: 'from_fav',
              error: '您还没有收藏歌单\n可在歌单页右上角进行收藏。')
        ],
      ),
    );
  }
}
