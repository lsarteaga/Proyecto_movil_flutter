import 'dart:convert';
import 'package:proyecto_movil/Models/report_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class ReportService {
  String _urlRoot = 'http://10.0.2.2:3000/api';
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

  Future<ReportsModel> getReports() async {
    String path = '$_urlRoot/reports';
    return await _requestList(path);
  }

  Future<ReportModel> getReport(String id) async {
    String path = '$_urlRoot/reports/$id';
    return await _request(path);
  }
}
