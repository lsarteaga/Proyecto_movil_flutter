import 'dart:convert';
import 'package:proyecto_movil/Models/report_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:proyecto_movil/Common/constant.dart';

class ReportService {
  String _urlRoot = Constant.DOMAIN + Constant.PATH;
  Map<String, String> _headers = {'Content-Type': 'application/json'};
  ReportService();
  Future<ReportsModel> _requestList(String url) async {
    try {
      final resp = await http.get(url);
      if (resp.body.isEmpty) return null;
      final decodedData = json.decode(resp.body);
      final reports = new ReportsModel.fromJsonList(decodedData['docs']);
      return reports;
    } on Exception catch (e) {
      print('Exception: $e');
      return null;
    }
  }

  Future<ReportModel> _request(String url) async {
    try {
      final resp = await http.get(url);
      if (resp.body.isEmpty) return null;
      final decodedData = json.decode(resp.body);
      final report = new ReportModel.fromJsonMap(decodedData);
      return report;
    } on Exception catch (e) {
      print('Exception: $e');
      return null;
    }
  }

  Future<ReportModel> post(ReportModel report) async {
    try {
      String url = '$_urlRoot/reports';
      final resp =
          await http.post(url, headers: _headers, body: reportToJson(report));
      if (resp.body.isEmpty) return null;
      final decodedData = json.decode(resp.body);
      final respReport = new ReportModel.fromJsonMap(decodedData);
      return respReport;
    } on Exception catch (e) {
      print('Exception: $e');
      return null;
    }
  }

  Future<ReportsModel> getReports() async {
    String path = '$_urlRoot/reports';
    return await _requestList(path);
  }

  Future<ReportModel> getReport(String id) async {
    String path = '$_urlRoot/reports/$id';
    return await _request(path);
  }
}
