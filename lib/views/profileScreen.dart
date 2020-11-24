import 'package:flutter/material.dart';
import 'package:flutter_app_pads00/data/myUser.dart';
import 'package:flutter_app_pads00/models/user.dart';
import 'package:flutter_app_pads00/provider/users.dart';
import 'package:flutter_app_pads00/routes/app_routes.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class profileScreen extends StatefulWidget {



  @override
  _profileScreenState createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {


  final avatar = myUser.avatarURL==null || myUser.avatarURL.isEmpty
      ? CircleAvatar(child: Icon(Icons.person, size: 100,), minRadius: 100)
      : CircleAvatar(backgroundImage: NetworkImage(myUser.avatarURL, scale: 100), maxRadius: 100,);


  @override
  Widget build(BuildContext context) {
    // A página so atualiza quando eu coloco o Provider. O provider tem o ChangeWithNotifier. Porém eu ainda não entendi completamente, porque eu não uso o Users diretamente aqui.
    final Users users = Provider.of(context);

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
                child: FlatButton(
                  onPressed: () {
                    showModalBottomSheet(context: context, builder: (BuildContext context) {
                      return Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.pink,
                          border: Border.all(
                            color: Colors.black,
                            width: 4,
                          )
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FlatButton(
                              child: Row(
                                children: [
                                  Icon(Icons.photo_camera, size: 50.0,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Text('Camera', style: TextStyle(
                                      fontSize: 30.0,
                                    ),),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                Navigator.of(context).pushNamed(AppRoutes.CAMERA);
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                              child: Divider(
                                color: Colors.black,
                                height: 20,
                                thickness: 3,
                                indent: 20,
                                endIndent: 20,
                              ),
                            ),
                            FlatButton(
                              child: Row(
                                children: [
                                  Icon(Icons.photo, size: 50.0,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Text('Galeria', style: TextStyle(
                                      fontSize: 30.0,
                                    ),),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                print('Enviar para a galeria!!!');
                              },
                            ),
                          ],
                        ),
                      );
                    });
                  },
                  child: Stack(
                    children: [
                      avatar,
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 150.0, right: 15.0),
                          child: CircleAvatar(
                              child: Icon(Icons.photo_camera, color: Colors.black,),
                                backgroundColor: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
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
                    Navigator.of(context).pushNamed(AppRoutes.USER_FORM, arguments: myUser);
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
              Padding(
                padding: const EdgeInsets.only(left:0.0, top: 200.0, right: 0.0, bottom: 10.0),
                child: RaisedButton(
                  color: Colors.red,
                  child: Text('Sair'),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text('Sair'),
                          content: Text('Tem certeza disso?'),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Sim'),
                              onPressed: () {
                                myUser = User(name: null, email: null, password: null);
                                Navigator.of(context).pushNamed(AppRoutes.START);
                              },
                            ),
                            FlatButton(
                              child: Text('Não'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
