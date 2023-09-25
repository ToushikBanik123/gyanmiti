import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../utils/widgits/PdfView.dart';



// class Job extends StatefulWidget {
//   const Job({Key? key}) : super(key: key);
//
//   @override
//   State<Job> createState() => _JobState();
// }
//
// class _JobState extends State<Job> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: true,
//         iconTheme: IconThemeData(color: Colors.black),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: Text(
//           'Jobs Alerts',
//           style: TextStyle(color: Colors.black),
//         ),
//         bottom: PreferredSize(
//           preferredSize: Size.fromHeight(50.h),
//           child: BottomAppBar(
//             color: Colors.white,
//             elevation: 0,
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: TabBar(
//                 controller: _tabController,
//                 isScrollable: true,
//                 tabs: [
//                   Tab(
//                     child: Text(
//                       "Vacancy",
//                       style: TextStyle(
//                         color: Colors.grey,
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                   Tab(
//                     child: Text(
//                       "Result",
//                       style: TextStyle(
//                         color: Colors.grey,
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                   Tab(
//                     child: Text(
//                       "Admit Card",
//                       style: TextStyle(
//                         color: Colors.grey,
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           Center(
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'No Data',
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Center(
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'No Data',
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Center(
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'No Data',
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class JobAlert {
  final String? id;
  final String? jobTitle;
  final String? jobPdf;
  final String? registerDate;

  JobAlert({
    this.id,
    this.jobTitle,
    this.jobPdf,
    this.registerDate,
  });

  factory JobAlert.fromJson(Map<String, dynamic> json) {
    return JobAlert(
      id: json['id'],
      jobTitle: json['job_title'],
      jobPdf: json['job_pdf'],
      registerDate: json['register_date'],
    );
  }
}

class JobAlertProvider {
  Future<List<JobAlert>> fetchJobAlerts() async {
    final response = await http.get(Uri.parse("https://gyanmeeti.in/API/job_alert.php"));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data.containsKey("job_alert")) {
        final List<dynamic> jobAlertList = data["job_alert"];
        return jobAlertList.map((json) => JobAlert.fromJson(json)).toList();
      } else {
        // Handle the case where no jobs are found.
        return [];
      }
    } else {
      // Handle any errors when fetching data from the API.
      return [];
    }
  }
}

class Job extends StatefulWidget {
  @override
  _JobState createState() => _JobState();
}

class _JobState extends State<Job> {
  final JobAlertProvider jobAlertProvider = JobAlertProvider();
  List<JobAlert> jobAlerts = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final alerts = await jobAlertProvider.fetchJobAlerts();
    setState(() {
      jobAlerts = alerts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Job Alerts"),
      ),
      body: ListView.builder(
        itemCount: jobAlerts.length,
        itemBuilder: (context, index) {
          final job = jobAlerts[index];
          // return ListTile(
          //   title: Text(job.jobTitle ?? 'No Job Title'),
          //   subtitle: Text(job.registerDate ?? 'No Date Available'),
          //   // You can add more details or actions here.
          // );
          return Card(
            elevation: 3, // You can adjust the elevation for shadow
            margin: EdgeInsets.all(10.sp),
            child: Padding(
              padding: EdgeInsets.all(15.sp),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.jobTitle ?? 'No Job Title',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8), // Add spacing between title and other info
                      Text(
                        'Register Date: ${job.registerDate ?? 'No Date Available'}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PdfView(url: "https://gyanmeeti.in/admin/${job.jobPdf}"),
                      ));
                    },
                    child: Image(
                        height: 50.sp,
                        image: AssetImage('assets/images/pdf.png'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}





