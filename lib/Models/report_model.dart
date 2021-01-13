import 'dart:convert';

String reportToJson(ReportModel data) => json.encode(data.toJson());

class ReportModel {
  String idReport;
  String title;
  String description;
  String address;
  String hour;
  String slug;

  ReportModel(
      {this.idReport,
      this.title,
      this.description,
      this.hour,
      this.address,
      this.slug});

  ReportModel.fromJsonMap(Map<dynamic, dynamic> json) {
    if (json != null) {
      idReport = json['_id'];
      title = json['title'];
      description = json['description'];
      address = json['address'];
      hour = json['time'];
      slug = json['slug'];
    }
  }

  Map<String, dynamic> toJson() => {
        'idReport': idReport,
        'title': title,
        'description': description,
        'time': hour,
        'address': address,
        'slug': slug,
      };
}

class ReportsModel {
  List<ReportModel> items = List();
  ReportsModel();
  ReportsModel.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final reportModel = new ReportModel.fromJsonMap(item);
      items.add(reportModel);
    }
  }
}
