import 'package:flutter/material.dart';
import 'package:proyecto_movil/Models/report_model.dart';
import 'package:proyecto_movil/Pages/home_page.dart';
import 'package:proyecto_movil/Providers/report_service.dart';

class FormReportWidget extends StatefulWidget {
  FormReportWidget({Key key}) : super(key: key);
  _FormReportWidgetState createState() => _FormReportWidgetState();
}

class _FormReportWidgetState extends State<FormReportWidget> {
  final formKey = GlobalKey<FormState>();
  ReportModel _report = new ReportModel();
  ReportService _service = new ReportService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Report'),
        centerTitle: true,
      ),
      body: buildBodyForm(),
    );
  }

  Widget buildBodyForm() {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(14.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              _getFieldTitle(),
              Divider(
                color: Theme.of(context).primaryColorDark,
              ),
              _getFieldAddress(),
              Divider(
                color: Theme.of(context).primaryColorDark,
              ),
              _getFieldDescription(),
              Divider(
                color: Theme.of(context).primaryColorDark,
              ),
              _getSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getFieldTitle() {
    return TextFormField(
      initialValue: _report.title,
      decoration: InputDecoration(labelText: 'Title'),
      maxLength: 30,
      maxLines: 2,
      onSaved: (value) {
        _report.title = value;
      },
      validator: (value) {
        if (value.length < 10) {
          return 'Title must be at least 10 characters';
        } else {
          return null;
        }
      },
    );
  }

  Widget _getFieldDescription() {
    return TextFormField(
      initialValue: _report.description,
      decoration: InputDecoration(labelText: 'Description'),
      maxLength: 255,
      maxLines: 5,
      onSaved: (value) {
        _report.description = value;
      },
      validator: (value) {
        if (value.length < 30) {
          return 'Description must be at least 30 characters';
        } else {
          return null;
        }
      },
    );
  }

  Widget _getFieldAddress() {
    return TextFormField(
      initialValue: _report.address,
      decoration: InputDecoration(labelText: 'Address'),
      maxLength: 50,
      maxLines: 3,
      onSaved: (value) {
        _report.address = value;
      },
      validator: (value) {
        if (value.length < 15) {
          return 'Address must be at least 15 characters';
        } else {
          return null;
        }
      },
    );
  }

  Widget _getSubmitButton() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: RaisedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(Icons.send), SizedBox(width: 15.0), Text('Send')],
        ),
        onPressed: _submitForm,
      ),
    );
  }

  _submitForm() {
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();
    _service.post(_report).then((value) {
      print(value);
      if (value != null) {
        formKey.currentState.reset();
        /*Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('Report added at: ' + value.hour),
          ),
        );*/
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Report added'),
                content: Text(value.title),
                actions: [
                  FlatButton(
                    padding: EdgeInsets.zero,
                    child: const Text('CLOSE'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ));
                    },
                  ),
                ],
              );
            });
      }
    });
  }
}
