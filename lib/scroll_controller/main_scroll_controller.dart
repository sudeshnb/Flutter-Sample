import 'package:flutter/material.dart';
import 'package:buttons/main.dart';
import 'package:buttons/scroll_controller/scroll_limit_reached.dart';
import 'package:buttons/scroll_controller/scroll_movement.dart';
import 'package:buttons/scroll_controller/scroll_status.dart';
import 'package:buttons/scroll_controller/scroll_sync/scroll_sync.dart';

class MainScrollController extends StatelessWidget {
  const MainScrollController({super.key});

  onButtonTap(Widget page, BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ScrollController / ScrollNotifiation"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            MyMenuButton(
              title: "Scroll Limit Reached",
              actionTap: () {
                onButtonTap(const ScrollLimitReached(), context);
              },
            ),
            MyMenuButton(
              title: "Scroll Movement",
              actionTap: () {
                onButtonTap(const ScrollMovement(), context);
              },
            ),
            MyMenuButton(
              title: "Scroll Status",
              actionTap: () {
                onButtonTap(const ScrollStatus(), context);
              },
            ),
            MyMenuButton(
              title: "Scroll Sync",
              actionTap: () {
                onButtonTap(const ScrollSync(), context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
