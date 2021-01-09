import 'package:flutter/material.dart';
import 'package:proyecto_movil/Models/report_model.dart';
import 'package:proyecto_movil/Providers/report_service.dart';

class ReportPage extends StatefulWidget {
  final String idReport;
  ReportPage({Key key, @required this.idReport}) : super(key: key);
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  ReportModel _currentReport;
  ReportService _service;

  @override
  void initState() {
    super.initState();
    _service = new ReportService();
    _loadReport();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentReport == null
          ? Center(
              child: Container(
                height: 25.0,
                width: 25.0,
                child: CircularProgressIndicator(),
              ),
            )
          : buildBody(),
    );
  }

  _loadReport() {
    _service.getReport(widget.idReport).then((value) {
      _currentReport = value;
      print(_currentReport);
      setState(() {});
    });
  }

  Widget buildBody() {
    return CustomScrollView(
      slivers: [
        _appBar(_currentReport.title),
        SliverList(
          delegate: SliverChildListDelegate([
            Text(_currentReport.idReport),
            Text(_currentReport.title),
            Text(_currentReport.description),
            Text(_currentReport.address),
            Text(_currentReport.hour),
            Text(_currentReport.slug),
          ]),
        ),
      ],
    );
  }

  Widget _appBar(String title) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).primaryColor,
      pinned: true,
      expandedHeight: 200.0,
      primary: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: FadeInImage(
          image: NetworkImage(
              "https://th.bing.com/th/id/OIP.usOyL_lkNZVweV1wSnYOHAHaEK?w=317&h=180&c=7&o=5&dpr=1.25&pid=1.7"),
          fit: BoxFit.cover,
          fadeInDuration: Duration(seconds: 4),
          placeholder: NetworkImage(
              "https://upload.wikimedia.org/wikipedia/commons/thumb/f/ff/South_park_sign.svg/330px-South_park_sign.svg.png"),
        ),
      ),
    );
  }
}
