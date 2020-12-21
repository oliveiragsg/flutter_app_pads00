import 'package:firebase_database/firebase_database.dart';
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

  Game.fromSnapshot(DataSnapshot snapshot) :
      id = snapshot.key,
      name = snapshot.value['name'],
      avatarURL = snapshot.value['avatarURL'];

  toJson() {
    return {
      "name": name,
      "avatarURL": avatarURL,
    };
  }
}