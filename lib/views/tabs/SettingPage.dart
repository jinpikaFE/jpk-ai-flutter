import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../IndexPage.dart';

class SettingPage extends StatelessWidget {
  static const routeName = '/setting';
  static const String title = 'Setting';

  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigator.pop(context);
            IndexPage.scaffoldKey.currentState?.openDrawer();
          },
          child: Text("Go back"),
        ),
      ),
    );
  }
}