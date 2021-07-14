import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_pads00/data/myUser.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app_pads00/components/user_tile.dart';
import 'package:flutter_app_pads00/models/user.dart';

class UserList extends StatefulWidget {

  @override
  _userListState createState() => _userListState();
}

class _userListState extends State<UserList> {
  void refresh() {
    print("REFRESH");
    setState(() {

  });
  }


  void GetUserGames() {
    filterList.clear();
    int totalGames = myUser.games.length;
    for(int i = 0; i < totalGames; i++) {
      filterList.add(myUser.games.elementAt(i).name);
    }
    // for(int i = 0; i < myUser.games.length; i++) {
    //   String gameName = myUser.games.elementAt(i).name;
    //   FirebaseFirestore.instance.collection("games").doc(gameName).collection("users").get().then((querySnapshot) {
    //     querySnapshot.docs.forEach((document) {
    //       print(document.id);
    //       userList2.add(User(
    //         id: document.id,
    //         name: document.data()["name"],
    //         email: document.data()["email"],
    //         password: document.data()["password"],
    //         avatarURL: document.data()["avatarURL"],
    //       ));
    //     });
    //   });
    // }
    // print(userList2);
  }


  final dbUsers = FirebaseDatabase.instance.reference().child('users').limitToFirst(3);
  final dbUsers2 = FirebaseFirestore.instance.collection('users').snapshots();
  final dbGames = FirebaseFirestore.instance.collection('games').snapshots();
  final List<User> userList = [];
  //final List<User> userList2 = [];
  bool filterBool = false;
  int _limit = 3;



  //final StreamController<List> _currentUserStreamCtrl = StreamController<List>.broadcast();
  //Stream<List> get onCurrentUserChanged => _currentUserStreamCtrl.stream;
  //void updateCurrentUserUI() => _currentUserStreamCtrl.sink.add(userList);


  List<String> filterList = [];

  @override
  void initState() {
    super.initState();
    isExec = false;
    GetUserGames();
  }

  @override
  Widget build(BuildContext context) {


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
                child: StreamBuilder(
                  stream: dbGames,
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) return new Center(child: CircularProgressIndicator());
                    return SingleChildScrollView(
                      child: new ListView(
                        shrinkWrap: true,
                        children: snapshot.data.docs.map((document) {
                          bool isSelected = checkGameFilter(filterList, document['name']);
                          return FilterGameTileClass(
                            gameName: document['name'],
                            filterList: filterList,
                            callback: refresh,
                            isSelected: isSelected,);
                        }).toList(),
                      ),
                    );
                  },
                ),
              );
            });
          }),
        ],
        backgroundColor: Colors.redAccent,
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').where("games", arrayContainsAny: filterList).limit(_limit).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            bool checkList = checkUserList(userList);
            if(checkList){
              snapshot.data.docs.map((document) {
                userList.add(User(
                  id: document.id,
                  name: document.data()['name'],
                  email: document.data()["email"],
                  password: document.data()["password"],
                  avatarURL: document.data()["avatarURL"],
                ));
              }).toList().shuffle();
            }
            return Center(
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
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      backgroundColor: Colors.pink,
    );
  }

  void dismiss(int index) {
    setState(() {
      userList.removeAt(index);
    });
    //Scaffold.of(context).showSnackBar(SnackBar(content: Text("${userList[index].id} dismissed")));
  }

  Widget filterGameTile(String gameName) {
    bool isSelected = false;

    return TextButton(
      style: TextButton.styleFrom(
        elevation: 10,
        side: BorderSide(color: Colors.black, width: 1),
        backgroundColor: Colors.pinkAccent,
        shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
      ),
      child: Text(gameName,
        style: TextStyle(
        color: isSelected ? Colors.deepPurpleAccent : Colors.black,
        fontSize: 20,
        fontStyle: FontStyle.normal,
        ),
      ),
      onPressed: () {
        isSelected = true;
        setState(() {
          int size = filterList.length;
          if(filterList.isNotEmpty) {
            for(int index = 0; index < size; index++) {
              if(filterList[index] == gameName) {
                filterList.removeAt(index);
                return;
              }
            }
            filterList.add(gameName);
            return;
          }
          else {
            filterList.add(gameName);
          }
        });
      },
    );
  }

}

  class FilterGameTileClass extends StatefulWidget {
    final String gameName;
    final List<String> filterList;
    final VoidCallback callback;
    bool isSelected;
    FilterGameTileClass({this.gameName, this.filterList, this.callback, this.isSelected});

    @override
      _FilterGameTileClass createState() => _FilterGameTileClass();
    }


  class _FilterGameTileClass extends State<FilterGameTileClass> {


  @override
  Widget build(BuildContext context) {

    var gameName = widget.gameName;
    VoidCallback callback = widget.callback;
    var filterList = widget.filterList;

    return TextButton(
      style: TextButton.styleFrom(
        elevation: 10,
        side: BorderSide(color: Colors.black, width: 1),
        backgroundColor: Colors.pinkAccent,
        shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
      ),
      child: Text(gameName,
        style: TextStyle(
          color: widget.isSelected ? Colors.deepPurpleAccent : Colors.black,
          fontSize: 20,
          fontStyle: FontStyle.normal,
        ),
      ),
      onPressed: () {
        isExec = true;
        widget.isSelected ? widget.isSelected = false : widget.isSelected = true;
        setState(() {
          bool gameRemoved = false;
          int size = filterList.length;
          if(filterList.isNotEmpty) {
            for(int index = 0; index < size; index++) {
              if(filterList[index] == gameName) {
                filterList.removeAt(index);
                gameRemoved = true;
                break;
              }
            }
            if(gameRemoved == false)
              filterList.add(gameName);
            //return;
          }
          else {
            filterList.add(gameName);
          }
          widget.callback();
        });
      },
    );
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

bool checkGameFilter(List<String> filterList, String gameName) {
  int size = myUser.games.length;
  for (int index = 0; index < size; index++) {
    if(myUser.games[index].name == gameName && isExec == false) {
      if(filterList.contains(gameName)) {
        return true;
      }
      else {
        filterList.add(gameName);
        return true;
      }
    }
    else {
      if(filterList.contains(gameName)) {
        return true;
      }
    }
  }
  return false;
}

bool isExec = false;