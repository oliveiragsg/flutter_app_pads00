import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app_pads00/data/myUser.dart';
import 'package:flutter_app_pads00/models/user.dart';
import 'package:http/http.dart' as http;

class Users with ChangeNotifier {
  static const _baseURL = 'https://flutter-app-pads00.firebaseio.com/';
  List<User> loadedUsers = [];
  List<User> likedUsers = [];


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
          password: userData['password'],
          avatarURL: userData['avatarURL'],
          teste: userData['likes'],
        ),
      );
    });
    loadedUsers = downloadedUsers;
    notifyListeners();
    usersLikedByIndex();
  }

  List<User> get all {
    return [...loadedUsers];
  }

  int get count {
    return loadedUsers.length;
  }

  User byID(String id) {
    int totalSize = loadedUsers.length;
    for (int count = 0; count <totalSize; count++) {
      if(loadedUsers.elementAt(count).id == id) {
        return loadedUsers.elementAt(count);
      }
    }
    return null;
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
          'password': user.password,
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
          'password': user.password,
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

  void like(User myOwnUser, User likedUser) async {
    int totalSize = myOwnUser.likes.length;

    for (int count = 0; count < totalSize; count++) {
      if (myOwnUser.likes.elementAt(count).id == likedUser.id) {
        print("Este usuario ja foi curtido!!");
        return;
      }
    }
    print("usuario curtido com sucesso!!");
    myOwnUser.likes.add(likedUser);

    await http.patch(
      '$_baseURL/users/${myOwnUser.id}/likes/${likedUser.id}.json',
      body: json.encode({
        'userID': likedUser.id,
        'name': likedUser.name,
        'email': likedUser.email,
        'password': likedUser.password,
      }),
    );


    fetchUsers();

  }

  Future<void> usersLikedByIndex() async {

    final response = await http.get(
        '$_baseURL/users/${myUser.id}/likes.json'
    );
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final List<User> downloadedUsers = [];
    extractedData.forEach((userID, userData) {
      downloadedUsers.add(
        byID(userID),
      );
    });
    likedUsers = downloadedUsers;
    int totalUsers = downloadedUsers.length;
    for (int count = 0; count < totalUsers; count++) {
      myUser.likes.add(downloadedUsers[count]);
    }

    print('////////////////////////////////////////////////');
    print('Quantidade de usuários curtidos:');
    print(likedUsers.length);
    print('Instancias: ');
    print(likedUsers);
    print('////////////////////////////////////////////////');
    notifyListeners();
  }

  User usersLiked(int i) {
    return likedUsers.elementAt(i);
  }



}