import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_pads00/components/partner_tile.dart';
import 'package:flutter_app_pads00/components/user_tile.dart';
import 'package:flutter_app_pads00/data/myUser.dart';
import 'package:flutter_app_pads00/provider/users.dart';
import 'package:provider/provider.dart';

class PartnersScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Users users = Provider.of(context);



  return (myUser.likes.isEmpty ?? true) ? Scaffold(
      backgroundColor: Colors.pink,
      appBar: AppBar(
        title: Center(
          child: Text('Lista de Parceiros'),
        ),
        backgroundColor: Colors.redAccent,
        automaticallyImplyLeading: false,
      ),
      body: Center(child: Text("Você ainda não tem nenhum parceiro! ", style: TextStyle(fontSize: 20.0, color: Colors.black))),) : Scaffold(
        backgroundColor: Colors.pink,
        appBar: AppBar(
          title: Center(
            child: Text('Lista de Parceiros'),
          ),
          backgroundColor: Colors.redAccent,
          automaticallyImplyLeading: false,
        ),
        body: ListView.builder(
          itemCount: myUser.likes.length,
          itemBuilder: (ctx, i) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: PartnerTile(users.usersLikedByIndex(i)),
            );
          }
        ),
    );
  }
}





// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_app_pads00/components/partner_tile.dart';
// import 'package:flutter_app_pads00/components/user_tile.dart';
// import 'package:flutter_app_pads00/data/myUser.dart';
// import 'package:flutter_app_pads00/provider/users.dart';
// import 'package:provider/provider.dart';
//
// class PartnersScreen extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     final Users users = Provider.of(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Center(
//           child: Text('Lista de Parceiros'),
//         ),
//         backgroundColor: Colors.redAccent,
//         automaticallyImplyLeading: false,
//       ),
//       body: ListView.builder(
//         itemCount: myUser.likes.length,
//         itemBuilder: (ctx, i)  {
//           return (myUser.likes.isEmpty ?? true) ? Center(child: Text('Empty')) : Container(
//             margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
//             child: PartnerTile(users.usersLikedByIndex(i)),
//           );
//         },
//       ),
//       backgroundColor: Colors.pink,
//     );
//   }
// }

