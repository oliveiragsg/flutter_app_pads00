import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_pads00/components/game_tile.dart';
import 'package:flutter_app_pads00/data/myUser.dart';
import 'package:flutter_app_pads00/models/game.dart';


class GamesScreen extends StatefulWidget {

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GamesScreen> {

  final dbUsers = FirebaseDatabase.instance.reference().child('games');
  final dbGames = FirebaseFirestore.instance.collection('games').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 70.0),
          child: Text('Lista de Jogos'),
        ),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
              child: Row(
                children: [
                  Flexible(
                    child: new StreamBuilder(
                        //FirebaseAnimatedList
                        stream: dbGames,
                        //shrinkWrap: true,
                        //query: dbGames,
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if(!snapshot.hasData) {
                            return CircularProgressIndicator();
                          }
                          return SingleChildScrollView(
                            child: new ListView(
                              shrinkWrap: true,
                              children: snapshot.data.docs.map((document) {
                                return new GameTile(new Game(
                                  id: document.id,
                                  name: document['name'],
                                ), myUser,);
                              }).toList(),
                            ),
                          );

                        },
                    //     itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                    //   return new GameTile(new Game(
                    //       id: snapshot.key,
                    //       name: snapshot.value["name"],
                    //     ), myUser,
                    //   );
                    // }
                    ),
                  ),
                ],
              ),
      ),
      backgroundColor: Colors.pink,
    );
  }
}