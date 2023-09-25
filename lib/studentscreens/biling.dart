import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BillingPage extends StatefulWidget {
  const BillingPage({Key? key}) : super(key: key);

  @override
  State<BillingPage> createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        title: Text('My Billings',style: TextStyle(
            color: Colors.black
        ),),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            SizedBox(height: 20.h,),
            Center(child: Image.asset('assets/images/cart.png',height: 200.h,)),
            SizedBox(height: 30.h,),
          ],
        ),
    );
  }
}
