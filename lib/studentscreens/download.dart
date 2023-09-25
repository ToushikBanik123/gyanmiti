import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Download extends StatefulWidget {
  const Download({Key? key}) : super(key: key);

  @override
  State<Download> createState() => _DownloadState();
}

class _DownloadState extends State<Download> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              child: Text(
                "Videos",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Tab(
              child: Text(
                "PDFs",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Body of Tab 1
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/cart.png',height: 200.h,),
              ],
            ),
          ),
          // Body of Tab 2
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/cart.png',height: 200.h,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
