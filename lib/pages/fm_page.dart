import 'package:flutter/material.dart';
import 'package:flutter_music_player/pages/rank_song_list.dart';
import 'package:flutter_music_player/utils/navigator_util.dart';
import 'package:flutter_music_player/dao/music_163.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_music_player/model/color_provider.dart';
import 'package:provider/provider.dart';

class FMPage extends StatefulWidget {
  FMPage({Key key}) : super(key: key);

  @override
  _FMPageState createState() => _FMPageState();
}

class _FMPageState extends State<FMPage> {
  List djList = [];
  _getSongs() async {
    await MusicDao.getHotDjList().then((result) {
      // 界面未加载，返回。
      if (!mounted) return;

      setState(() {
        djList = result;
      });
    }).catchError((e) {
      print('Failed: ${e.toString()}');
    });
  }

  @override
  void initState() {
    super.initState();
    _getSongs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Text('电台列表', style: TextStyle(fontSize: 16.0)),
      ),
      body: GridView.builder(
        itemCount: this.djList == null ? 0 : this.djList.length,
        padding: EdgeInsets.all(6.0), // 四周边距，注意Card也有默认的边距
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            // 网格样式
            crossAxisCount: 2, // 列数
            mainAxisSpacing: 2.0, // 主轴的间距
            crossAxisSpacing: 2.0, // cross轴间距
            childAspectRatio: 1 // item横竖比
            ),
        itemBuilder: (context, index) => _buildItems(context, index),
      ),
    );
  }

  Widget _buildItems(BuildContext context, int index) {
    Map data = djList[index];
    return Card(
        elevation: 4.0,
        child: Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                child: Hero(
                  tag: data, // 注意页面keepAlive之后全局唯一
                  child: CachedNetworkImage(
                      imageUrl: '${data['picUrl']}?param=300y300'),
                )),
            ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(4.0),
                  bottomRight: Radius.circular(4.0)),
              child: Container(
                  width: double.infinity,
                  color: Color.fromARGB(80, 0, 0, 0),
                  padding: EdgeInsets.all(6.0),
                  child: Text(
                    data['name'],
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12.0, color: Colors.white),
                  )),
            ),
            Positioned.fill(
              left: 10.0,
              top: 10.0,
              child: Text(data['category'],
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w800,
                    color: Provider.of<ColorStyleProvider>(context)
                        .getCurrentColor(),
                  )),
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                    // 水波纹
                    splashColor: Colors.white.withOpacity(0.3),
                    highlightColor: Colors.white.withOpacity(0.1),
                    onTap: () {}),
              ),
            ),
          ],
        ));
  }
}
