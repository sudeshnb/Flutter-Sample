import 'package:flutter/material.dart';

const backgroundColor = Color(0xFF191719);

class Song {
  final String? title;
  final String? image;

  const Song({this.title, this.image});
}

const songs = [
  Song(
      title: 'Wake Me Up',
      image: 'https://i.ytimg.com/vi/ssRPuC-w2M4/hqdefault.jpg'),
  Song(
      title: 'SOS (feat. Aloe Blacc)',
      image:
          'https://lifestyle.americaeconomia.com/sites/lifestyle.americaeconomia.com/files/styles/600x600/public/avicii_sos_0.jpg'),
  Song(
      title: 'Without You (feat. Sandro Cavazza)',
      image:
          'https://d2tml28x3t0b85.cloudfront.net/tracks/artworks/000/631/866/original/c42c03.jpeg?1507101208'),
];

class Sample3 extends StatelessWidget {
  const Sample3({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        backgroundColor: backgroundColor,
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.pinkAccent,
          backgroundColor: backgroundColor,
          currentIndex: 4,
          elevation: 4,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.library_music),
              label: 'Library',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.music_note),
              label: 'Songs',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_input_antenna),
              label: 'Radio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  const HeaderWidget(),
                  const AlbumWidget(),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const <Widget>[
                          Text(
                            'Top songs',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                          Text(
                            'ADD TO PLAYLIST',
                            style: TextStyle(
                                color: Colors.pinkAccent, fontSize: 13),
                          )
                        ],
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((_, index) {
                      final song = songs[index % songs.length];
                      return ListTile(
                        leading: Image.network(
                          song.image!,
                          height: 30,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          song.title!,
                        ),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.add,
                            color: Colors.pinkAccent,
                          ),
                        ),
                      );
                    }, childCount: 20),
                  ),
                ],
              ),
            ),
            const BottomWidget(),
          ],
        ),
      ),
    );
  }
}

class AlbumWidget extends StatelessWidget {
  const AlbumWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Image.network(
              'https://clanfmok.com/wp-content/uploads/2019/12/unnamed.png',
              height: 90,
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Fades Away (Tribute Concert Version) [feat. MishCatt] - Single',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text('ADD TO PLAYLIST'),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomWidget extends StatelessWidget {
  const BottomWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Image.network(
            'https://images.genius.com/aaedbb591aa119f91b9339bbe97f20ae.1000x998x1.png',
            height: 40,
          ),
          const SizedBox(
            width: 10,
          ),
          const Text('Heaven'),
          const Spacer(),
          IconButton(
            icon: const Icon(
              Icons.play_arrow,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          Align(
            widthFactor: 0.2,
            child: IconButton(
              icon: const Icon(
                Icons.play_arrow,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),
          Align(
            widthFactor: 0.2,
            child: IconButton(
              icon: const Icon(
                Icons.play_arrow,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300,
      stretch: true,
      backgroundColor: const Color(0xFF0B0B14),
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [
          StretchMode.zoomBackground,
        ],
        background: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: Image.network(
                'https://pbs.twimg.com/media/DbQDvwGXkAgkh5f.jpg',
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Avicii',
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    const CircleAvatar(
                      backgroundColor: Colors.pinkAccent,
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
