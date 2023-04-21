import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/config/ProdConfig.dart';
import 'package:flutter_project/utils/DioManager.dart';
import 'package:flutter_project/views/IndexPage.dart';
import 'package:flutter_project/views/tabs/SettingPage.dart';

import 'config/Config.dart';
import 'config/DevConfig.dart';

import 'package:flutter_ume/flutter_ume.dart'; // UME 框架
import 'package:flutter_ume_kit_ui/flutter_ume_kit_ui.dart'; // UI 插件包
import 'package:flutter_ume_kit_perf/flutter_ume_kit_perf.dart'; // 性能插件包
import 'package:flutter_ume_kit_show_code/flutter_ume_kit_show_code.dart'; // 代码查看插件包
import 'package:flutter_ume_kit_device/flutter_ume_kit_device.dart'; // 设备信息插件包
import 'package:flutter_ume_kit_console/flutter_ume_kit_console.dart'; // debugPrint 插件包
import 'package:flutter_ume_kit_dio/flutter_ume_kit_dio.dart'; // Dio 网络请求调试工具

void main() {
  const env = String.fromEnvironment('ENV', defaultValue: 'prod');
  switch (env) {
    case 'dev':
    // 加载开发环境配置文件
      final apiBaseUrl = DevConfig.apiBaseUrl;
      Config.apiBaseUrl =apiBaseUrl;
      break;
    case 'prod':
    // 加载生产环境配置文件
      final apiBaseUrl = ProdConfig.apiBaseUrl;
      Config.apiBaseUrl =apiBaseUrl;
      break;
  }
  // 对dio封装实例化
  var dioManager= DioManager();
  if (kDebugMode) {
    PluginManager.instance                                 // 注册插件
      ..register(WidgetInfoInspector())
      ..register(WidgetDetailInspector())
      ..register(ColorSucker())
      ..register(AlignRuler())
      ..register(ColorPicker())                            // 新插件
      ..register(TouchIndicator())                         // 新插件
      ..register(Performance())
      ..register(ShowCode())
      ..register(MemoryInfoPage())
      ..register(CpuInfoPage())
      ..register(DeviceInfoPanel())
      ..register(Console())
      ..register(DioInspector(dio: dioManager.dio));                  // 传入你的 Dio 实例
    // flutter_ume 0.3.0 版本之后
    runApp(UMEWidget(child: MyApp(), enable: true)); // 初始化
  } else {
    runApp(MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      textStyle: TextStyle(fontSize: 20),
      primary: Colors.black54,
      onPrimary: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );

    final ThemeData theme = ThemeData(
      brightness: Brightness.dark, // 设置亮度为暗色调
      primaryColor: Colors.black, // 设置主要颜色为黑色
      accentColor: Colors.white, // 设置强调颜色为白色
      fontFamily: 'Roboto', // 设置字体为 Roboto
      textTheme: const TextTheme(
        headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        bodyText2: TextStyle(fontSize: 18.0),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.black, // 设置按钮颜色为黑色
        textTheme: ButtonTextTheme.primary,
      ),
      elevatedButtonTheme:  ElevatedButtonThemeData(
        style: raisedButtonStyle
      ),
    );
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: IndexPage.routeName,
      theme: theme,
      routes: {
        IndexPage.routeName: (context) => IndexPage(),
        SettingPage.routeName: (context) => SettingPage(),
      },
    );
  }
}
