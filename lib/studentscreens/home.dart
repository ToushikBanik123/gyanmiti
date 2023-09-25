import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';


import '../Provider/appProvider.dart';
import 'banner.dart';
import 'courses/CourseCategoryScreen.dart';
import 'courses/TestCategory.dart';
import 'courses/currentaffair.dart';
import 'courses/freeclass.dart';
import 'courses/job.dart';
import 'courses/paid.dart';
import 'courses/syllabus.dart';
import 'courses/testseries.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;


class ChooseLevel extends StatefulWidget {
  const ChooseLevel({Key? key}) : super(key: key);

  @override
  State<ChooseLevel> createState() => _ChooseLevelState();
}

class _ChooseLevelState extends State<ChooseLevel> {
  bool _isFollowing = false;
  String operatingSystem = Platform.operatingSystem;

  final PageController _controller = PageController(initialPage: 0);
  late Timer _timer;
  int _currentPage = 0;
  bool isLastPage = false;

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  late List<dynamic> banners = [];

  @override
  void initState() {
    super.initState();
    fetchBanners(); // Call the method to fetch banners

    // Initialize the timer to shift banners every 2 seconds
    _timer = Timer.periodic(Duration(seconds: 2), (Timer timer) {
      if (_currentPage < banners.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0; // Reset to the first image when reaching the last image
      }
      _controller.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    });
  }


  Future<void> fetchBanners() async {
    final apiUrl = "https://gyanmeeti.in/API/banner.php";
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        banners = data['banner'];
        // Prepend the base URL to each image URL
        for (var banner in banners) {
          banner['image'] = "https://gyanmeeti.in/admin/banner_image/${banner['image']}";
        }
      });
    } else {
      throw Exception('Failed to load banners');
    }
  }



  void _toggleFollow() {
    setState(() {
      _isFollowing = !_isFollowing;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          child: Column(
            children: [
              // Container(
              //   height: screenHeight * 0.25,
              //   child: PageView(
              //     controller: _controller,
              //     children: [
              //       GestureDetector(
              //         onTap: () {
              //           // Open the desired page when the image is tapped
              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //               builder: (context) => BannerPage(), // Replace with your actual widget/page
              //             ),
              //           );
              //         },
              //         child: Image.asset('assets/images/banner.png', fit: BoxFit.cover),
              //       ),
              //       GestureDetector(
              //         onTap: () {
              //           // Open the desired page when the image is tapped
              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //               builder: (context) => BannerPage(), // Replace with your actual widget/page
              //             ),
              //           );
              //         },
              //         child: Image.asset('assets/images/banner2.png', fit: BoxFit.cover),
              //       ),
              //     ],
              //     onPageChanged: (int page) {
              //       setState(() {
              //         _currentPage = page;
              //         isLastPage = page == 1;
              //       });
              //     },
              //   ),
              // ),

              Container(
                height: screenHeight * 0.25,
                child: PageView.builder(
                  controller: _controller,
                  itemCount: banners.length,
                  itemBuilder: (context, index) {
                    final banner = banners[index];
                    return GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => BannerPage(imageUrl: banner['image']),
                        //   ),
                        // );
                      },
                      child: Image.network(
                        banner['image'],
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                ),
              ),

              SizedBox(height: 20.h),
              Consumer<AppProvider>(builder: (context,provider,child){
                return Container(
                  child: Column(
                    children: [
                      _buildRowContainer(
                        'assets/images/paid.png',
                        'Paid Courses',
                        'assets/images/test.png',
                        'Test Series',
                            () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Paid(appuser: provider.appUser,)),
                          );
                        },
                            () {
                          Navigator.push(
                            context,
                            // MaterialPageRoute(builder: (context) => TestSeries()),
                            MaterialPageRoute(builder: (context) => TestCategory()),
                          );
                        },
                      ),
                      _buildRowContainer(
                        'assets/images/class.png',
                        'Free Class',
                        'assets/images/syllabus.png',
                        'Syllabus',
                            () {
                          Navigator.push(
                            context,
                            // MaterialPageRoute(builder: (context) => FreeClassUi()),
                            MaterialPageRoute(builder: (context) => CourseCategoryScreen()),
                          );
                        },
                            () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SyllabusUi()),
                          );
                        },
                      ),
                      _buildRowContainer(
                        'assets/images/gk.png',
                        'Current Affairs',
                        'assets/images/notify.png',
                        'Job Alerts',
                            () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CurrentAffairs()),
                          );
                        },
                            () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Job()),
                          );
                        },
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRowContainer(
      String image1,
      String text1,
      String image2,
      String text2,
      VoidCallback onTap1,
      VoidCallback onTap2,
      ) {
    return Row(
      children: [
        _buildContainer(image1, text1, onTap1),
        _buildContainer(image2, text2, onTap2),
      ],
    );
  }

  Widget _buildContainer(
      String imagePath,
      String text,
      VoidCallback onTap,
      ) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.all(10.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.sp),
            border: Border.all(
              color: Colors.grey.shade200,
              width: 2.sp,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8.sp),
                child: CircleAvatar(
                  radius: 45.sp,
                  backgroundColor: Colors.white,
                  child: Image.asset(imagePath),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.sp),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


