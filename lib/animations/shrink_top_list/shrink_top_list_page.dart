import 'package:flutter/material.dart';
import 'package:buttons/animations/list_details/character.dart';

const itemSize = 150.0;

class ShrinkTopListPage extends StatefulWidget {
  const ShrinkTopListPage({super.key});

  @override
  State<ShrinkTopListPage> createState() => _ShrinkTopListPageState();
}

class _ShrinkTopListPageState extends State<ShrinkTopListPage> {
  final scrollController = ScrollController();

  void onListen() {
    setState(() {});
  }

  @override
  void initState() {
    characters.addAll(List.from(characters));
    scrollController.addListener(onListen);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(onListen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shrink top List'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
        child: CustomScrollView(
          controller: scrollController,
          slivers: <Widget>[
            const SliverToBoxAdapter(
              child: Placeholder(
                fallbackHeight: 100.0,
              ),
            ),
            const SliverAppBar(
              automaticallyImplyLeading: false,
              title: Text(
                'My Characters',
                style: TextStyle(color: Colors.black),
              ),
              pinned: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 50,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  const heightFactor = 0.6;
                  final character = characters[index];
                  final itemPositionOffset = index * itemSize * heightFactor;
                  final difference =
                      scrollController.offset - itemPositionOffset;
                  final percent =
                      1.0 - (difference / (itemSize * heightFactor));
                  double opacity = percent;
                  double scale = percent;
                  if (opacity > 1.0) opacity = 1.0;
                  if (opacity < 0.0) opacity = 0.0;
                  if (percent > 1.0) scale = 1.0;

                  return Align(
                    heightFactor: heightFactor,
                    child: Opacity(
                      opacity: opacity,
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()..scale(scale, 1.0),
                        child: Card(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                          ),
                          color: Color(character.color!),
                          child: SizedBox(
                            height: itemSize,
                            child: Row(
                              children: <Widget>[
                                const Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(15.0),
                                  ),
                                ),
                                Image.asset(character.avatar!),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                childCount: characters.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
