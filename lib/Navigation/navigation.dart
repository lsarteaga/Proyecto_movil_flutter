import 'package:flutter/material.dart';
import 'package:proyecto_movil/Pages/reports_page.dart';

class Navigation extends StatefulWidget {
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[

  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
      bottomNavigationBar: buildBottomNavBar(),
    );
  }

  Widget buildAppBar() {
    return AppBar(
      title: Text("Bottom nav bar"),
    );
  }
  Widget buildBody() {
    return Center(
      child: _widgetOptions.elementAt(_selectedIndex),
    );
  }

  Widget buildBottomNavBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.library_books_outlined ),
          label: "Reports",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.insert_drive_file_outlined),
          label: "New",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.insert_comment_sharp),
          label: "Feedback",
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTap,
    );
  }
}


