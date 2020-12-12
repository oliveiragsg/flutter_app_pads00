import 'package:flutter/cupertino.dart';

class Game {
  final String id;
  final String name;
  final String avatarURL;
  final List<String> gamingPlatform = [];

  Game({
    this.id,
    @required this.name,
    this.avatarURL,
  });
}