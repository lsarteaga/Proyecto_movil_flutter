import 'package:flutter/material.dart';
import 'package:proyecto_movil/Pages/report_page.dart';
import 'package:proyecto_movil/Models/report_model.dart';
import 'package:proyecto_movil/Providers/report_service.dart';

class ReportWidget extends StatefulWidget {
  ReportWidget({Key key}) : super(key: key);
  @override
  _ReportWidgetState createState() => _ReportWidgetState();
}

class _ReportWidgetState extends State<ReportWidget> {
  ReportsModel _list;
  ReportService _service;

  @override
  void initState() {
    _service = new ReportService();
    super.initState();
    _loadReports();
  }

  @override
  Widget build(BuildContext context) {
    return _list == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            body: ListView(
              children: _list.items.map(
                (e) {
                  return _getReportItem(e);
                },
              ).toList(),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              tooltip: 'New Report',
              child: Icon(Icons.add),
            ),
          );
  }

  _loadReports() {
    _service.getReports().then((value) {
      setState(() {
        _list = value;
      });
    });
  }

  Widget _getReportItem(ReportModel report) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReportPage(
              idReport: report.slug,
            ),
          ),
        );
      },
      child: Card(
        elevation: 2.0,
        shadowColor: Theme.of(context).primaryColorDark,
        child: ListTile(
          trailing: Icon(Icons.arrow_back),
          leading: Icon(Icons.access_alarm_rounded),
          title: Text(report.title),
          subtitle: Text(report.description),
        ),
      ),
    );
  }
}
