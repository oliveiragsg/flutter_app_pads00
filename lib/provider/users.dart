import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app_pads00/data/users_teste.dart';
import 'package:flutter_app_pads00/models/user.dart';
import 'package:http/http.dart' as http;

class Users with ChangeNotifier {
  static const _baseURL = 'https://flutter-app-pads00.firebaseio.com/';
  List<User> loadedUsers = [];

  Users() {
    fetchUsers();
  }


  //Feito a partir deste tutorial: https://medium.com/flutterdevs/http-request-dcc13e885985
  Future <void> fetchUsers() async {
    final response = await http.get(
      'https://flutter-app-pads00.firebaseio.com/users.json'
    );
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final List<User> downloadedUsers = [];
    extractedData.forEach((userID, userData) {
      downloadedUsers.add(
        User(
          id: userID,
          name: userData['name'],
          email: userData['email'],
          avatarURL: userData['avatarURL'],
        ),
      );
    });
    loadedUsers = downloadedUsers;
    notifyListeners();
  }

  List<User> get all {
    return [...loadedUsers];
  }

  int get count {
    return loadedUsers.length;
  }

  User byIndex(int i) {
    return loadedUsers.elementAt(i);
  }
  
  Future<User> byEmail(String email) async {
    await fetchUsers();
    int totalSize = loadedUsers.length;
    print('No Byemail: ${loadedUsers.length}');
    for (int count = 0; count < totalSize; count++) {
      if (loadedUsers.elementAt(count).email == email) {
        return loadedUsers.elementAt(count);
      }
      print('não é o usuário: ${loadedUsers.elementAt(count).email}');
    }
    return null;
  }

  Future<void> put(User user) async {
    if(user==null) {
      return;
    }
    if(user.id != null && user.id.trim().isNotEmpty) {
      print("http.patch");
      await http.patch(
        '$_baseURL/users/${user.id}.json',
        body: json.encode({
          'name': user.name,
          'email': user.email,
          'avatarURL': user.avatarURL,
        }),
      );
    } else {
      print('http.post');
      final response = await http.post(
        '$_baseURL/users.json',
        body: json.encode({
          'name': user.name,
          'email': user.email,
          'avatarURL': user.avatarURL,
        }),
      );
    }
    fetchUsers();
    notifyListeners();
  }

  void remove(User user) {
    if(user != null && user.id != null) {
      print("http.delete");
      http.delete(
        '$_baseURL/users/${user.id}.json',
      );
      loadedUsers.remove(user);
      notifyListeners();
    }
  }
}