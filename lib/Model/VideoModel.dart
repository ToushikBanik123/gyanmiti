// class CurrentAffairsVideoModel {
//   final String? id;
//   final String? title;
//   final String? registerDate;
//   final String? videoUrl;
//
//   CurrentAffairsVideoModel({
//     this.id,
//     this.title,
//     this.registerDate,
//     this.videoUrl,
//   });
// }
//

import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrentAffairsVideoModel {
  final String? id;
  final String? title;
  final String? registerDate;
  final String? videoUrl;
  final String? imageUrl;

  CurrentAffairsVideoModel({
    this.id,
    this.title,
    this.registerDate,
    this.videoUrl,
    this.imageUrl,
  });

  factory CurrentAffairsVideoModel.fromJson(Map<String, dynamic> json) {
    return CurrentAffairsVideoModel(
      id: json['id'],
      title: json['title'],
      registerDate: json['register_date'],
      videoUrl: json['video'],
      imageUrl: json['img'],
    );
  }
}



