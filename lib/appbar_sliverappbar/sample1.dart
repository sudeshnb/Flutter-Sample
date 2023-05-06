import 'package:flutter/material.dart';

class Sample1 extends StatelessWidget {
  const Sample1({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const Drawer(),
        appBar: const MyCustomAppBar(
          height: 150,
          defaultAppBar: true,
        ),
        body: Center(
          child: FlutterLogo(
            size: MediaQuery.of(context).size.width / 2,
          ),
        ),
      ),
    );
  }
}

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final bool defaultAppBar;

  const MyCustomAppBar({
    Key? key,
    required this.height,
    this.defaultAppBar = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.grey[300],
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: defaultAppBar
                ? AppBar(
                    title: Container(
                      color: Colors.white,
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: "Search",
                          contentPadding: EdgeInsets.all(10),
                        ),
                      ),
                    ),
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.verified_user),
                        onPressed: () {},
                      ),
                    ],
                  )
                : _customAppBar(context),
          ),
        ),
      ],
    );
  }

  Widget _customAppBar(BuildContext context) {
    return Container(
      color: Colors.red,
      padding: const EdgeInsets.all(5),
      child: Row(children: [
        IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        Expanded(
          child: Container(
            color: Colors.white,
            child: const TextField(
              decoration: InputDecoration(
                hintText: "Search",
                contentPadding: EdgeInsets.all(10),
              ),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.verified_user),
          onPressed: () {},
        ),
      ]),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
