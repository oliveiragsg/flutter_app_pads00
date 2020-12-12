import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_pads00/models/game.dart';


class GameTile extends StatelessWidget {
  final Game game;
  const GameTile(this.game);

  @override
  Widget build(BuildContext context) {

    return Chip(
      label: Text(game.name),
    );
  }
}

