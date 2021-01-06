/*
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => );
      case '/reports':
        if (args is String) {
          return MaterialPageRoute(builder: (_) => (
            //data: args,
          ));
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        body: Center(
          child: Text("Error"),
        ),
      );
    });
  }
}
*/
