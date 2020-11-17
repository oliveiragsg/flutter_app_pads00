import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_pads00/components/user_tile.dart';
import 'package:flutter_app_pads00/provider/users.dart';
import 'package:flutter_app_pads00/routes/app_routes.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Users users = Provider.of(context);


    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Lista de Usuários'),
          ),
          backgroundColor: Colors.redAccent,
          automaticallyImplyLeading: false,
        ),
     body: ListView.builder(
      itemCount: users.count,
      //shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      //itemBuilder: (ctx, i) => UserTile(users.byIndex(i)),
       itemBuilder: (ctx, i)  {
         return Container(
           margin: const EdgeInsets.symmetric(horizontal: 50.0),
           child: UserTile(users.byIndex(i)),
         );
       },
      ),
      backgroundColor: Colors.pink,
    );
  }
}
