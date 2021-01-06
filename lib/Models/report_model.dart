class ReportModel {
  final String idReport;
  final String title;
  final String description;
  final String hour;
  final String slug;

  ReportModel.fromJson(Map <String, dynamic> json)
      : idReport = json['_id'],
        title = json['title'],
        description = json['description'],
        hour = json['hour'],
        slug = json['slug'];

}
