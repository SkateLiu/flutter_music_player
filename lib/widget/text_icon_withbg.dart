import 'package:flutter/material.dart';
import 'package:flutter_music_player/model/color_provider.dart';
import 'package:provider/provider.dart';

class TextIconWithBg extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onPressed;
  const TextIconWithBg({Key key, this.icon, this.title, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: this.onPressed,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(12.0, 16.0, 12.0, 8.0),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Provider.of<ColorStyleProvider>(context)
                      .getCurrentColor()),
              child: Icon(icon, color: Colors.white, size: 24.0),
            ),
            Text(
              title,
              style: TextStyle(fontSize: 13.0, color: Colors.white),
            ),
            SizedBox(height: 16.0),
          ],
        ));
  }
}
