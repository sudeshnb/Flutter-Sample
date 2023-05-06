import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons/animations/main_animations.dart';
import 'package:buttons/app_clone/main_apps_clone.dart';
import 'package:buttons/appbar_sliverappbar/main_appbar_sliverappbar.dart';
import 'package:buttons/collapsing_toolbar/main_collapsing_toolbar.dart';
import 'package:buttons/communication_widgets/main_communication_widgets.dart';
import 'package:buttons/fetch_data/main_fetch_data.dart';
import 'package:buttons/hero_animations/main_hero_animations.dart';
import 'package:buttons/menu_navigations/main_menu_navigations.dart';
import 'package:buttons/persistent_tabbar/main_persistent_tabbar.dart';
import 'package:buttons/scroll_controller/main_scroll_controller.dart';
import 'package:buttons/size_and_position/main_size_and_position.dart';
import 'package:buttons/split_image/main_split_image.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyApp(),
    ));

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  onButtonTap(Widget page) {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => page));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Samples"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            MyMenuButton(
              title: "Fetch Data JSON",
              actionTap: () {
                onButtonTap(
                  const MainFetchData(),
                );
              },
            ),
            MyMenuButton(
                title: "Persistent Tab Bar",
                actionTap: () {
                  onButtonTap(
                    const MainPersistentTabBar(),
                  );
                }),
            MyMenuButton(
              title: "Collapsing Toolbar",
              actionTap: () {
                onButtonTap(
                  const MainCollapsingToolbar(),
                );
              },
            ),
            MyMenuButton(
              title: "Hero Animations",
              actionTap: () {
                onButtonTap(
                  const MainHeroAnimationsPage(),
                );
              },
            ),
            MyMenuButton(
              title: "Size and Positions",
              actionTap: () {
                onButtonTap(
                  const MainSizeAndPosition(),
                );
              },
            ),
            MyMenuButton(
              title: "ScrollController and ScrollNotification",
              actionTap: () {
                onButtonTap(
                  const MainScrollController(),
                );
              },
            ),
            MyMenuButton(
              title: "Apps Clone",
              actionTap: () {
                onButtonTap(
                  const MainAppsClone(),
                );
              },
            ),
            MyMenuButton(
              title: "Animations",
              actionTap: () {
                onButtonTap(
                  const MainAnimations(),
                );
              },
            ),
            MyMenuButton(
              title: "Communication Widgets",
              actionTap: () {
                onButtonTap(
                  const MainCommunicationWidgets(),
                );
              },
            ),
            MyMenuButton(
              title: "Split Image",
              actionTap: () {
                onButtonTap(const MainSplitImage());
              },
            ),
            MyMenuButton(
              title: "Custom AppBar & SliverAppBar",
              actionTap: () {
                onButtonTap(const MainAppBarSliverAppBar());
              },
            ),
            MyMenuButton(
              title: "Menu Navigations",
              actionTap: () {
                onButtonTap(const MainMenuNavigations());
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MyMenuButton extends StatelessWidget {
  final String? title;
  final VoidCallback? actionTap;

  const MyMenuButton({super.key, this.title, this.actionTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: MaterialButton(
        height: 50.0,
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        onPressed: actionTap,
        child: Text(title!),
      ),
    );
  }
}
