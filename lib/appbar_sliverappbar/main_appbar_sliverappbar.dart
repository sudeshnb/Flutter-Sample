import 'package:flutter/material.dart';
import 'package:buttons/appbar_sliverappbar/sample1.dart';
import 'package:buttons/appbar_sliverappbar/sample2.dart';

import '../main.dart';
import 'sample3.dart';

class MainAppBarSliverAppBar extends StatelessWidget {
  const MainAppBarSliverAppBar({super.key});

  onButtonTap(Widget page, BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AppBar & SliverAppBar"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            MyMenuButton(
              title: "Sample 1 - AppBar",
              actionTap: () {
                onButtonTap(const Sample1(), context);
              },
            ),
            MyMenuButton(
              title: "Sample 2 - SliverAppBar",
              actionTap: () {
                onButtonTap(const Sample2(), context);
              },
            ),
            MyMenuButton(
              title: "Sample 3 - SliverAppBar with Strech",
              actionTap: () {
                onButtonTap(const Sample3(), context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
