import 'package:flutter/material.dart';
import 'package:buttons/main.dart';
import 'package:buttons/menu_navigations/header_navigation/main_header_navigation.dart';

class MainMenuNavigations extends StatelessWidget {
  const MainMenuNavigations({super.key});

  onButtonTap(Widget page, BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Menu Navigations"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            MyMenuButton(
              title: "Header Navigation",
              actionTap: () {
                onButtonTap(const MainHeaderNavigation(), context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
