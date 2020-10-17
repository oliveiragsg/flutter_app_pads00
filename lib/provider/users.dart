import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app_pads00/data/users_teste.dart';
import 'package:flutter_app_pads00/models/user.dart';

class Users with ChangeNotifier {
  final Map<String, User> _itens = {...USERS_TESTE};

  List<User> get all {
    return [..._itens.values];
  }

  int get count {
    return _itens.length;
  }

  User byIndex(int i) {
    return _itens.values.elementAt(i);
  }

  void put(User user) {
    if(user==null) {
      return;
    }
    final id = Random().nextDouble().toString();
    _itens.putIfAbsent(id, () => User(
      id: id,
      name: user.name,
      email: user.email,
      password: user.password,
      avatarURL: user.avatarURL,
    ));
    notifyListeners();
  }
}