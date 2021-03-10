// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_app_pads00/components/user_tile.dart';
// import 'package:flutter_app_pads00/provider/users.dart';
// import 'package:provider/provider.dart';
//
// class UserList extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     final Users users = Provider.of(context);
//
//
//     return Scaffold(
//         appBar: AppBar(
//           title: Center(
//             child: Text('Lista de Usuários'),
//           ),
//           backgroundColor: Colors.redAccent,
//           automaticallyImplyLeading: false,
//         ),
//      body: ListView.builder(
//       itemCount: users.count,
//       scrollDirection: Axis.horizontal,
//        itemBuilder: (ctx, i)  {
//          return Container(
//            margin: const EdgeInsets.symmetric(horizontal: 50.0),
//            child: UserTile(users.byIndex(i)),
//          );
//        },
//       ),
//       backgroundColor: Colors.pink,
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_pads00/components/game_tile.dart';
import 'package:flutter_app_pads00/data/myUser.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app_pads00/components/user_tile.dart';
import 'package:flutter_app_pads00/models/game.dart';
import 'package:flutter_app_pads00/models/user.dart';

class UserList extends StatefulWidget {

  @override
  _userListState createState() => _userListState();
}

class _userListState extends State<UserList> {

  final dbUsers = FirebaseDatabase.instance.reference().child('users').limitToFirst(3);
  final dbGames = FirebaseDatabase.instance.reference().child('games');
  final List<User> userList = [];
  final List<User> filteredUserList = [];
  final List<Game> gamesList = [];
  bool filterBool = false;

  List<String> filterList = [];
  //final db = FirebaseFirestore.instance.collection('games').where('name', isEqualTo: ['Eternal Hope']);

  @override
  Widget build(BuildContext context) {
    filterList.add('Eternal Hope');
    filterList.add('Conan Exiles');
    filterList.add('Minecraft');


    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Lista de Usuários'),
        ),
        actions: [
          IconButton(icon: Icon(Icons.list, size: 35, color: Colors.white,), onPressed: () {
            showModalBottomSheet(context: context, builder: (BuildContext context) {
              return Container(
                height: 500,
                decoration: BoxDecoration(
                    color: Colors.pink,
                    border: Border.all(
                      color: Colors.black,
                      width: 4,
                    )
                ),
                child: FutureBuilder(
                  future: dbGames.once(),
                  builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return StreamBuilder(
                        stream: FirebaseFirestore.instance.collection('games').where('name', whereIn: filterList).snapshots(),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) return new Center(child: CircularProgressIndicator());
                          return SingleChildScrollView(
                            child: new ListView(
                              shrinkWrap: true,
                              children: snapshot.data.docs.map((document) {
                                return new GameTile(Game(
                                  name: document['name'],
                                ), myUser);
                              }).toList(),
                            ),
                          );
                        },
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              );
            });
          }),
        ],
        backgroundColor: Colors.redAccent,
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: dbUsers.once(),
        builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
          if (snapshot.hasData) {
            Map<dynamic, dynamic> values = snapshot.data.value;
            bool checkList = checkUserList(userList);
            if(checkList == true){
              values.forEach((key, value) {
                userList.add(User(
                  id: key,
                  name: value["name"],
                  email: value["email"],
                  password: value["password"],
                  avatarURL: value["avatarURL"],
                ));
              });
            }
            return Center(
              child: Column(
                children: [
                  Flexible(
                    child: new ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 1,
                        itemBuilder: (BuildContext context, int index) {
                          final item = userList[index].id;

                          return new Dismissible(
                            key: Key(item),
                            onDismissed: (direction) {
                              if(direction == DismissDirection.startToEnd){
                                setState(() {
                                  bool status = false;
                                  like(status, myUser, userList[index]);
                                  userList.removeAt(index);
                                });
                                Scaffold.of(context).showSnackBar(SnackBar(content: Text("$item Liked")));
                              }
                              else if(direction == DismissDirection.endToStart){
                                setState(() {
                                  bool status = false;
                                  dislike(status, myUser, userList[index]);
                                  userList.removeAt(index);
                                });
                                Scaffold.of(context).showSnackBar(SnackBar(content: Text("$item dismissed")));
                              }


                            },
                            child: UserTile(userList[index], () {
                              dismiss(index);
                            }),
                          );
                        }),
                    fit: FlexFit.tight,
                    flex: 1,
                  ),
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      backgroundColor: Colors.pink,
    );
  }

  Future<bool> futureFilter(String gameName) async {
    bool newBool = await dbGames.orderByKey().equalTo(gameName).onValue.isEmpty;
    return !newBool;
  }

  void filter(gameName) async {
    filterBool = await futureFilter(gameName);
  }



  void dismiss(int index) {
    setState(() {
      userList.removeAt(index);
    });
    Scaffold.of(context).showSnackBar(SnackBar(content: Text("${userList[index].id} dismissed")));
  }

}



bool checkUserList(List<User> userList) {
  if(userList.length == 0) {
    return true;
  }
  else {
    return false;
  }

}


