import 'package:flutter/cupertino.dart';
import 'dart:io';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String avatarURL;
  File avatar;
  final List<User> likes = [];
  final List<User> matchs = [];
  final List<String> games = [];
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