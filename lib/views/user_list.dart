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

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app_pads00/components/user_tile.dart';
import 'package:flutter_app_pads00/models/game.dart';
import 'package:flutter_app_pads00/models/user.dart';
import 'package:flutter_app_pads00/provider/users.dart';

class UserList extends StatefulWidget {



  @override
  _userListState createState() => _userListState();
}

class _userListState extends State<UserList> {

  final dbUsers = FirebaseDatabase.instance.reference().child('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Lista de Usuários'),
        ),
        backgroundColor: Colors.redAccent,
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: dbUsers.once(),
        builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  Flexible(
                    child: new FirebaseAnimatedList(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        query: dbUsers, itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                          return new UserTile(
                              User(
                                  id: snapshot.key,
                                  name: snapshot.value["name"],
                                  email: snapshot.value["email"],
                                  password: snapshot.value["password"],
                                  avatarURL: snapshot.value["avatarURL"],)
                          );
                          // ListTile(
                          //   trailing: IconButton(icon: Icon(Icons.delete),
                          //   onPressed: () => dbUsers.child(snapshot.key).remove(),),
                          //   title: new Text(snapshot.value["name"]),
                          // );
                    }),
                  ),
                ],
              ),
            );
            // return Padding(
            //   padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
            //   child: new ListView.builder(
            //     shrinkWrap: true,
            //     itemCount: userList.length,
            //     scrollDirection: Axis.horizontal,
            //     itemBuilder: (BuildContext context, int index) {
            //       return UserTile(userList.elementAt(index));
            //     }
            //   ),
            // );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
        backgroundColor: Colors.pink,
    );
  }
}
