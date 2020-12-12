import 'package:flutter/material.dart';
import 'package:flutter_app_pads00/components/game_tile.dart';
import 'package:flutter_app_pads00/components/user_tile.dart';
import 'package:flutter_app_pads00/data/games.dart';
import 'package:flutter_app_pads00/provider/users.dart';
import 'package:provider/provider.dart';

class GamesScreen extends StatefulWidget {

  @override
  _State createState() => _State();
}

class _State extends State<GamesScreen> {
  @override
  Widget build(BuildContext context) {
    final Users users = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Games'),
        ),
        backgroundColor: Colors.redAccent,
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: Games.length,
        itemBuilder: (ctx, i)  {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 50.0),
            child: GameTile(Games.elementAt(i)),
          );
        },
      ),
      backgroundColor: Colors.pink,
    );
  }

}