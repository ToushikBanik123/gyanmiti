import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../Model/ExamCategoryModel.dart';
import '../../Model/ExamListExamTileModel.dart';
import '../../Provider/appProvider.dart';
import 'package:flutter/cupertino.dart';
import '../EnrolledTestSeriesList.dart';
import '../FreeTestSeriesList.dart';
import '../PaidTestSeriesList.dart';
class ExamTabBar extends StatefulWidget {
  final String category; // Make category field required

  ExamTabBar({required this.category}); // Constructor with required parameter

  @override
  _ExamTabBarState createState() => _ExamTabBarState();
}

class _ExamTabBarState extends State<ExamTabBar> {
  int _selectedTabIndex = 0; // Default to the first tab

  final List<Tab> _tabs = [
    Tab(text: "Free Test"),
    Tab(text: "Paid Test"),
    Tab(text: "Enrolled Test"),
  ];

  @override
  Widget build(BuildContext context) {
    // print(widget.category);
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Test Series"),
          bottom: TabBar(
            isScrollable: true,
            tabs: _tabs,
            onTap: (int index) {
              setState(() {
                _selectedTabIndex = index;
              });
            },
            indicatorColor: Colors.red, // Highlighted color
          ),
        ),
        body: TabBarView(
          children: [
            FreeTestSeriesList(category: widget.category),
            PaidTestSeriesList(category: widget.category),
            EnrolledTestSeriesList(category: widget.category)
          ],
        ),
      ),
    );
  }
}




