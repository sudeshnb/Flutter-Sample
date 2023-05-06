import 'package:flutter/material.dart';

class ScrollSync extends StatefulWidget {
  const ScrollSync({super.key});

  @override
  State<ScrollSync> createState() => _ScrollSyncState();
}

class _ScrollSyncState extends State<ScrollSync> {
  final CustomScrollController _controller1 = CustomScrollController();
  final CustomScrollController _controller2 = CustomScrollController();

  @override
  void initState() {
    _controller1.addListener(() => _controller2
        .jumpToWithoutGoingIdleAndKeepingBallistic(_controller1.offset));
    _controller2.addListener(() => _controller1
        .jumpToWithoutGoingIdleAndKeepingBallistic(_controller2.offset));
    super.initState();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scroll Sync"),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: ListView.builder(
              controller: _controller1,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) => Container(
                color: Colors.red,
                width: 150,
                margin: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    "$index",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: ListView.builder(
              controller: _controller2,
              itemBuilder: (_, index) => Container(
                color: Colors.black,
                margin: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    "$index",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomScrollController extends ScrollController {
  CustomScrollController({
    double initialScrollOffset = 0.0,
    keepScrollOffset = true,
    debugLabel,
  }) : super(
            initialScrollOffset: initialScrollOffset,
            keepScrollOffset: keepScrollOffset,
            debugLabel: debugLabel);

  @override
  SilentScrollPosition createScrollPosition(
    ScrollPhysics physics,
    ScrollContext context,
    ScrollPosition? oldPosition,
  ) {
    return SilentScrollPosition(
      physics: physics,
      context: context,
      oldPosition: oldPosition,
      initialPixels: initialScrollOffset,
    );
  }

  void jumpToWithoutGoingIdleAndKeepingBallistic(double value) {
    assert(positions.isNotEmpty, 'ScrollController not attached.');
    for (SilentScrollPosition position in List<ScrollPosition>.from(positions)
        as Iterable<SilentScrollPosition>) {
      position.jumpToWithoutGoingIdleAndKeepingBallistic(value);
    }
  }
}

class SilentScrollPosition extends ScrollPositionWithSingleContext {
  SilentScrollPosition({
    required ScrollPhysics physics,
    required ScrollContext context,
    ScrollPosition? oldPosition,
    double? initialPixels,
  }) : super(
          physics: physics,
          context: context,
          oldPosition: oldPosition,
          initialPixels: initialPixels,
        );

  void jumpToWithoutGoingIdleAndKeepingBallistic(double value) {
    if (pixels != value) {
      forcePixels(value);
    }
  }
}
