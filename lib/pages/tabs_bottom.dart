import 'package:flutter/material.dart';
import 'package:flutter_music_player/model/color_provider.dart';
import 'package:flutter_music_player/widget/text_icon.dart';
import 'package:provider/provider.dart';

class BottomTabs extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> tapCallback;
  final bool showFloatPlayer;

  BottomTabs(this.currentIndex, this.tapCallback, this.showFloatPlayer);

  @override
  Widget build(BuildContext context) {
    return _buildBottomNavigationBar(context);
  }

  _buildBottomAppBar(BuildContext context) {
    return BottomAppBar(
      color: Color(0xFF282626),
      shape: CircularNotchedRectangle(),
      notchMargin: 4.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          TextIcon(
            icon: Icons.whatshot,
            title: '发现',
            selected: currentIndex == 0,
            onPressed: () => tapCallback(0),
          ),
          TextIcon(
            icon: Icons.library_music,
            title: '歌单',
            selected: currentIndex == 1,
            onPressed: () => tapCallback(1),
          ),
          SizedBox(width: 70.0),
          TextIcon(
            icon: Icons.movie,
            title: 'MV',
            selected: currentIndex == 2,
            onPressed: () => tapCallback(2),
          ),
          TextIcon(
            icon: Icons.favorite,
            title: '收藏',
            selected: currentIndex == 3,
            onPressed: () => tapCallback(3),
          ),
        ],
      ),
    );
  }

  _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      backgroundColor: Color(0xFF282626),
      onTap: tapCallback,
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.white60,
      selectedItemColor:
          Provider.of<ColorStyleProvider>(context).getCurrentColor(),
      // fixedColor: Provider.of<ColorStyleProvider>(context).getCurrentColor(),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.whatshot),
          title: Text('发现'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.library_music),
          title: Text('歌单'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.movie),
          title: Text('MV'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          title: Text('收藏'),
        ),
      ],
    );
  }
}
