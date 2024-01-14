import 'package:flutter/material.dart';
import 'package:uas/footballClub.dart';
import 'package:uas/reportFoot.dart';
import 'package:uas/reportSupp.dart';
import 'package:uas/supporter.dart';

class dashboard extends StatefulWidget {
  const dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Dashboard",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color.fromARGB(255, 0, 43, 78),
        // Add an IconButton to trigger the drawer
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      body: Center(
        child: Text("Welcome to the Dashboard!"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 43, 78),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Supporter'),
              onTap: () {
                // Add your supporter menu logic here
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => supporter()),
                );
              },
            ),
            ListTile(
              title: Text('Football Club'),
              onTap: () {
                // Add your football club menu logic here
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => footballClub()),
                ); // Close the drawer
              },
            ),
            ListTile(
              title: Text('Football Club Report'),
              onTap: () {
                // Add your football club menu logic here
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => reportFoot()),
                ); // Close the drawer
              },
            ),
            ListTile(
              title: Text('Supporter Report'),
              onTap: () {
                // Add your football club menu logic here
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => reportSupp()),
                ); // Close the drawer
              },
            ),
          ],
        ),
      ),
    );
  }
}
