import 'package:flutter/material.dart';
import 'package:buttons/app_clone/album_flow/album_flow_page.dart';
import 'package:buttons/app_clone/android_messages/android_messages_page.dart';
import 'package:buttons/app_clone/credit_cards_concept/credit_cards_concept_page.dart';
import 'package:buttons/app_clone/movies_concept/movies_concept_page.dart';
import 'package:buttons/app_clone/photo_concept/photo_concept_page.dart';
import 'package:buttons/app_clone/shoes_store/shoes_store_page.dart';
import 'package:buttons/app_clone/sports_store/sports_store_page.dart';
import 'package:buttons/app_clone/travel_concept/travel_concept_page.dart';
import 'package:buttons/app_clone/twitter_profile/twitter_profile_page.dart';
import 'package:buttons/main.dart';

class MainAppsClone extends StatefulWidget {
  const MainAppsClone({super.key});

  @override
  MainAppCloneState createState() {
    return MainAppCloneState();
  }
}

class MainAppCloneState extends State<MainAppsClone> {
  onButtonTap(Widget page) {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Apps Clone"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            MyMenuButton(
              title: "Android Messages Page",
              actionTap: () {
                onButtonTap(const AndroidMessagesPage());
              },
            ),
            MyMenuButton(
              title: "Twitter Profile Page",
              actionTap: () {
                onButtonTap(const TwitterProfilePage());
              },
            ),
            MyMenuButton(
              title: "Movies Concept",
              actionTap: () {
                onButtonTap(const MoviesConceptPage());
              },
            ),
            MyMenuButton(
              title: "Photo Concept",
              actionTap: () {
                onButtonTap(const PhotoConceptPage());
              },
            ),
            MyMenuButton(
              title: "Sports Store",
              actionTap: () {
                onButtonTap(const SportsStorePage());
              },
            ),
            MyMenuButton(
              title: "Shoes Store",
              actionTap: () {
                onButtonTap(const ShoesStorePage());
              },
            ),
            MyMenuButton(
              title: "Album Flow",
              actionTap: () {
                onButtonTap(const AlbumFlowPage());
              },
            ),
            MyMenuButton(
              title: "Credit Cards Concept",
              actionTap: () {
                onButtonTap(CreditCardConceptPage());
              },
            ),
            MyMenuButton(
              title: "Travel Concept",
              actionTap: () {
                onButtonTap(const TravelConceptPage());
              },
            ),
          ],
        ),
      ),
    );
  }
}
