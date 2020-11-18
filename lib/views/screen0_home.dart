import 'package:flutter/material.dart';



class Screen0 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Home'),
        ),
        backgroundColor: Colors.redAccent,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.pink,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              RaisedButton(
                color: Colors.red,
                child: Text('Piano'),
                onPressed: () {
                  Navigator.pushNamed(context, '/piano');
                },
              ),
              RaisedButton(
                color: Colors.red,
                child: Text('Xylophone'),
                onPressed: () {
                  Navigator.pushNamed(context, '/xylophone');
                },
              ),
              RaisedButton(
                color: Colors.red,
                child: Text('Drum'),
                onPressed: () {
                  Navigator.pushNamed(context, '/drum');
                },
              ),
              RaisedButton(
                color: Colors.red,
                child: Text('User List'),
                onPressed: () {
                  Navigator.pushNamed(context, '/user_list');
                },
              ),
              RaisedButton(
                color: Colors.red,
                child: Text('Profile'),
                onPressed: () {
                  Navigator.pushNamed(context, '/profile');
                },
              ),
              RaisedButton(
                color: Colors.red,
                child: Text('BotNavBar'),
                onPressed: () {
                  Navigator.pushNamed(context, '/botnavbar');
                },
              ),
              SizedBox(
                width: 500,
                height: 500,
                child: Image.asset('assets/images/coverIMG.jpg',
                width: 600,
                height: 240,
                fit: BoxFit.contain),
              ),
            ],
          ),
        )
      ),
    );
  }
}

