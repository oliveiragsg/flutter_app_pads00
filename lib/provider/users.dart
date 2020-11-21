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
        ),
      );
    });
    loadedUsers = downloadedUsers;

    final response2 = await http.get(
        '$_baseURL/users/${myUser.id}/likes.json'
    );
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
        myUser.likes.clear();
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
    for (int count = 0; count < totalSize; count++) {
      if (loadedUsers.elementAt(count).email == email) {
        return loadedUsers.elementAt(count);
      }
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
        return;
      }
    }

    await http.patch(
      '$_baseURL/users/${myOwnUser.id}/likes/${likedUser.id}.json',
      body: json.encode({
        'userID': likedUser.id,
        'name': likedUser.name,
        'email': likedUser.email,
        'password': likedUser.password,
      }),
    );

    if(await isMatch(myUser, likedUser) == true) {
      await http.patch(
        '$_baseURL/users/${myOwnUser.id}/matchs/${likedUser.id}.json',
        body: json.encode({
          'userID': likedUser.id,
          'name': likedUser.name,
          'email': likedUser.email,
          'password': likedUser.password,
        }),
      );
      await http.patch(
        '$_baseURL/users/${likedUser.id}/matchs/${myOwnUser.id}.json',
        body: json.encode({
          'userID': myOwnUser.id,
          'name': myOwnUser.name,
          'email': myOwnUser.email,
          'password': myOwnUser.password,
        }),
      );
    }

    notifyListeners();
    fetchUsers();

  }

  Future<bool> isMatch(User myUser, User userLiked) async {
    //Provavel que tenha que criar um if else para caso não há nenhum like ainda.
    ////////////////////////////////////////////////////////////////////////////
    //// O userLiked está sempre vindo com o likes.length em 0, porque ele ta sendo pego do downloadedUsers, e la, em nenhum momento o FetchUsers baixa os likes dele.
    //// Para arruamar isso, você vai poder criar uma response = await http.get do '$_baseURL/users/${userLiked.id}/likes.json' e verificar dai se o response.statusCode == 200 (Status ok)
    //// Se não, apenas retorne, se sim, então você vai criar outra response agora e verificar '$_baseURL/users/${userLiked.id}/likes/${myUser.id}.json' . Isso quer dizer, você vai verificar
    //// dentro do próprio Firebase se dentro dos likes daquele usuário existe um like que de match no seu. Se sim, será match!!
    ////////////////////////////////////////////////////////////////////////////


    final response = await http.get(
        '$_baseURL/users/${userLiked.id}/likes.json'
    );
    print('status code de Response: ');
    print(response.statusCode);
    if (response.statusCode == 200) {
      final response2 = await http.get(
          '$_baseURL/users/${userLiked.id}/likes/${myUser.id}.json'
      );
      print('status code de Response2: ');
      print(response2.statusCode);
      if (response2.statusCode == 200) {
        return true;
      }
      else {
        return false;
      }
    }
    else {
      return false;
    }

    // int myUserTotalLikes = myUser.likes.length;
    // int userLikedTotalLikes = userLiked.likes.length;
    // print('////////////////////////////////////////////////////////////////');
    // print('Total de likes do myUser:');
    // print(myUserTotalLikes);
    // print('Total de likes do userLiked');
    // print(userLikedTotalLikes);
    // print('////////////////////////////////////////////////////////////////');
    // for (int count1 = 0; count1 < myUserTotalLikes; count1++) {
    //   for (int count2 = 0; count2 < userLikedTotalLikes; count2++) {
    //     if(myUser.likes.elementAt(count1) == userLiked.likes.elementAt(count2)) {
    //       return true;
    //     }
    //     print('não foi match!!!!');
    //   }
    // }
    // return false;
  }


  User usersLiked(int i) {
    return myUser.likes.elementAt(i);
  }

  int get usersLikedCount {
    return myUser.likes.length;
  }


}