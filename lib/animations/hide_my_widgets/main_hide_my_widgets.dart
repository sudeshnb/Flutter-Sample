import 'package:flutter/material.dart';
import 'package:buttons/animations/hide_my_widgets/hide_my_widget.dart';

class MainHideMyWidgets extends StatefulWidget {
  const MainHideMyWidgets({super.key});

  @override
  State<MainHideMyWidgets> createState() => _MainHideMyWidgetsState();
}

class _MainHideMyWidgetsState extends State<MainHideMyWidgets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text("Don't touch my widgets!"),
          backgroundColor: Colors.red,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                setState(() {});
              },
            )
          ],
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              color: Colors.black,
              child: Image.asset(
                "images/dash_dart_dark.png",
                fit: BoxFit.contain,
              ),
            ),
            const HideMyWidget(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [
                      0,
                      0.5,
                      1,
                    ],
                    colors: [
                      Color.fromARGB(255, 178, 19, 19),
                      Color.fromARGB(255, 181, 49, 49),
                      Color.fromARGB(255, 89, 10, 10),
                    ],
                  ),
                ),
              ),
            ),
            _myBody(),
          ],
        ));
  }

  Widget _myBody() {
    return Column(
      children: <Widget>[
        const Spacer(),
        const Expanded(
          flex: 4,
          child: FractionallySizedBox(
            widthFactor: .6,
            child: HideMyWidget(
              child: FlutterLogo(),
            ),
          ),
        ),
        const Expanded(
          flex: 1,
          child: HideMyWidget(
            child: Text(
              "Welcome \nThe Dart Side",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        const Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: HideMyWidget(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Username",
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Center(
            child: HideMyWidget(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                decoration: const BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
