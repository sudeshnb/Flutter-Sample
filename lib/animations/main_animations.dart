import 'package:flutter/material.dart';
import 'package:buttons/animations/custom_appbar/my_custom_appbar_page.dart';
import 'package:buttons/animations/foldable/foldable_animation.dart';
import 'package:buttons/animations/list_details/list_page.dart';
import 'package:buttons/animations/menu_exploration/main_menu_exploration.dart';
import 'package:buttons/animations/neon_button/neon_button_main.dart';
import 'package:buttons/animations/split_widget/main_split_widget.dart';
import 'package:buttons/animations/turn_on_the_light/turn_on_the_light.dart';
import 'package:buttons/main.dart';
import 'custom_sliverheader/custom_sliver_header.dart';
import 'hide_my_widgets/main_hide_my_widgets.dart';
import 'shrink_top_list/shrink_top_list_page.dart';

class MainAnimations extends StatefulWidget {
  const MainAnimations({super.key});

  @override
  MainAnimationsState createState() {
    return MainAnimationsState();
  }
}

class MainAnimationsState extends State<MainAnimations> {
  onButtonTap(Widget page) {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Animations"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            MyMenuButton(
              title: "Foldable Page",
              actionTap: () {
                onButtonTap(const FoldablePage());
              },
            ),
            MyMenuButton(
              title: "List - Detail Page",
              actionTap: () {
                onButtonTap(const ListPage());
              },
            ),
            MyMenuButton(
              title: "Circular List Page",
              actionTap: () {
                // onButtonTap(CircularListPage());
              },
            ),
            MyMenuButton(
              title: "My Custom AppBar Page",
              actionTap: () {
                onButtonTap(const MyCustomAppBarPage());
              },
            ),
            MyMenuButton(
              title: "My Custom Sliver Header",
              actionTap: () {
                onButtonTap(const CustomSliverHeader());
              },
            ),
            MyMenuButton(
              title: "Split Widget",
              actionTap: () {
                onButtonTap(const MainSplitWidget());
              },
            ),
            MyMenuButton(
              title: "Turn on the light",
              actionTap: () {
                onButtonTap(const TurnOnTheLight());
              },
            ),
            MyMenuButton(
              title: "Hide my widgets",
              actionTap: () {
                onButtonTap(const MainHideMyWidgets());
              },
            ),
            MyMenuButton(
              title: "Menu Exploration",
              actionTap: () {
                onButtonTap(const MainMenuExploration());
              },
            ),
            MyMenuButton(
              title: "Shrink Top List",
              actionTap: () {
                onButtonTap(const ShrinkTopListPage());
              },
            ),
            MyMenuButton(
              title: "Neon Buttons",
              actionTap: () {
                onButtonTap(const NeonButonMain());
              },
            ),
          ],
        ),
      ),
    );
  }
}
