import 'dart:developer';

import 'package:flutter/material.dart';

class MainSizeAndPosition extends StatefulWidget {
  const MainSizeAndPosition({super.key});

  @override
  State<MainSizeAndPosition> createState() => _MainSizeAndPositionState();
}

class _MainSizeAndPositionState extends State<MainSizeAndPosition> {
  final GlobalKey _keyRed = GlobalKey();
  final GlobalKey _keyPurple = GlobalKey();
  final GlobalKey _keyGreen = GlobalKey();

  _getSizes() {
    final RenderBox renderBoxRed =
        _keyRed.currentContext!.findRenderObject() as RenderBox;
    final sizeRed = renderBoxRed.size;

    final RenderBox renderBoxPurple =
        _keyPurple.currentContext!.findRenderObject() as RenderBox;
    final sizePurple = renderBoxPurple.size;

    final RenderBox renderBoxGreen =
        _keyGreen.currentContext!.findRenderObject() as RenderBox;
    final sizeGreen = renderBoxGreen.size;

    log("SIZE of Red: $sizeRed");
    log("SIZE of Purple: $sizePurple");
    log("SIZE of Green: $sizeGreen");
  }

  _getPositions() {
    final RenderBox renderBoxRed =
        _keyRed.currentContext!.findRenderObject() as RenderBox;
    final positionRed = renderBoxRed.localToGlobal(Offset.zero);

    final RenderBox renderBoxPurple =
        _keyPurple.currentContext!.findRenderObject() as RenderBox;
    final positionPurple = renderBoxPurple.localToGlobal(Offset.zero);

    final RenderBox renderBoxGreen =
        _keyGreen.currentContext!.findRenderObject() as RenderBox;
    final positionGreen = renderBoxGreen.localToGlobal(Offset.zero);

    log("POSITION of Red: $positionRed ");
    log("POSITION of Purple: $positionPurple ");
    log("POSITION of Green: $positionGreen ");
  }

  _afterLayout(_) {
    _getSizes();
    _getPositions();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 2,
            child: Container(
              key: _keyRed,
              color: Colors.red,
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              key: _keyPurple,
              color: Colors.purple,
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              key: _keyGreen,
              color: Colors.green,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                  elevation: 5.0,
                  padding: const EdgeInsets.all(15.0),
                  color: Colors.grey,
                  onPressed: _getSizes,
                  child: const Text("Get Sizes"),
                ),
                MaterialButton(
                  elevation: 5.0,
                  color: Colors.grey,
                  padding: const EdgeInsets.all(15.0),
                  onPressed: _getPositions,
                  child: const Text("Get Positions"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
