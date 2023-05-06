import 'package:flutter/material.dart';
import 'package:buttons/communication_widgets/child1_page.dart';
import 'package:buttons/communication_widgets/child2_page.dart';

class ParentPage extends StatefulWidget {
  const ParentPage({super.key});

  @override
  ParentPageState createState() => ParentPageState();
}

class ParentProvider extends InheritedWidget {
  final TabController? tabController;

  final Widget chil;
  final String? title;

  const ParentProvider({
    super.key,
    this.tabController,
    required this.chil,
    this.title,
  }) : super(child: chil);

  @override
  bool updateShouldNotify(ParentProvider oldWidget) {
    return true;
  }

  static ParentProvider? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ParentProvider>();
}

class ParentPageState extends State<ParentPage>
    with SingleTickerProviderStateMixin {
  TabController? _controller;
  String myTitle = "My Parent Title";
  String? updateChild2Title;
  String? updateChild1Title;

  @override
  void initState() {
    _controller = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  updateChild2(String text) {
    setState(() {
      updateChild2Title = text;
    });
  }

  updateParent(String text) {
    setState(() {
      myTitle = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ParentProvider(
      tabController: _controller,
      title: updateChild2Title,
      chil: Column(
        children: [
          ListTile(
            title: Text(
              myTitle,
              textAlign: TextAlign.center,
            ),
          ),
          ElevatedButton(
            //Update Child 1 from Parent
            child: const Text("Action 1"),
            onPressed: () {
              setState(() {
                updateChild1Title = "Update from Parent";
              });
            },
          ),
          TabBar(
            controller: _controller,
            tabs: const [
              Tab(
                text: "First",
                icon: Icon(Icons.check_circle),
              ),
              Tab(
                text: "Second",
                icon: Icon(Icons.crop_square),
              )
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _controller,
              children: [
                Child1Page(
                  title: updateChild1Title,
                  child2Action2: updateParent,
                  child2Action3: updateChild2,
                ),
                const Child2Page(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
