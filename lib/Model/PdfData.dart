class PdfData {
  final String id; // Change the type to String
  final String title;
  final String registerDate;
  final String pdf;

  PdfData({
    required this.id,
    required this.title,
    required this.registerDate,
    required this.pdf,
  });

  factory PdfData.fromJson(Map<String, dynamic> json) {
    return PdfData(
      id: json['id'].toString(), // Convert it to a String
      title: json['title'],
      registerDate: json['register_date'],
      pdf: json['pdf'],
    );
  }
}
