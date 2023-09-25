import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path_provider/path_provider.dart'; // Import path_provider package
import 'dart:io'; // Import the dart:io library for File
import 'package:open_file/open_file.dart'; // Import the open_file package

import '../../Model/Syllabus.dart';
import '../../utils/widgits/SyllabusTile.dart';
import '../../Model/Syllabus.dart';
import 'PdfView.dart';

class SyllabusTile extends StatelessWidget {
  final String text;
  final Syllabus syllabus;

  SyllabusTile({required this.text,required this.syllabus});

  void downloadAndOpenPDF({required String pdfUrl}) async {
    final response = await http.get(Uri.parse(pdfUrl));
    print("Opening Pdf");
    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/syllabus.pdf');
      await tempFile.writeAsBytes(bytes);

      // Open the PDF using the open_file package
      OpenFile.open(tempFile.path);
    } else {
      throw Exception('Failed to download PDF');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.sp),
        child: Material(
          elevation: 3,
          child: GestureDetector(
            onTap: () {
              print("Vewing Pdf");
              // downloadAndOpenPDF(pdfUrl: "https://samarence.com/gyanmeeti/admin/${syllabus.syllabusPdf}");
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PdfView(url: "https://gyanmeeti.in/admin/${syllabus.syllabusPdf}"),
              ));
            },
            child: Container(
              width: (MediaQuery.of(context).size.width - 40),
              padding: EdgeInsets.all(5.0),
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
                              Text(
                                syllabus.courseName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // const SizedBox(width: 70),
                              // Text(
                              //   'Download',
                              //   style: TextStyle(
                              //     fontSize: 12,
                              //     color: Colors.grey.shade800,
                              //   ),
                              // ),
                              // IconButton(
                              //   onPressed: () {},
                              //   icon: const Icon(Icons.save_alt, size: 20),
                              // )
                            ],
                          ),
                          SizedBox(height: 10.sp,),
                          ElevatedButton(
                            onPressed: () {
                              print("Vewing Pdf");
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PdfView(url: "https://gyanmeeti.in/admin/${syllabus.syllabusPdf}"),
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
          ),
        ),
      ),
    );
  }
}
