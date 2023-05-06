import 'package:flutter/material.dart';

import 'neon_button.dart';

class NeonButonMain extends StatefulWidget {
  const NeonButonMain({super.key});

  @override
  NeonButonMainState createState() {
    return NeonButonMainState();
  }
}

class NeonButonMainState extends State<NeonButonMain> {
  @override
  Widget build(BuildContext context) {
    const separator = SizedBox(height: 50);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Neon Buttons"),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                setState(() {});
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            separator,
            NeonButton(
              text: 'BUTTON SAMPLE BLUE',
              color: Colors.blue,
              onTap: () {
                // print('blue pressed');
              },
            ),
            NeonButton(
              text: 'BUTTON SAMPLE RED',
              color: Colors.red,
              onTap: () {
                // print('red pressed');
              },
            ),
            NeonButton(
              text: 'BUTTON SAMPLE GREEN',
              color: Colors.green,
              onTap: () {
                // print('green pressed');
              },
            ),
            separator,
          ],
        ),
      ),
    );
  }
}
