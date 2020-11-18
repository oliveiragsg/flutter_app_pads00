import 'package:flutter/cupertino.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String avatarURL;
  final List<User> likes;

  const User({
    this.id,
    @required this.name,
    @required this.email,
    @required this.password,
    this.avatarURL,
    this.likes,
  });
}