import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_pads00/models/user.dart';
import 'package:flutter_app_pads00/provider/users.dart';
import 'package:flutter_app_pads00/views/loginScreen.dart';

class startScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
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
              Text('Login'),
              MyCustomForm(),
              Padding(
                padding: const EdgeInsets.only(left:0.0, top: 100.0, right: 0.0, bottom: 0.0),
                child: RaisedButton(
                  color: Colors.red,
                  child: Text('Signup'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                ),
              ),
              Text('Does not have an account yet? Sign in.'),
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
  final myControllerEmail = TextEditingController();
  final email = Email(email: '');

  @override
  void dispose() {
    myControllerEmail.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {

    User user;

    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: myControllerEmail,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('Forget your e-mail?'),
                RaisedButton(
                  color: Colors.red,
                  child: Text('Next'),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      email.email = myControllerEmail.text;
                      if(await Users().byEmail(email.email) != null) {
                        user = await Users().byEmail(email.email);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => loginScreen(myEmail: email, myUserLogin: user)));
                      }
                      else {
                        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Esta conta não existe! Email: ${email.email}')));
                      }
                    }
                    else {
                      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Há campos que precisam ser preenchidos para prosseguir.')));
                    }
                  },
                )
              ],
            ),
          ],
        )
    );
  }
}

class Email {
  String email;

  String get myEmail {
    return myEmail;
  }

   set myEmail(String controllerEmail) {
    email = controllerEmail;
  }

  Email({this.email});
}