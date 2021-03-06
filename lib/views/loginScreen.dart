import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_app_pads00/data/myUser.dart';
import 'package:flutter_app_pads00/models/user.dart';
import 'package:flutter_app_pads00/provider/users.dart';
import 'package:flutter_app_pads00/routes/app_routes.dart';
import 'package:flutter_app_pads00/views/startScreen.dart';


final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;


class loginScreen extends StatelessWidget {
  final Email myEmail;
  final User localUser;

  loginScreen({this.myEmail, this.localUser});


  @override
  Widget build(BuildContext context) {

    myUser = localUser;

    final avatar = myUser.avatarURL==null || myUser.avatarURL.isEmpty
        ? CircleAvatar(child: Icon(Icons.person, size: 100,), minRadius: 100)
        : CircleAvatar(backgroundImage: NetworkImage(myUser.avatarURL, scale: 100), maxRadius: 100,);

    return Scaffold(
      backgroundColor: Colors.pink,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Padding(
          padding: const EdgeInsets.only(left: 100.0),
          child: Text('Login'),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left:10.0, top: 50.0, right: 10.0, bottom: 50.0),
                child: avatar,
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
                    hintText: myUser.email,
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
  final TextEditingController _passwordController = TextEditingController();
  bool _success;

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
                controller: _passwordController,
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
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      Users().fetchUsers();
                      _signInWithEmailAndPassword();
                      if(_success == true) {
                        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Login com sucesso!')));
                        Navigator.of(context).pushReplacementNamed(AppRoutes.BOTNAVBAR);
                      }
                      else {
                        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Não foi possível fazer login!')));
                      }
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

  void _signInWithEmailAndPassword() async {
    final auth.User user = (await _auth.signInWithEmailAndPassword(
       email: myUser.email,
       password: _passwordController.text,
    )).user;


    if (user != null) {
      setState(() {
        _success = true;
      });
    } else {
      setState(() {
        _success = false;
      });
    }
  }

}


