import 'package:flutter/material.dart';

class profileScreen extends StatefulWidget {
  @override
  _profileScreenState createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(500.0),
                  child: Image.asset('assets/images/profilePic.jpg',
                  width: 600.0,
                  height: 240.0,
                  fit: BoxFit.fill),
                ),
              ),
              // Edit Profile Button
              Text('Nome', //Name
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
