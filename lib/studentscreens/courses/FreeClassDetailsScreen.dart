import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../Model/FreeClassDetailsModule.dart';
import '../../Model/FreeClassModel.dart';
import '../../utils/widgits/PdfView.dart';


class FreeClassDetailsScreen extends StatefulWidget {
  final FreeClass freeClass;

  FreeClassDetailsScreen({required this.freeClass});

  @override
  State<FreeClassDetailsScreen> createState() => _FreeClassDetailsScreenState();
}

class _FreeClassDetailsScreenState extends State<FreeClassDetailsScreen> {

  Future<FreeClassDetails> fetchFreeClassDetails(String id) async {
    final apiUrl = "https://gyanmeeti.in/API/free_class_details.php";
    final response = await http.post(Uri.parse(apiUrl), body: {'id': id});

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data.containsKey("free_class")) {
        final classDetailsData = data["free_class"][0]; // First element contains the details
        return FreeClassDetails(
          id: classDetailsData["id"].toString(),
          className: classDetailsData["class_name"],
          description: classDetailsData["description"],
          registerDate: classDetailsData["register_date"],
          uploadVideo: classDetailsData["upload_video"],
          uploadPdf: classDetailsData["upload_pdf"],
        );
      } else {
        throw Exception(data["message"] ?? "No Free Class found");
      }
    } else {
      throw Exception("Failed to load free class details");
    }
  }
  late YoutubePlayerController _controller;

  @override
  void initState() {
    // final videoID = YoutubePlayer.convertUrlToId(vidoURL);
    // _controller = YoutubePlayerController(
    //     initialVideoId: videoID!,
    //     flags: const YoutubePlayerFlags(
    //       autoPlay: false,
    //     )
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.freeClass.className}'),
      ),
      body: FutureBuilder<FreeClassDetails>(
        future: fetchFreeClassDetails(widget.freeClass.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.red,
                ),
              ),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text(
                'No free class details found.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            );
          } else {
            final freeClassDetails = snapshot.data!;
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   'https://gyanmeeti.in/admin/free_class_pdf/${freeClassDetails.uploadPdf}',
                  //   style: TextStyle(
                  //     fontSize: 16,
                  //     color: Colors.blue,
                  //   ),
                  // ),
                  SizedBox(height: 16),
                  Text(
                    'Register Date: ${freeClassDetails.registerDate}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 16),

                  (freeClassDetails.uploadVideo!.isNotEmpty) ? YoutubePlayer(
                    // controller: _controller,
                    controller: YoutubePlayerController(
                      initialVideoId: YoutubePlayer.convertUrlToId(freeClassDetails.uploadVideo.toString())!,
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
                  SizedBox(height: 16.sp),
                  (freeClassDetails.uploadPdf!.isNotEmpty) ? GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PdfView(url: "https://gyanmeeti.in/admin/${freeClassDetails.uploadPdf}"),
                      ));
                    },
                    child: Image(
                      height: 50.sp,
                      image: AssetImage('assets/images/pdf.png'),
                    ),
                  ) : Container(),
                  SizedBox(height: 16.sp),
                  Text(
                    freeClassDetails.description.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
