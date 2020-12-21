// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_app_pads00/components/partner_tile.dart';
// import 'package:flutter_app_pads00/data/myUser.dart';
// import 'package:flutter_app_pads00/provider/users.dart';
// import 'package:provider/provider.dart';
//
// class PartnersScreen extends StatelessWidget {
//
//   /////////////////////////////////////////////
//   ///Descobrir como fazer para o Build esperar o carregamento dos usuários antes de carreagr a página.////////////
//   /// Essa página tem que ser Stateful provavelmente//
//   /////////////////////////////////////////////
//
//
//   @override
//   Widget build(BuildContext context) {
//     final Users users = Provider.of(context);
//
//   return (myUser.matchs?.isEmpty ?? true) ? Scaffold(
//       backgroundColor: Colors.pink,
//       appBar: AppBar(
//         title: Center(
//           child: Text('Lista de Parceiros'),
//         ),
//         backgroundColor: Colors.redAccent,
//         automaticallyImplyLeading: false,
//       ),
//       body: Center(child: Text("Você ainda não tem nenhum parceiro! ", style: TextStyle(fontSize: 20.0, color: Colors.black))),) : Scaffold(
//         backgroundColor: Colors.pink,
//         appBar: AppBar(
//           title: Center(
//             child: Text('Lista de Parceiros'),
//           ),
//           backgroundColor: Colors.redAccent,
//           automaticallyImplyLeading: false,
//         ),
//         body: ListView.builder (
//           itemCount: users.matchsCount,
//           itemBuilder: (ctx, i) {
//             return Container(
//               margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
//               child: PartnerTile(users.usersMatched(i)));
//           }
//         ),
//     );
//   }
// }
//
//

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_pads00/components/partner_tile.dart';
import 'package:flutter_app_pads00/components/user_tile.dart';
import 'package:flutter_app_pads00/data/myUser.dart';
import 'package:flutter_app_pads00/models/user.dart';
import 'package:flutter_app_pads00/provider/users.dart';
import 'package:provider/provider.dart';

class PartnersScreen extends StatelessWidget {

  final dbUsers = FirebaseDatabase.instance.reference().child('users/' + myUser.id + "/matchs");


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
              child: Row(
                children: [
                  Flexible(
                    child: new FirebaseAnimatedList(
                        shrinkWrap: true,
                        query: dbUsers, itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                        child: new PartnerTile(
                            User(
                              id: snapshot.key,
                              name: snapshot.value["name"],
                              email: snapshot.value["email"],
                              password: snapshot.value["password"],
                              avatarURL: snapshot.value["avatarURL"],)
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



