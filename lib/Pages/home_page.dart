import 'package:flutter/material.dart';
import 'package:proyecto_movil/Widgets/report_widget.dart';
import 'package:proyecto_movil/Widgets/current_location_widget.dart';
import 'package:proyecto_movil/Widgets/feedback_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageStorageBucket _bucket = PageStorageBucket();
  int _selectedIndex = 0;
  final List<String> _titles = ['Reports', 'Location', 'Feedback'];

  final List<Widget> _pages = [
    ReportWidget(
      key: PageStorageKey('Reports'),
    ),
    CurrentLocationWidget(
      key: PageStorageKey('Location'),
    ),
    FeedbackWidget(
      key: PageStorageKey('Feedback'),
    )
  ];

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
      bottomNavigationBar: buildBottomNavigationBar(),
      drawer: buildDrawer(),
    );
  }

  Widget buildAppBar() {
    return AppBar(
      title: Text('Project 3738: ' + _titles[_selectedIndex]),
      centerTitle: true,
    );
  }

  Widget buildBody() {
    return PageStorage(
      bucket: _bucket,
      child: _pages[_selectedIndex],
    );
  }

  Widget buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Reports'),
        BottomNavigationBarItem(
            icon: Icon(Icons.add_location_alt), label: 'Location'),
        BottomNavigationBarItem(
            icon: Icon(Icons.announcement), label: 'Feedback'),
      ],
      currentIndex: _selectedIndex,
      onTap: onItemTapped,
      selectedItemColor: Theme.of(context).primaryColor,
    );
  }

  Widget buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: Text("email@email.com"),
            accountName: Text("User Account"),
            currentAccountPicture: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f8/Quito.jpg/420px-Quito.jpg"),
                ),
              ),
            ),
          ),
          ListTile(
            title: Text('Settings'),
            onTap: () {},
          ),
          Divider(
            color: Colors.grey,
          ),
          ListTile(
            title: Text('About'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
