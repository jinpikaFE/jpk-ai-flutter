import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../api/Ai.dart';
import '../../dto/AiResult.dart';
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
  String _imgUrl = "";

  void _changeUrl(url) {
    setState(() {
      _imgUrl = url;
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
                  maxLines: 5,
                  controller: _unameController,
                  decoration: const InputDecoration(
                    labelText: "描述文案",
                    hintText: "最好输入英文关键词",
                    // icon: Icon(Icons.person),
                  ),
                  validator: (v) {
                    return v!.trim().isNotEmpty ? null : "请输入描述文案";
                  },
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 28.0, right: 30, left: 30),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text("创建"),
                          ),
                          onPressed: () async {
                            // 通过_formKey.currentState 获取FormState后，
                            // 调用validate()方法校验用户名密码是否合法，校验
                            // 通过后再提交数据。
                            if ((_formKey.currentState as FormState)
                                .validate()) {
                              //验证通过提交数据
                              var formData = {
                                "text_prompts": [
                                  {
                                    "text": _unameController.text.trim(),
                                  },
                                ],
                                "cfg_scale": 7,
                                "clip_guidance_preset": "FAST_BLUE",
                                "height": 512,
                                "width": 512,
                                "samples": 1,
                                "steps": 30
                              };
                              dynamic res = await AiApi.textToImage(formData);
                              AiResult result = AiResult.fromJson(res);
                              String? resBase =
                                  result?.data?.artifacts?.elementAt(0)?.base64;
                              if (resBase != null) {
                                setState(() {
                                  _imgUrl = resBase;
                                });
                              } else {
                                final snackBar = SnackBar(
                                  content: Text(
                                      "${result?.data?.name}:${result?.data?.message}"),
                                  duration: Duration(seconds: 3),
                                  action: SnackBarAction(
                                    label: '撤销',
                                    onPressed: () {
                                      // 在这里添加撤销操作
                                    },
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
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
          Padding(
              padding: EdgeInsets.only(top: 28.0),
              child: Row(
                children: [
                  const Text("结果："),
                ],
              )),
          _imgUrl.isNotEmpty
              ? Image.memory(base64Decode(
                      _imgUrl) // 通过 base64Decode 解码后传递给 Image.memory 的 bytes 参数
                  )
              : SizedBox()
        ],
      ),
    );
  }
}
