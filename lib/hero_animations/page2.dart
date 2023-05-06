import 'package:flutter/material.dart';
import 'package:buttons/hero_animations/main_hero_animations.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Hero(
                tag: "hero1",
                child: Container(
                  padding: const EdgeInsets.only(top: 50.0),
                  height: 250.0,
                  width: 250.0,
                  child: const CustomLogo(),
                ),
              ),
            ),
            const Align(
              alignment: Alignment.centerRight,
              child: Hero(
                tag: "hero2",
                child: Material(
                    color: Colors.transparent,
                    child: Text(
                      "Hero Text",
                      style: TextStyle(fontSize: 40.0),
                    )),
              ),
            ),
            OutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Icon(Icons.close),
            )
          ],
        ),
      ),
    );
  }
}
