import 'package:flutter/material.dart';
import 'package:flutter_app_pads00/models/user.dart';
import 'package:flutter_app_pads00/views/profileScreen.dart';
import 'package:flutter_app_pads00/views/screen0_home.dart';
import 'package:flutter_app_pads00/views/startScreen.dart';
import 'package:flutter_app_pads00/views/user_list.dart';



/// EXEMPLO PEGO DO SITE: https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html
/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  final User myUser;

  MyStatefulWidget({Key key, this.myUser}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 1;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    profileScreen(),
    Screen0(),
    UserList(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Likes',
          ),
        ],
        backgroundColor: Colors.redAccent,
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.black45,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
