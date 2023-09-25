import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../Provider/appProvider.dart';
import 'download.dart';
import 'drawer.dart';
import 'helpchat.dart';
import 'home.dart';
import 'mycourse.dart';
import 'notification.dart';


class Home_Page extends StatefulWidget {
  Home_Page({Key? key}) : super(key: key);

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    ChooseLevel(),
    Courses(),
    Download(),
    HelpChat(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(
        onHomeTapped: () {
          setState(() {
            _currentIndex = 0;
          });
          Navigator.pop(context);
        }, onHelpTapped: () {
        setState(() {
          _currentIndex = 3;
        });
      }
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        title: Consumer<AppProvider>(builder: (context,provider,child){
          return Text(
            "${provider.appUser.name}",
            style: TextStyle(color: Colors.black),
          );
        }),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotifyPage()),
                );
              },
              icon: Icon(Icons.notifications_none_outlined),
            ),
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.blue.shade500), // Change the color to purple
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school, color: Colors.blue.shade500), // Change the color to purple
            label: 'My Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.downloading, color: Colors.blue.shade500), // Change the color to purple
            label: 'Downloads',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_mark_outlined, color: Colors.blue.shade500), // Change the color to purple
            label: 'Help Chat',
          ),
        ],
        selectedItemColor: Colors.blue.shade400,
      ),
    );
  }
}