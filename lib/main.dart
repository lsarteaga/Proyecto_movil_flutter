import 'package:flutter/material.dart';
import 'package:proyecto_movil/Navigation/navigation.dart';
import 'package:proyecto_movil/RouteGenerator/route_generator.dart';


void main() => runApp(ProyectoMovil());

class ProyectoMovil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project 3738',
      debugShowCheckedModeBanner: false,
      home: Navigation(),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
