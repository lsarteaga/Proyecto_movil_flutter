import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:proyecto_movil/Pages/home_page.dart';
import 'package:proyecto_movil/Pages/report_page.dart';
import 'package:proyecto_movil/Models/report_model.dart';
import 'package:proyecto_movil/Providers/report_service.dart';
import 'package:proyecto_movil/Widgets/form_report_widget.dart';

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
        : _list.items.length == 0
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      iconSize: 50,
                      icon: Icon(
                        Icons.note_add,
                      ),
                      tooltip: 'New',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FormReportWidget(),
                            ));
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Hello, start creating a new report :)',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              )
            : Scaffold(
                body: ListView(
                  children: _list.items.map(
                    (e) {
                      return _getReportItem(e);
                    },
                  ).toList(),
                ),
                floatingActionButton: _buildFloatingActionButton(),
              );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormReportWidget(),
            ));
      },
      tooltip: 'New Report',
      child: Icon(Icons.add),
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
    // date parse
    var parsedDate = DateTime.parse(report.hour);

    double width = MediaQuery.of(context).size.width * 0.2;
    double height = MediaQuery.of(context).size.height * 0.2;
    return Container(
      child: Card(
        elevation: 4.0,
        shadowColor: Theme.of(context).primaryColorDark,
        child: ListTile(
          isThreeLine: true,
          onLongPress: () {
            _deleteReportItem(report);
          },
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
          leading: Image.network(
            'https://th.bing.com/th/id/OIP.usOyL_lkNZVweV1wSnYOHAHaEK?w=317&h=180&c=7&o=5&dpr=1.25&pid=1.7',
            fit: BoxFit.cover,
            height: height,
            width: width,
          ),
          //trailing: Icon(Icons.arrow_right),
          trailing: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Icon(Icons.navigate_next),
                SizedBox(
                  height: 6,
                ),
                Text(parsedDate.day.toString() +
                    '-' +
                    parsedDate.month.toString() +
                    '-' +
                    parsedDate.year.toString()),
              ],
            ),
          ),
          title: Text(
            report.title,
            maxLines: 1,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            report.description,
            maxLines: 2,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
          ),
        ),
      ),
    );
  }

  _deleteReportItem(ReportModel report) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Delete report?'),
            content: const Text('This will delete the report permanently'),
            actions: [
              FlatButton(
                padding: EdgeInsets.zero,
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                padding: EdgeInsets.zero,
                child: const Text('ACCEPT'),
                onPressed: () {
                  var aux = _service.deleteReport(report.slug);
                  if (aux == null) {
                    print('an error has ocurred');
                  } else {
                    print(aux);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  }
                },
              ),
            ],
          );
        });
  }
}
