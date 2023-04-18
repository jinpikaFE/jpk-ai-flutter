import 'dart:convert';

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
  TextEditingController _unameController = TextEditingController();
  GlobalKey _formKey = GlobalKey<FormState>();
  String _imgUrl =
      "https://pic1.zhimg.com/80/v2-a2d483115c577b2da3c09073417467ce_720w.webp?source=1940ef5c";

  void _handleTap() {
    setState(() {
      _imgUrl =
          "https://picx.zhimg.com/80/v2-37502d49be26930525f3105af3e875c4_720w.webp?source=1940ef5c";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                TextFormField(
                  autofocus: true,
                  maxLines: 3,
                  controller: _unameController,
                  decoration: const InputDecoration(
                    labelText: "描述文案",
                    hintText: "最好输入英文关键词",
                    // icon: Icon(Icons.person),
                  ),
                  // 校验用户名
                  validator: (v) {
                    return v!.trim().isNotEmpty ? null : "用户名不能为空";
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 28.0,right:30,left: 30),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text("创建"),
                          ),
                          onPressed: () {
                            // 通过_formKey.currentState 获取FormState后，
                            // 调用validate()方法校验用户名密码是否合法，校验
                            // 通过后再提交数据。
                            if ((_formKey.currentState as FormState)
                                .validate()) {
                              //验证通过提交数据
                              var formData = {
                                "username": _unameController.text.trim(),
                                // 还可以继续添加其他表单字段的值
                              };
                              print(formData);
                              var jsonData = json.encode(formData);
                              print(jsonData);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          CachedNetworkImage(
            imageUrl:
            "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAFYAAABWCAMAAABiiJHFAAAAYFBMVEX///9dx/dfyvgxufUFWp0wuPYAWJwnY6GA0fjV7/v5/P1Iw/b8/v3Z8PtZx/ZJw/jr9/1uzfji8/vm7PMuse4AUpqJ1flbxvoPtPQKSpIlrO3r+/8ATpjr8PQ1aaUfWZu1csoXAAABnklEQVRYhe3WUXOCMBAEYDlIbIkEUGm0te3//5cNIJccTmdqXGf6kH33m509BTebnJycnJzU1G8vMn0HUHd9YYs47StEtYRX654oZm3bANSxq2ANagHBghaY1MAazAIFCRaywNKVwF2vKoGvVYgNQL8Ct1JR1xIsaIHJCiyqK6P0nK6E+205yQIXWFCCLSC6Wthz4PkLEOpahRwWuACFrrinC1yt+4gELmAFGq5V3yRZjb6vexOl9TF/Z2uhxm+YfSv/1Bi6o2xnYzNaYG8eUL0r31thAakWtLtHHd0AGFDXyeUP/7aAS1CDyws07erfYoq6uNy1OZUuZl2aOrv8JGxOqiyFeue1YteErl5VJY+btCu7fC3l1TGOF0guGzJ1jVyTvoBQyxBnH1uAwwssLqirUJUiAOrLSlQdt4cNom4n1UoPB4AaXDWpVaU1qK9iVeuri0in5hyHYWRxO1zVy6C5L+ZuXj2fh6Gag7vb+3leAOt+6AgF3u2zWrkXkPukvoe1C9r3ZgeQ6/vKoNyvrcw3xr0J4k2Rk5OT89/yA2tiG1OxNHpCAAAAAElFTkSuQmCC",
            progressIndicatorBuilder:
                (context, url, downloadProgress) =>
                CircularProgressIndicator(
                    value: downloadProgress.progress),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ],
      ),
    );
  }
}
