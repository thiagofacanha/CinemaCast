import 'package:cinemacast/ui/widgets.dart';
import 'package:flutter/material.dart';
import 'package:cinemacast/ui/themes.dart';

//https://pub.dartlang.org/packages/youtube_api#-readme-tab-
import 'package:youtube_api/youtube_api.dart';

//https://pub.dartlang.org/packages/flutter_youtube#-readme-tab-
import 'package:flutter_youtube/flutter_youtube.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Cinemacast",
      theme: themeCinemaCast,
      home: MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => new _MainAppState();
}

class _MainAppState extends State<MainApp> {
  static String youtubeApiKey = 'YOUTUBE_API';
  YoutubeAPI ytApi = new YoutubeAPI(youtubeApiKey);
  List<YT_API> ytResult = [];
  List<PodCastWidget> videoList = List<PodCastWidget>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Background(),
        PodCastCarousel(videoList),
      ]),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  _buildBottomNavigationBar() {
    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CustomIconButton.small(
              icon: Icons.view_carousel,
              iconColor: Colors.yellow,
              onPressed: () {
                //TODO
              },
            ),
            CustomIconButton.small(
              icon: Icons.playlist_play,
              iconColor: Colors.yellow,
              onPressed: () {
                //TODO
              },
            ),
            CustomIconButton.small(
              icon: Icons.favorite,
              iconColor: Colors.yellow,
              onPressed: () {
                //TODO
              },
            ),
            CustomIconButton.small(
              icon: Icons.comment,
              iconColor: Colors.yellow,
              onPressed: () {
                //TODO
              },
            ),
            CustomIconButton.small(
              icon: Icons.search,
              iconColor: Colors.yellow,
              onPressed: () {
                //TODO
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    callApi();
    super.initState();
    print('initState');
  }

  void playYoutubeVideo(String videoUrl) {
    FlutterYoutube.playYoutubeVideoByUrl(
      fullScreen: true,
      apiKey: youtubeApiKey,
      videoUrl: videoUrl,
    );
  }

  callApi() async {
    print('UI callled');
    String query = "";
    String typeChannel = "videos";
    ytResult = await ytApi.Search(query, type: typeChannel);

    setState(() {
      print('UI Updated');

      ytResult.forEach((element) => videoList.add(PodCastWidget(
          Image.network(element.thumbnail['default']['url']),
          element.title,
          element.description,
          () => playYoutubeVideo(element.url))));
    });
  }
}
