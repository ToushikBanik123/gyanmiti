// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../Model/Syllabus.dart';
// import '../../utils/widgits/SyllabusTile.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:url_launcher/url_launcher.dart';
//
// class SyllabusUi extends StatefulWidget {
//   const SyllabusUi({Key? key}) : super(key: key);
//
//   @override
//   State<SyllabusUi> createState() => _SyllabusUiState();
// }
//
// class _SyllabusUiState extends State<SyllabusUi> {
//   Future<List<Syllabus>> fetchSyllabusList() async {
//     final response = await http.get(Uri.parse('https://samarence.com/gyanmeeti/API/syllabus_list.php'));
//
//     if (response.statusCode == 200) {
//       final Map<String, dynamic> jsonData = json.decode(response.body);
//       final List<dynamic> syllabusData = jsonData['syllabus'];
//
//       return syllabusData.map((data) => Syllabus.fromJson(data)).toList();
//     } else {
//       throw Exception('Failed to load syllabus list');
//     }
//   }
//
//   void downloadPDF({required String pdfUrl}) async {
//     if (await canLaunch(pdfUrl)) {
//       await launch(pdfUrl);
//     } else {
//       throw Exception('Could not launch $pdfUrl');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder(
//           future: fetchSyllabusList(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return CircularProgressIndicator();
//             }else if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             }else {
//               final syllabusList = snapshot.data!;
//               return Scaffold(
//                 appBar: AppBar(
//                   elevation: 0,
//                   backgroundColor: Colors.white,
//                   iconTheme: IconThemeData(color: Colors.black),
//                   automaticallyImplyLeading: true,
//                   title: const Text(
//                     'Syllabus',
//                     style: TextStyle(color: Colors.black),
//                   ),
//                 ),
//                 body: ListView.builder(
//                   itemCount: syllabusList.length,
//                   itemBuilder: (context,index){
//                     return  SyllabusTile(
//                       text: 'Syllabus',
//                       onTap: () {
//                         downloadPDF(pdfUrl: "https://samarence.com/gyanmeeti/admin/${syllabusList[index].syllabusPdf}");
//                       },
//                     );
//                   },
//                 ),
//               );
//             }
//           }),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path_provider/path_provider.dart'; // Import path_provider package
import 'dart:io'; // Import the dart:io library for File
import 'package:open_file/open_file.dart'; // Import the open_file package

import '../../Model/Syllabus.dart';
import '../../utils/widgits/SyllabusTile.dart';

class SyllabusUi extends StatefulWidget {
  const SyllabusUi({Key? key}) : super(key: key);

  @override
  State<SyllabusUi> createState() => _SyllabusUiState();
}

class _SyllabusUiState extends State<SyllabusUi> {
  Future<List<Syllabus>> fetchSyllabusList() async {
    final response = await http.get(Uri.parse('https://gyanmeeti.in/API/syllabus_list.php'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List<dynamic> syllabusData = jsonData['syllabus'];

      return syllabusData.map((data) => Syllabus.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load syllabus list');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: fetchSyllabusList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final syllabusList = snapshot.data!;
              return Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  iconTheme: IconThemeData(color: Colors.black),
                  automaticallyImplyLeading: true,
                  title: const Text(
                    'Syllabus',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                body: ListView.builder(
                  itemCount: syllabusList.length,
                  itemBuilder: (context, index) {
                    return SyllabusTile(
                      text: 'Syllabus',
                      syllabus: syllabusList[index],
                    );
                  },
                ),
              );
            }
          }),
    );
  }
}
