import 'package:flutter/material.dart';
import 'widgets/app_button.dart';
import 'widgets/header_widget.dart';
import 'widgets/app_text.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Page Load Animation",
      home: const AnimationsPlayground(),
      theme: ThemeData(
        textTheme: const TextTheme(
          bodySmall: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
            fontSize: 16.0,
          ),
        ),
      ),
    ),
  );
}

class AnimationsPlayground extends StatelessWidget {
  const AnimationsPlayground({super.key});

  pageTrans(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          // return SecondPage(transitionAnimation: animation);
          return const CoolAnimatedApp();
        },
        transitionDuration: const Duration(seconds: 6),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: CoolAnimatedApp(),
      body: Center(
        child: TextButton(
          onPressed: () {
            pageTrans(context);
          },
          child: const Text('data'),
        ),
      ),
    );
  }
}

class CoolAnimatedApp extends StatefulWidget {
  const CoolAnimatedApp({super.key});

  @override
  State<CoolAnimatedApp> createState() => _CoolAnimatedAppState();
}

class _CoolAnimatedAppState extends State<CoolAnimatedApp> {
  late Animation<double>? controller;
  late Animation<Offset> imageTranslation;
  late Animation<Offset> textTranslation;
  late Animation<Offset> buttonTranslation;
  late Animation<double> imageOpacity;
  late Animation<double> textOpacity;
  late Animation<double> buttonOpacity;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    controller = ModalRoute.of(context)!.animation;
    imageTranslation = Tween(
      begin: const Offset(0.0, 1.0),
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: controller!,
        curve: const Interval(0.0, 0.67, curve: Curves.fastOutSlowIn),
      ),
    );
    imageOpacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller!,
        curve: const Interval(0.0, 0.67, curve: Curves.easeIn),
      ),
    );
    textTranslation = Tween(
      begin: const Offset(0.0, 1.0),
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: controller!,
        curve: const Interval(0.10, 0.84, curve: Curves.ease),
      ),
    );
    textOpacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller!,
        curve: const Interval(0.0, 0.84, curve: Curves.linear),
      ),
    );
    buttonTranslation = Tween(
      begin: const Offset(0.0, 1.0),
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: controller!,
        curve: const Interval(0.10, 0.80, curve: Curves.easeIn),
      ),
    );
    buttonOpacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller!,
        curve: const Interval(0.0, 0.90, curve: Curves.easeIn),
      ),
    );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AnimatedBuilder(
        animation: controller!,
        builder: (BuildContext context, Widget? child) {
          return Column(
            children: <Widget>[
              FractionalTranslation(
                translation: imageTranslation.value,
                child: Opacity(
                  opacity: imageOpacity.value,
                  child: const HeaderImage(),
                ),
              ),
              Expanded(
                child: FractionalTranslation(
                  translation: textTranslation.value,
                  child: Opacity(
                    opacity: textOpacity.value,
                    child: const AppText(),
                  ),
                ),
              ),
              FractionalTranslation(
                translation: buttonTranslation.value,
                child: Opacity(
                  opacity: buttonOpacity.value,
                  child: const Button(),
                ),
              ),
              const SizedBox(height: 34.0),
            ],
          );
        },
      ),
    );
  }
}
