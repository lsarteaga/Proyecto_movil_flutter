import 'package:flutter/material.dart';
import 'package:proyecto_movil/Models/report_model.dart';
import 'package:proyecto_movil/Providers/report_service.dart';
import 'package:proyecto_movil/Common/constant.dart';

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
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(14.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }

  Widget _getDescription() {
    return TextFormField(
      initialValue: _report.description,
      decoration: InputDecoration(labelText: 'Message'),
      maxLength: 255,
      maxLines: 5,
      onSaved: (value) {
        _report.description = value;
      },
      validator: (value) {
        if (value.length < 20) {
          return 'message must be at least 20 characters';
        } else {
          return null;
        }
      },
    );
  }

  Widget getSubmit() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: RaisedButton(
        child: Row(
          children: [Icon(Icons.send), SizedBox(width: 15.0), Text('Send')],
        ),
        onPressed: _submitForm(),
      ),
    );
  }

  _submitForm() {
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();
  }
}
