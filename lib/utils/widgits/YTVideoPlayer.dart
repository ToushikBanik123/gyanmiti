import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YTVideoPlayer extends StatefulWidget {
  final String vidoURL;
  YTVideoPlayer({required this.vidoURL, Key? key}) : super(key: key);

  @override
  State<YTVideoPlayer> createState() => _YTVideoPlayerState();
}

class _YTVideoPlayerState extends State<YTVideoPlayer> {
  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      color: Colors.white,
      child: Scaffold(
        // appBar: AppBar(
        //   // title: Text("Video"),
        // ),
        body: (widget.vidoURL.isNotEmpty) ? YoutubePlayer(
          // controller: _controller,
          controller: YoutubePlayerController(
              initialVideoId: YoutubePlayer.convertUrlToId(widget.vidoURL)!,
              flags: const YoutubePlayerFlags(
                autoPlay: false,
              )
          ),
          showVideoProgressIndicator: true,
          onReady: (){
            debugPrint("Ready");
          },

          // bottomActions: [
          //   CurrentPosition(),
          //   ProgressBar(
          //     isExpanded: true,
          //     colors: ProgressBarColors(
          //       playedColor: Colors.blue,
          //       handleColor: Colors.blue,
          //     ),
          //   )
          // ],
        ): Container(),
      ),
    );
  }
}

