import 'package:flutter/material.dart';
import 'package:buttons/communication_widgets/parent_page.dart';

class MainCommunicationWidgets extends StatelessWidget {
  const MainCommunicationWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Communication Widgets"),
        ),
        body: const ParentPage(),
      ),
    );
  }
}
