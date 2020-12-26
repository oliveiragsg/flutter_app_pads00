import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:flutter_app_pads00/models/game.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String avatarURL;
  File avatar;
  final List<User> likes = [];
  final List<User> matchs = [];
  final List<Game> games = [];
  final List<String> gamingPlatform = [];

  User({
    this.id,
    @required this.name,
    @required this.email,
    @required this.password,
    this.avatarURL,
    this.avatar,
  });
}