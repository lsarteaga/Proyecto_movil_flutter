import 'package:flutter/material.dart';
import 'package:proyecto_movil/Pages/home_page.dart';

void main() => runApp(ProyectoMovil());

class ProyectoMovil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project 3738',
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomePage(),
      },
    );
  }
}
