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
    setState(() {});
  }

  final dbUsers = FirebaseDatabase.instance.reference().child('users').limitToFirst(3);
  final dbUsers2 = FirebaseFirestore.instance.collection('users').snapshots();
  final List<User> userList = [];
  bool filterBool = false;

  List<String> filterList = [];
  //stream: FirebaseFirestore.instance.collection('games').where('name', whereIn: filterList).snapshots(),

  @override
  void initState() {
    super.initState();
    isExec = false;
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
                  stream: FirebaseFirestore.instance.collection('games').snapshots(),
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
    Scaffold.of(context).showSnackBar(SnackBar(content: Text("${userList[index].id} dismissed")));
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
        print(isSelected);
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
        print(widget.isSelected);
        widget.isSelected ? widget.isSelected = false : widget.isSelected = true;
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
          widget.callback;
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