import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gm/studentscreens/welcome.dart';
import 'package:gm/teacherscreen/teachlogin.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class ChoosePage extends StatefulWidget {
  @override
  _ChoosePageState createState() => _ChoosePageState();
}

class _ChoosePageState extends State<ChoosePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, Colors.blue.shade100],
          ),
        ),
        child: Stack(
          children: [
            // Lottie Animation
            Positioned.fill(
              child: Lottie.asset(
                'assets/animation/move.json',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 70,
              left: 20,
              child: Row(
                children: [
                  Text(
                    'Welcome To',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                //   Text(
                //     'Gayanmati',
                //     style: TextStyle(
                //         fontSize: 27,
                //         fontWeight: FontWeight.bold,
                //         decoration: TextDecoration.underline,
                //         color: Colors.blue.shade400),
                //   ),
                  SizedBox(
                    width: 350.0,
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 30.0,
                        fontFamily: 'Agne',
                        color: Colors.blue,
                        fontWeight: FontWeight.bold
                      ),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText('Gyanmeeti'),
                          TypewriterAnimatedText('Gyanmeeti'),
                          TypewriterAnimatedText('Gyanmeeti'),
                          TypewriterAnimatedText('Gyanmeeti'),
                        ],
                        onTap: () {
                          print("Tap Event");
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),

            Positioned(
              top: 300,
              left: 16,
              right: 16,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TeachLogin()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.blue.shade500,
                          width: 1.0,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 25),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/teacher.png',
                            height: 90.h,
                          ),
                          SizedBox(height: 8.h,),
                          const Text(
                            'Teacher',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyScreen()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.blue.shade500,
                          width: 1.0,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 25),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/student.png',
                            height: 90.h,
                          ),
                          SizedBox(height: 8.h,),
                          Text(
                            'Student',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
