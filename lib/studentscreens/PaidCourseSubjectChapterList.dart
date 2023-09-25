import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../Model/PaidCourseModel.dart';
import '../Model/PaidCourseSubjectChapterModel.dart';
import '../Model/PaidCourseSubjectModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../utils/widgits/PdfView.dart';
import '../utils/widgits/YTVideoPlayer.dart';


class PaidCourseChapterList extends StatefulWidget {
  final PaidCourseModel course;
  final PaidCourseSubjectModel subject;

  PaidCourseChapterList({required this.course, required this.subject, Key? key}) : super(key: key);

  @override
  _PaidCourseChapterListState createState() => _PaidCourseChapterListState();
}

class _PaidCourseChapterListState extends State<PaidCourseChapterList> {
  List<PaidCourseSubjectChapterModel> chapterList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final chapters = await fetchChapters(widget.course, widget.subject);
    setState(() {
      chapterList = chapters;
    });
  }

  Future<List<PaidCourseSubjectChapterModel>> fetchChapters(PaidCourseModel course, PaidCourseSubjectModel subject) async {
    final uri = Uri.parse("https://gyanmeeti.in/API/paid_course_subject_chapter_list.php");
    final response = await http.post(uri, body: {
      "course_id": course.id.toString(),
      "subject_id": subject.id.toString(),
    });

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      if (jsonResponse.containsKey("chapter")) {
        final chapters = List<Map<String, dynamic>>.from(jsonResponse["chapter"]);
        return chapters.map((chapter) => PaidCourseSubjectChapterModel.fromJson(chapter)).toList();
      }
    }

    // Handle errors by returning an empty list or throwing an exception
    return [];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chapters"),
      ),
      body: ListView.builder(
        itemCount: chapterList.length,
        itemBuilder: (context, index) {
          final PaidCourseSubjectChapterModel chapter = chapterList[index];
          return GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChapterContentScreen(chapterId: chapter.id.toString(),)),
              );
            },
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.sp),
              ),
              margin: EdgeInsets.all(10.sp),
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        chapter.chapterName.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Icon(Icons.arrow_forward,)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}


class ChapterContent {
  final String? id;
  final String? description;
  final String? videoUrl;
  final String? pdfUrl;

  ChapterContent({
    required this.id,
    required this.description,
    required this.videoUrl,
    required this.pdfUrl,
  });

  factory ChapterContent.fromJson(Map<String, dynamic> json) {
    return ChapterContent(
      id: json['id'] ?? '',
      description: json['description'] ?? '',
      videoUrl: json['video'] ?? '',
      pdfUrl: json['pdf'] ?? '',
    );
  }
}


class ChapterContentScreen extends StatefulWidget {
  final String chapterId;

  ChapterContentScreen({required this.chapterId});

  @override
  _ChapterContentScreenState createState() => _ChapterContentScreenState();
}

class _ChapterContentScreenState extends State<ChapterContentScreen> {
  List<ChapterContent> contentList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final content = await fetchChapterContent(widget.chapterId);
    setState(() {
      contentList = content;
    });
  }

  Future<List<ChapterContent>> fetchChapterContent(String chapterId) async {
    final apiUrl = "https://gyanmeeti.in/API/paid_course_subject_chapter_content.php";
    final response = await http.post(Uri.parse(apiUrl), body: {'chapter_id': chapterId});

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data.containsKey("content")) {
        final contentList = List<Map<String, dynamic>>.from(data["content"]);
        return contentList.map((content) => ChapterContent.fromJson(content)).toList();
      }
    }

    // Handle errors by returning an empty list or throwing an exception
    return [];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chapter Content"),
      ),

      //animation_playvideo
      body: ListView.builder(
        itemCount: contentList.length,
        itemBuilder: (context, index) {
          final ChapterContent content = contentList[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.sp),
            ),
            margin: EdgeInsets.all(10.sp),
            child:  Padding(
              padding: EdgeInsets.all(10.sp),
              child: Column(
                children: [
                  (content.videoUrl!.isNotEmpty) ? GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => YTVideoPlayer(vidoURL: content.videoUrl.toString()),
                        ),
                      );
                    },
                    child: Lottie.asset(
                      'assets/animation/animation_playvideo.json',
                      fit: BoxFit.cover,
                    ),
                  ) : Container(),
                  Text(content.description.toString(),
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  (content.pdfUrl!.isNotEmpty) ? GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PdfView(url: "https://gyanmeeti.in/admin/${content.pdfUrl}"),
                      ));
                    },
                    child: Image(
                      height: 50.sp,
                      image: AssetImage('assets/images/pdf.png'),
                    ),
                  ) : Container(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

