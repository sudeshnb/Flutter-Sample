import 'package:flutter/material.dart';
import 'package:buttons/animations/split_widget/split_diagonal_widget.dart';

import 'split_half_widget.dart';

class MainSplitWidget extends StatelessWidget {
  const MainSplitWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Split Widget"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SplitHalfWidget(
              child: Center(
                child: Text(
                  "FLUTTER",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey[500],
              child: SplitDiagonalWidget(
                child: Image.asset(
                  "images/dash_dart.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              alignment: Alignment.center,
              color: Colors.grey[300],
              child: SplitHalfWidget(
                child: FlutterLogo(
                  size: MediaQuery.of(context).size.width / 3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
