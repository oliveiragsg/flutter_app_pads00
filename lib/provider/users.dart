import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app_pads00/data/myUser.dart';
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
          password: userData['password'],
          avatarURL: userData['avatarURL'],
          teste: userData['likes'],
        ),
      );
    });
    loadedUsers = downloadedUsers;



    final response2 = await http.get(
        '$_baseURL/users/${myUser.id}/likes.json'
    );
    print(response2.statusCode);
    if (response2.statusCode == 200) {
      final extractedData2 = json.decode(response2.body) as Map<String, dynamic>;
      final List<User> listUsers = [];
      if(extractedData2 == null) {
        return;
      }
      else {
        extractedData2.forEach((userID, userData) {
          listUsers.add(
            byID(userID),
          );
        });
        print('MyUser.likes antes do clear: ');
        print(myUser.likes);
        myUser.likes.clear();
        print('MyUser.likes depois do clear: ');
        print(myUser.likes);
        int totalUsers = listUsers.length;
        for (int count = 0; count < totalUsers; count++) {
          myUser.likes.add(listUsers.elementAt(count));
        }
      }
    }
    else {
      return;
    }





    notifyListeners();
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
    print('ta chegando até aqui');
    print(myOwnUser.likes);
    print(myOwnUser.likes.length);
    int totalSize = myOwnUser.likes.length;

    for (int count = 0; count < totalSize; count++) {
      if (myOwnUser.likes.elementAt(count).id == likedUser.id) {
        print("Este usuario ja foi curtido!!");
        return;
      }
    }
    print("usuario curtido com sucesso!!");
    //myOwnUser.likes.add(likedUser);

    await http.patch(
      '$_baseURL/users/${myOwnUser.id}/likes/${likedUser.id}.json',
      body: json.encode({
        'userID': likedUser.id,
        'name': likedUser.name,
        'email': likedUser.email,
        'password': likedUser.password,
      }),
    );

    notifyListeners();
    fetchUsers();

  }

  User usersLiked(int i) {
    return myUser.likes.elementAt(i);
  }

  int get usersLikedCount {
    return myUser.likes.length;
  }


}