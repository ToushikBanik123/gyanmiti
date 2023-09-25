import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../Model/PdfData.dart';
import '../../Model/TextData.dart';
import '../../Model/VideoModel.dart';
import '../../utils/widgits/PdfView.dart';
import '../../utils/widgits/YTVideoPlayer.dart';


class CurrentAffairs extends StatefulWidget {
  const CurrentAffairs({Key? key}) : super(key: key);

  @override
  State<CurrentAffairs> createState() => _CurrentAffairsState();
}

class _CurrentAffairsState extends State<CurrentAffairs> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  Future<List<PdfData>> fetchPdfData() async {
    final response = await http.get(Uri.parse('https://gyanmeeti.in/API/current_affiars_pdf.php'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['current_affiars_pdf'];
      return data.map((json) => PdfData.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<TextData>> fetchTextData() async {
    final response = await http.get(Uri.parse('https://gyanmeeti.in/API/current_affiars_text.php'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['current_affiars_text'];
      return data.map((json) => TextData.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  // Future<List<CurrentAffairsVideoModel>> fetchVideoFromApi() async {
  //   final apiUrl = "https://gyanmeeti.in/API/current_affiars_video.php";
  //
  //   try {
  //     final response = await http.get(Uri.parse(apiUrl));
  //
  //     if (response.statusCode == 200) {
  //       final jsonData = json.decode(response.body)["current_affiars_video"] as List<dynamic>;
  //       final fetchedVideos = jsonData.map((video) => CurrentAffairsVideoModel(
  //         id: video['id'],
  //         title: video['title'],
  //         registerDate: video['register_date'],
  //         videoUrl: video['video'],
  //       )).toList();
  //
  //       return fetchedVideos;
  //     } else {
  //       throw Exception("Failed to load videos");
  //     }
  //   } catch (e) {
  //     print("Error fetching data: $e");
  //     throw e;
  //   }
  // }

  Future<List<CurrentAffairsVideoModel>> fetchVideoFromApi() async {
    final apiUrl = "https://gyanmeeti.in/API/current_affiars_video.php";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData.containsKey("current_affiars_video")) {
          final videoData = jsonData["current_affiars_video"] as List<dynamic>;
          final fetchedVideos = videoData
              .map((video) => CurrentAffairsVideoModel.fromJson(video))
              .toList();

          return fetchedVideos;
        } else {
          throw Exception("No 'current_affiars_video' key in the response.");
        }
      } else {
        throw Exception("Failed to load videos");
      }
    } catch (e) {
      print("Error fetching data: $e");
      throw e;
    }
  }




  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Current Affairs',
          style: TextStyle(color: Colors.black),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: BottomAppBar(
            color: Colors.white,
            elevation: 0,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                tabs: [
                  Tab(
                    child: Text(
                      "Videos",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "PDF",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Text",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(
            child: FutureBuilder<List<CurrentAffairsVideoModel>>(
              future: fetchVideoFromApi(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Loading indicator while data is fetched.
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final videoList = snapshot.data;
                  return ListView.builder(
                    itemCount: videoList?.length,
                    itemBuilder: (context, index) {
                      final CurrentAffairsVideoModel? video = videoList?[index];
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => YTVideoPlayer(vidoURL: video.videoUrl!,)),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(8.sp),
                          margin: EdgeInsets.all(8.sp),
                          decoration: const BoxDecoration(
                            color: Color(0xFFF1ECF5),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(20.sp),
                                child: Text(video!.title.toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ),
                              // Padding(padding: EdgeInsets.all(8.sp),
                              //   child: YoutubePlayer(
                              //     // controller: _controller,
                              //     controller: YoutubePlayerController(
                              //         initialVideoId: YoutubePlayer.convertUrlToId(video.videoUrl.toString())!,
                              //         flags: const YoutubePlayerFlags(
                              //           autoPlay: false,
                              //         )
                              //     ),
                              //     showVideoProgressIndicator: true,
                              //     onReady: (){
                              //       debugPrint("Ready");
                              //     },
                              //   ),
                              // ),
                              (video.imageUrl!.isNotEmpty)? Padding(
                                  padding: EdgeInsets.all(8.sp),
                                  child: Image.network("https://gyanmeeti.in/admin/current_affairs_thumbnail/${video?.imageUrl}",
                                    width: MediaQuery.of(context).size.width * 0.9,
                                    fit: BoxFit.fill,
                                    height: 220.sp,
                                  ),
                              ) : Container(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(video!.registerDate.toString(),
                                    style: TextStyle(
                                      fontSize: 12.sp
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),


          Center(
            child: FutureBuilder<List<PdfData>>(
              future: fetchPdfData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Loading indicator while data is fetched.
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final pdfDataList = snapshot.data;
                  return ListView.builder(
                    itemCount: pdfDataList?.length,
                    itemBuilder: (context, index) {
                      final pdfData = pdfDataList?[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.sp),
                        child: Material(
                          elevation: 3,
                          child: GestureDetector(
                          onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => PdfView(url: "https://gyanmeeti.in/admin/${pdfData?.pdf}",),
                                  ),
                                );
                          },
                              child: Container(
                                width: (MediaQuery.of(context).size.width - 40),
                                padding: EdgeInsets.all(5.sp),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/pdf.png',
                                          width: 70,
                                        ),
                                        SizedBox(width: 30.0),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  width: 200.sp, // Set the maximum width for the text
                                                  child: Text(
                                                    pdfData!.title,
                                                    maxLines: 10, // Optional: Set the maximum number of lines
                                                    overflow: TextOverflow.ellipsis, // Optional: Handle overflow with ellipsis (...) or other methods
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),

                                              ],
                                            ),
                                            SizedBox(height: 10.sp,),
                                            ElevatedButton(
                                              onPressed: () {
                                                print("Vewing Pdf");
                                                Navigator.of(context).push(MaterialPageRoute(
                                                  builder: (context) => PdfView(url: "https://gyanmeeti.in/admin/${pdfData.pdf}"),
                                                ));
                                                // downloadAndOpenPDF(pdfUrl: "https://samarence.com/gyanmeeti/admin/${syllabus.syllabusPdf}");

                                              },
                                              style: ButtonStyle(
                                                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                    side: BorderSide(color: Colors.red), // Border color
                                                  ),
                                                ),
                                              ),
                                              child: const Text(
                                                'View PDF',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                        )
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Center(
            child: FutureBuilder<List<TextData>>(
              future: fetchTextData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Loading indicator while data is fetched.
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final textDataList = snapshot.data;
                  // return ListView.builder(
                  //   itemCount: textDataList?.length,
                  //   itemBuilder: (context, index) {
                  //     final textData = textDataList?[index];
                  //     return ListTile(
                  //       title: Text(textData!.title),
                  //       subtitle: Text(textData.description),
                  //     );
                  //   },
                  // );
                  return ListView.builder(
                    itemCount: textDataList?.length,
                    itemBuilder: (context, index) {
                      final textData = textDataList?[index];
                      return Card(
                        elevation: 3, // Adjust the shadow depth as needed
                        margin: EdgeInsets.all(10), // Adjust the card margin as needed
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // Adjust the border radius as needed
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                textData!.title,
                                style: const TextStyle(
                                  fontSize: 18, // Adjust the font size as needed
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8), // Add spacing between title and description
                              Text(
                                textData.description,
                                style: TextStyle(fontSize: 16), // Adjust the font size as needed
                              ),
                              SizedBox(height: 8), // Add spacing between description and other fields
                              Text(
                                'Date: ${textData.registerDate}',
                                style: TextStyle(
                                  fontSize: 14, // Adjust the font size as needed
                                  color: Colors.grey, // Adjust the color as needed
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );

                }
              },
            )
            ,
          ),
        ],
      ),
    );
  }
}


