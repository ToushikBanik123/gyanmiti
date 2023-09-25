import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


class PdfView extends StatefulWidget {
  final String url;
  PdfView({required this.url, Key? key}) : super(key: key);

  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              color: Colors.white,
              semanticLabel: 'Bookmark',
            ),
            onPressed: () {
              _pdfViewerKey.currentState?.openBookmarkView();
            },
          ),
        ],
      ),
      body: SfPdfViewer.network(
        widget.url,
        // 'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
        key: _pdfViewerKey,
      ),
    );
  }
}