import 'package:buzdy/views/appBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final List<Map<String, dynamic>> youtubePlaylists = [
    {
      'title': "Veritabanı ve SQL Dersleri",
      'thumbnail': "https://i.ytimg.com/vi/HKpl8vmjzAs/maxresdefault.jpg",
      'videoId': "HKpl8vmjzAs"
    },
    {
      'title': "HTML,CSS, Flexbox ve Bootstrap Dersleri",
      'thumbnail': "https://i.ytimg.com/vi/xTbuH8vmi_E/maxresdefault.jpg",
      'videoId': "xTbuH8vmi_E"
    },
    {
      'title': "React Dersleri",
      'thumbnail': "https://i.ytimg.com/vi/lNfBlYAk3Lw/maxresdefault.jpg",
      'videoId': "lNfBlYAk3Lw"
    },
    {
      'title': "Github Rest Api , Flask ve Python Mini Serisi",
      'thumbnail': "https://i.ytimg.com/vi/QLe58WLMlsg/maxresdefault.jpg",
      'videoId': "QLe58WLMlsg"
    },
  ];

  final List<Map<String, dynamic>> youtubeVideos = [
    {
      'title': "Java ile 2D Oyun Programlama",
      'thumbnail': "https://i.ytimg.com/vi/-tLJr7fAads/maxresdefault.jpg",
      'videoId': "-tLJr7fAads",
      'channel': "Yazılım Bilimi",
      'views': "100K views",
      'time': "3 days ago"
    },
    {
      'title': "Python 3 Dersleri",
      'thumbnail': "https://i.ytimg.com/vi/-tLJr7fAads/maxresdefault.jpg",
      'videoId': "R75Oo--O5Q4",
      'channel': "Yazılım Bilimi",
      'views': "250K views",
      'time': "1 week ago"
    },
    {
      'title': "C++ Dersleri",
      'thumbnail': "https://i.ytimg.com/vi/UpQdjipl2OE/maxresdefault.jpg",
      'videoId': "UpQdjipl2OE",
      'channel': "Yazılım Bilimi",
      'views': "320K views",
      'time': "5 days ago"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: appBarrWitoutAction(
            title: "Feed", leadingWidget: Container(), centerTitle: true),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          /// **YouTube Shorts Section (Shows 2-3 at a time)**
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Shorts",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: Get.height / 4, // Adjusted to fit 2-3 shorts
            width: Get.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: youtubePlaylists.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(VideoPlayerScreen(
                          videoId: youtubePlaylists[index]['videoId']));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      width: Get.width / 3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: NetworkImage(
                              youtubePlaylists[index]['thumbnail']),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15))),
                          padding: EdgeInsets.all(8),
                          child: Text(
                            youtubePlaylists[index]['title'],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          Divider(color: Colors.grey[400], thickness: 1),

          /// **YouTube Videos Section**
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Videos",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: youtubeVideos.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(VideoPlayerScreen(
                          videoId: youtubeVideos[index]['videoId']));
                    },
                    child: Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(10)),
                            child: Image.network(
                              youtubeVideos[index]['thumbnail'],
                              height: Get.height / 4,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.red,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 5),
                                      Text(
                                        youtubeVideos[index]['title'],
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        '${youtubeVideos[index]['channel']} • ${youtubeVideos[index]['views']} • ${youtubeVideos[index]['time']}',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[600]),
                                      ),
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Icon(Icons.more_vert),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          SizedBox(
            height: 10,
          )
        ]));
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String videoId;
  const VideoPlayerScreen({super.key, required this.videoId});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Now Playing")),
      body: Center(
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
        ),
      ),
    );
  }
}
