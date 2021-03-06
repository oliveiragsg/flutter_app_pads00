import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_pads00/data/myUser.dart';
import 'package:flutter_app_pads00/models/user.dart';
import 'package:flutter_app_pads00/provider/users.dart';
import 'package:flutter_app_pads00/routes/app_routes.dart';
import 'package:provider/provider.dart';


final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;


class signupScreen extends StatefulWidget {

  @override
  signupScreenState createState() => signupScreenState();
}


  class signupScreenState extends State<signupScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Padding(
          padding: const EdgeInsets.only(left: 100.0),
          child: Text('Signup'),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left:10.0, top: 50.0, right: 10.0, bottom: 50.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(500.0),
                  child: Image.asset('assets/images/appLogo.jpg',
                      width: 600,
                      height: 240,
                      fit: BoxFit.fill),
                ),
              ),
              MyCustomForm()
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
  final Map<String, String> _formData = {};
  bool checkBox = false;
  bool _success;
  String _userEmail;
  String _userID;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(child: Text('Insira seu nome')),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: TextFormField(
                onSaved: (value) => _formData['name']=value,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  icon: Icon(Icons.person, color: Colors.black),
                  hintText: 'Nome',
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
            Center(child: Text('Insira seu E-mail')),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: TextFormField(
                onSaved: (value) => _formData['email']=value,
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  icon: Icon(Icons.email, color: Colors.white),
                  hintText: 'E-mail',
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
            Center(child: Text('Confirme seu E-mail')),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  icon: Icon(Icons.email, color: Colors.white),
                  hintText: 'E-mail',
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
            Center(child: Text('Crie uma senha')),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: TextFormField(
                onSaved: (value) => _formData['password']=value,
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
            Center(child: Text('Confirme sua senha')),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
            Padding(
              padding: const EdgeInsets.only(left:0.0, top: 10.0, right: 0.0, bottom: 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Checkbox(
                    value: checkBox,
                    onChanged: (resp) {
                      setState(() {
                        checkBox = resp;
                      });
                    },
                  ),
                  Text('Termos de Adesão')
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left:0.0, top: 25.0, right: 0.0, bottom: 0.0),
                child: RaisedButton(
                  color: Colors.red,
                  child: Text('Signup'),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      if (checkBox == true) {
                        _formKey.currentState.save();
                        _register();
                      }
                      else {
                        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Concorde com os Termos de Adesão para Prosseguir')));
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

  void _register() async {
    final auth.User user = (await
    _auth.createUserWithEmailAndPassword(
      email: _formData['email'],
      password: _formData['password'],
    )
    ).user;
    if (user != null) {
      setState(() async {
        _success = true;
        _userEmail = user.email;
        _userID = user.uid;
        // await Provider.of<Users>(context, listen:false).put(
        //   User(
        //     id: _userID,
        //     name: _formData['name'],
        //     email: _formData['email'],
        //     password: _formData['password'],
        //   ),
        // );
        await Users().putDB(User(
          id: _userID,
          name: _formData['name'],
          email: _formData['email'],
          password: _formData['password'],
        ), _userID);
        myUser = await Users().byEmail(_formData['email']);
        Navigator.of(context).pushReplacementNamed(AppRoutes.BOTNAVBAR);
      });
    } else {
      setState(() {
        _success = true;
      });
    }
  }

}