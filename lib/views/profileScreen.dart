import 'package:flutter/material.dart';
import 'package:flutter_app_pads00/data/myUser.dart';
import 'package:flutter_app_pads00/models/user.dart';

class profileScreen extends StatefulWidget {


  @override
  _profileScreenState createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {

  final avatar = myUser.avatarURL==null || myUser.avatarURL.isEmpty
      ? CircleAvatar(child: Icon(Icons.person, size: 100,), minRadius: 100)
      : CircleAvatar(backgroundImage: NetworkImage(myUser.avatarURL, scale: 100), minRadius: 100,);


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.pink,
      appBar: AppBar(
        title: Center(
          child: Text('Perfil'),
        ),
        backgroundColor: Colors.redAccent,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              //Profile Picture
              Padding(
                padding: const EdgeInsets.only(left:75.0, top: 50.0, right: 75.0, bottom: 10.0),
                child: avatar,
              ),
              // Edit Profile Button
              Text(myUser.name, //Name
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:0.0, top: 10.0, right: 0.0, bottom: 10.0),
                child: RaisedButton(
                  color: Colors.red,
                  child: Text('Editar Perfil'),
                  onPressed: () {
                    print("Ir para a página de Edição de Perfil");
                  },
                ),
              ),
              //Email
              Padding(
                padding: const EdgeInsets.only(left:25.0, top: 0.0, right: 50.0, bottom: 0.0),
                child: TextField(
                  enabled: false,
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
