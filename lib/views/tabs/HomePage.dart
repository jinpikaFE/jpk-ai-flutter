import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'SettingPage.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/';
  static const String title = 'Home';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _imgUrl = "https://pic1.zhimg.com/80/v2-a2d483115c577b2da3c09073417467ce_720w.webp?source=1940ef5c";

  void _handleTap() {
    setState(() {
      _imgUrl =
          "https://picx.zhimg.com/80/v2-37502d49be26930525f3105af3e875c4_720w.webp?source=1940ef5c";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: _imgUrl,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            ElevatedButton(
              onPressed: () {
                // _handleTap();
                Navigator.pushNamed(
                  context,
                    SettingPage.routeName
                );
              },
              child: Text("切换图片"),
            ),
          ],
        ),
      ),
    );
  }
}
