import 'package:flutter/material.dart';
import 'package:buttons/hero_animations/main_hero_animations.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Stack(
          children: <Widget>[
            const Align(
              alignment: Alignment.center,
              child: Hero(
                tag: "hero1",
                child: SizedBox(
                  height: 250.0,
                  width: 250.0,
                  child: CustomLogo(),
                ),
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
