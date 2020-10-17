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
        title: Text('Lista de Usuários'),
        // actions: <Widget>[
        //   IconButton(
        //   icon: Icon(Icons.add),
        //   color: Colors.yellow,
        //   onPressed: () {
        //     Navigator.of(context).pushNamed(AppRoutes.USER_FORM);
        //   },
        //   ),
        // ],
      ),
    body: ListView.builder(
      itemCount: users.count,
      itemBuilder: (ctx, i) => UserTile(users.byIndex(i)),
      ),
    );
  }
}
