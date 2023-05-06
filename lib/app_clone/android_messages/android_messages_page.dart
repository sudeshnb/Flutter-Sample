import 'package:flutter/material.dart';

class AndroidMessagesPage extends StatefulWidget {
  const AndroidMessagesPage({super.key});

  @override
  State<AndroidMessagesPage> createState() => _AndroidMessagesPageState();
}

class _AndroidMessagesPageState extends State<AndroidMessagesPage> {
  bool isGoingDown = true;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            centerTitle: true,
            backgroundColor: Colors.transparent,
            title: const Text("Messages"),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ],
          ),
          body: NotificationListener<ScrollNotification>(
              onNotification: (onScrollNotification) {
                if (onScrollNotification is ScrollUpdateNotification) {
                  if (onScrollNotification.scrollDelta! <= 0.0) {
                    if (!isGoingDown) setState(() => isGoingDown = true);
                  } else {
                    if (isGoingDown) setState(() => isGoingDown = false);
                  }
                }
                return false;
              },
              child: _buildList()),
          floatingActionButton: MyFabButton(isGoingDown)),
    );
  }

  _buildList() {
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: List.generate(30, (index) => "Message ${index + 1}")
          .map((val) => SMSItem(
                number: "456",
                text: val,
              ))
          .toList(),
    );
  }
}

class MyFabButton extends StatelessWidget {
  final bool isExtended;

  const MyFabButton(this.isExtended, {super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        child: RawMaterialButton(
            elevation: 5.0,
            shape: isExtended
                ? const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)))
                : const CircleBorder(),
            onPressed: () {},
            fillColor: Colors.blue[600],
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: isExtended
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.message,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          "Start chat",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    )
                  : const Icon(
                      Icons.message,
                      color: Colors.white,
                    ),
            )));
  }
}

class SMSItem extends StatelessWidget {
  final String? number;
  final String? text;

  const SMSItem({super.key, this.number, this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.redAccent[400],
            child: const Icon(Icons.person),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    number!,
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 17.0),
                  ),
                  Text(
                    text!,
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 15.0, color: Colors.grey),
                  )
                ],
              ),
            ),
          ),
          const Align(
            alignment: Alignment.topRight,
            child: Text(
              "Sat",
              style: TextStyle(fontSize: 15.0, color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}
