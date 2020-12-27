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
import 'package:firebase_database/ui/firebase_list.dart';
import 'package:firebase_database/ui/firebase_sorted_list.dart';
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
  final List<User> userList = [];

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
            Map<dynamic, dynamic> values = snapshot.data.value;
            bool checkList = checkUserList(userList);
            print(checkList);
            if(checkList == true){
              print("Deu true entou vou adicionar mais users");
              values.forEach((key, value) {
                userList.add(User(
                  id: key,
                  name: value["name"],
                  email: value["email"],
                  password: value["password"],
                  avatarURL: value["avatarURL"],
                ));
              });
              print("após adicionar users porque a lista estava vazia agora tem:");
              print(userList.length);
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
                              return Dismissible(
                                key: Key(item),
                                onDismissed: (direction) {
                                  if(direction == DismissDirection.startToEnd){
                                    setState(() {
                                      userList.removeAt(index);
                                    });
                                    Scaffold.of(context).showSnackBar(SnackBar(content: Text("$item Liked")));
                                  }
                                  else if(direction == DismissDirection.endToStart){
                                    setState(() {
                                      userList.removeAt(index);
                                    });
                                    Scaffold.of(context).showSnackBar(SnackBar(content: Text("$item dismissed")));
                                  }


                                },
                                child: new UserTile(
                                    userList[index]
                                ),
                              );
                        }),
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
}

bool checkUserList(List<User> userList) {
  print("______________________________");
  print(userList.length);
  if(userList.length == 0) {
    return true;
  }
  else {
    return false;
  }

}
