import 'package:flutter/material.dart';
import 'package:flutter_project/views/IndexPage.dart';
import 'package:flutter_project/views/tabs/SettingPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: IndexPage.routeName,
      routes: {
        IndexPage.routeName: (context) => IndexPage(),
        SettingPage.routeName: (context) => SettingPage(),
      },
    );
  }
}
