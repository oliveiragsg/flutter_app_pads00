import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_pads00/views/startScreen.dart';

class loginScreen extends StatelessWidget {
  final Email myEmail;

  loginScreen({this.myEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Login'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left:10.0, top: 50.0, right: 10.0, bottom: 50.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(500.0),
                  child: Image.asset('assets/images/profilePic.jpg',
                      width: 300,
                      height: 300,
                      fit: BoxFit.fill),
                ),
              ),
              Text('E-mail'),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  enabled: false,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.black
                  ),
                  decoration: InputDecoration(
                    icon: Icon(Icons.email, color: Colors .white),
                    hintText: myEmail.email,
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 25.0,
                    ),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              MyCustomForm(),
            ],
          ),
        ),
      ),
    );
  }
}


class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
              child: TextFormField(
                obscureText: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  icon: Icon(Icons.vpn_key, color: Colors.yellow),
                  hintText: 'Password',
                  errorStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                  ),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return '*Preenchimento obrigatório.';
                  }
                  return null;
                },
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left:0.0, top: 25.0, right: 0.0, bottom: 0.0),
                child: RaisedButton(
                  color: Colors.red,
                  child: Text('Enter'),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
                    }
                    else {
                      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Há campos que precisam ser preenchidos para prosseguir.')));
                    }
                  },
                ),
              ),
            ),
          ],
        )
    );
  }
}