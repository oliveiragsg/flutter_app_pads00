import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_pads00/data/games.dart';
import 'package:flutter_app_pads00/data/myUser.dart';
import 'package:flutter_app_pads00/models/game.dart';
import 'package:flutter_app_pads00/models/user.dart';
import 'package:http/http.dart' as http;

class Users with ChangeNotifier {
  static const _baseURL = 'https://flutter-app-pads00.firebaseio.com/';
  final dbUsers = FirebaseDatabase.instance.reference().child('users');
  final dbUsers2 = FirebaseFirestore.instance.collection('users');
  final dbGames = FirebaseDatabase.instance.reference().child('games');
  final dbGames2 = FirebaseFirestore.instance.collection('games');
  List<User> loadedUsers = [];
  List<User> loadedUsers2 = [];
  List<User> loadedUsersWithAfinity = [];


  Users() {
    fetchUsers();
  }

  Future<void> putDB(User user, String userID) async {
    // dbUsers2.add({
    //   "name": user.name,
    //   "email": user.email,
    //   "avatarURL": user.avatarURL,
    //   "password": user.password,
    // });
    await dbUsers2.doc(userID).set({
      "name": user.name,
      "email": user.email,
      "avatarURL": user.avatarURL,
      "password": user.password,
    });
    myUser = user;
    await fetchUsers();
    notifyListeners();
    // dbUsers.child(userID).set({
    //   "name": user.name,
    //   "email": user.email,
    //   "avatarURL": user.avatarURL,
    //   "password": user.password,
    // });
    // fetchUsers();
    // notifyListeners();
  }


  //Feito a partir deste tutorial: https://medium.com/flutterdevs/http-request-dcc13e885985
  Future <void> fetchUsers() async {
    print("URL IMAGE :::::::::::::::::::::::::::::::::::::::");
    print(myUser.avatarURL);

    final List<User> downloadedUsers2 = [];
    print("................................Teste de dbUsers2 começo");
    await dbUsers2.get().then((value) =>
    value.docs.forEach((element) {
      //print(element.data());
      downloadedUsers2.add(
        User(
            id: element.id, 
            name: element.get("name").toString(),
            email: element.get("email").toString(),
            password: element.get("password").toString(),
            //avatarURL: element.get("avatarURL").toString(),
        )
      );
    }));
    loadedUsers2 = downloadedUsers2;
    print(loadedUsers2.first.email);
    print("Teste de dbUsers2 Fim...................................");

    //ANTIGO RETIRAR
    // final response = await http.get(
    //     'https://flutter-app-pads00.firebaseio.com/users.json'
    // );
    // final extractedData = json.decode(response.body) as Map<String, dynamic>;
    // final List<User> downloadedUsers = [];
    // extractedData.forEach((userID, userData) {
    //   downloadedUsers.add(
    //     User(
    //       id: userID,
    //       name: userData['name'],
    //       email: userData['email'],
    //       password: userData['password'],
    //       avatarURL: userData['avatarURL'],
    //     ),
    //   );
    // });
    // loadedUsers = downloadedUsers;
    //ANTIGO RETIRAR



    //Carregar os games para a lista local do myUser

    final List<Game> listGames = [];
    print(listGames.length);
    print(myUser.id);
    var userGames = await dbUsers2.doc(myUser.id).collection('games').get();
    if(myUser.games.isNotEmpty) {
         myUser.games.clear();
       }
    if(userGames != null) {
      userGames.docs.forEach((game) {
        if(myUser.games.contains(game)) {
          return;
        }
        else{
          myUser.games.add(
              Game(
                id: game.id,
                name: game.get("name").toString(),
              )
          );
        }
        // listGames.add(
        //     Game(
        //       id: game.id,
        //       name: game.get("name").toString(),
        //       )
        //     );
        });
      // if(myUser.games.isNotEmpty) {
      //   myUser.games.clear();
      // }
      // int totalGames = listGames.length;
      // for (int count = 0; count < totalGames; count++) {
      //   myUser.games.add(listGames.elementAt(count));
      // }
      // print(listGames.length);
      }



    //ANTIGO RETIRAR
    // final response4 = await http.get(
    //     '$_baseURL/users/${myUser.id}/games.json'
    // );
    // if (response4.statusCode == 200) {
    //   final extractedData4 = json.decode(response4.body) as Map<String,
    //       dynamic>;
    //   final List<Game> listGames = [];
    //   if (extractedData4 == null) {
    //     return;
    //   }
    //   else {
    //     extractedData4.forEach((gameID, gameData) {
    //       listGames.add(
    //         Game(
    //           id: gameID,
    //           name: gameData['name'],
    //         ),
    //       );
    //     });
    //     if(myUser.games.isNotEmpty) {
    //       myUser.games.clear();
    //     }
    //     int totalGames = listGames.length;
    //     for (int count = 0; count < totalGames; count++) {
    //       myUser.games.add(listGames.elementAt(count));
    //     }
    //   }
    // }
    // else {
    //   return;
    // }
    //ANTIGO RETIRAR

    //Carregar os likes para a lista local do myUser

    final List<User> listUserLikes = [];
    print(listUserLikes.length);
    var userLikes = await dbUsers2.doc(myUser.id).collection('likes').get();
    if(userLikes != null) {
      userLikes.docs.forEach((user) {
        if(myUser.likes.contains(byID(user.id))) {
          return;
        }
        else {
          myUser.likes.add(byID((user.id)));
        }
        //listUserLikes.add(byID(user.id));
      });
      // if(myUser.likes.isNotEmpty) {
      //   myUser.likes.clear();
      // }
      // int totalLikes = listUserLikes.length;
      // for (int count = 0; count < totalLikes; count++) {
      //   myUser.likes.add(listUserLikes.elementAt(count));
      // }
    }


    //ANTIGO RETIRAR
    // final response2 = await http.get(
    //     '$_baseURL/users/${myUser.id}/likes.json'
    // );
    // if (response2.statusCode == 200) {
    //   final extractedData2 = json.decode(response2.body) as Map<String,
    //       dynamic>;
    //   final List<User> listUsers = [];
    //   if (extractedData2 == null) {
    //     return;
    //   }
    //   else {
    //     extractedData2.forEach((userID, userData) {
    //       listUsers.add(
    //         byID(userID),
    //       );
    //     });
    //     myUser.likes.clear();
    //     int totalUsers = listUsers.length;
    //     for (int count = 0; count < totalUsers; count++) {
    //       myUser.likes.add(listUsers.elementAt(count));
    //     }
    //   }
    // }
    // else {
    //   return;
    // }
    //ANTIGO RETIRAR

    //Carregar os matchs para a lista local do myUser
    final List<User> listUserMatchs = [];
    print(listUserMatchs.length);
    var userMatchs = await dbUsers2.doc(myUser.id).collection('matchs').get();
    if(userMatchs != null) {
      userMatchs.docs.forEach((user) {
        if(myUser.matchs.contains(byID(user.id))) {
          return;
        }
        else {
          myUser.matchs.add(byID((user.id)));
        }
      });
    }


    //ANTIGO RETIRAR
    // final response3 = await http.get(
    //     '$_baseURL/users/${myUser.id}/matchs.json'
    // );
    // if (response3.statusCode == 200) {
    //   final extractedData3 = json.decode(response3.body) as Map<String,
    //       dynamic>;
    //   final List<User> listMatchs = [];
    //   if (extractedData3 == null) {
    //     return;
    //   }
    //   else {
    //     extractedData3.forEach((userID, userData) {
    //       listMatchs.add(
    //         byID(userID),
    //       );
    //     });
    //     myUser.matchs.clear();
    //     int totalMatchs = listMatchs.length;
    //     for (int count = 0; count < totalMatchs; count++) {
    //       myUser.matchs.add(listMatchs.elementAt(count));
    //     }
    //   }
    // }
    //ANTIGO RETIRAR

    notifyListeners();
  }

  List<User> get all {
    return [...loadedUsers2];
    //return [...loadedUsers];
  }

  int get count {
    return loadedUsers2.length;
    //return loadedUsers.length;
  }

  User byID(String id) {
    int totalSize = loadedUsers2.length;
    for (int count = 0; count < totalSize; count++) {
      if (loadedUsers2.elementAt(count).id == id) {
        return loadedUsers2.elementAt(count);
      }
    }
    return null;


    //ANTIGO RETIRAR
    // int totalSize = loadedUsers.length;
    // for (int count = 0; count < totalSize; count++) {
    //   if (loadedUsers
    //       .elementAt(count)
    //       .id == id) {
    //     return loadedUsers.elementAt(count);
    //   }
    // }
    // return null;
    //ANTIGO RETIRAR
  }

  User byIndex(int i) {
    return loadedUsers2.elementAt(i);
    //return loadedUsers.elementAt(i);
  }

  Future<User> byEmail(String email) async {
    await fetchUsers();
    int totalSize = loadedUsers2.length;
    for (int count = 0; count < totalSize; count++) {
      if (loadedUsers2.elementAt(count).email == email) {
        return loadedUsers2.elementAt(count);
      }
    }
    return null;

    //ANTIGO RETIRAR
    // await fetchUsers();
    // int totalSize = loadedUsers.length;
    // for (int count = 0; count < totalSize; count++) {
    //   if (loadedUsers
    //       .elementAt(count)
    //       .email == email) {
    //     return loadedUsers.elementAt(count);
    //   }
    // }
    // return null;
    //ANTIGO RETIRAR
  }

  //ANTIGO RETIRAR
  Future<void> put(User user) async {
    if (user == null) {
      return;
    }
    if (user.id != null && user.id
        .trim()
        .isNotEmpty) {
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
      final response = await http.post(
        '$_baseURL/users/${user.id}.json',
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
  //ANTIGO RETIRAR

  void remove(User user) {
    if (user != null && user.id != null) {
      dbUsers2.doc(user.id).delete();
      http.delete(
        '$_baseURL/users/${user.id}.json',
      );
      loadedUsers2.remove(user);
      notifyListeners();
    }

    //ANTIGO RETIRAR
    // if (user != null && user.id != null) {
    //   http.delete(
    //     '$_baseURL/users/${user.id}.json',
    //   );
    //   loadedUsers.remove(user);
    //   notifyListeners();
    // }
    //ANTIGO RETIRAR
  }

  void like(User myOwnUser, User likedUser) async {


    int totalSize = myOwnUser.likes.length;


    print(totalSize);
    for (int count = 0; count < totalSize; count++) {
      if (myOwnUser.likes
          .elementAt(count)
          .id == likedUser.id) {
        return;
      }
    }

      await dbUsers2.doc(myOwnUser.id).collection('likes').doc(likedUser.id).set({
        'userID': likedUser.id,
        'name': likedUser.name,
        'email': likedUser.email,
        'password': likedUser.password,
      });

      if (await isMatch(myUser, likedUser) == true) {
        await dbUsers2.doc(myOwnUser.id).collection('matchs').doc(likedUser.id).set({
          'userID': likedUser.id,
          'name': likedUser.name,
          'email': likedUser.email,
          'password': likedUser.password,
        });
        await dbUsers2.doc(likedUser.id).collection('matchs').doc(myOwnUser.id).set({
          'userID': myOwnUser.id,
          'name': myOwnUser.name,
          'email': myOwnUser.email,
          'password': myOwnUser.password,
        });
      }
      fetchUsers();


      //ANTIGO RETIRAR
      // int totalSize = myOwnUser.likes.length;
      //
      // for (int count = 0; count < totalSize; count++) {
      //   if (myOwnUser.likes.elementAt(count).id == likedUser.id) {
      //     return;
      //   }
      // }
      //
      // await http.patch(
      //   '$_baseURL/users/${myOwnUser.id}/likes/${likedUser.id}.json',
      //   body: json.encode({
      //     'userID': likedUser.id,
      //     'name': likedUser.name,
      //     'email': likedUser.email,
      //     'password': likedUser.password,
      //   }),
      // );
      //
      // if (await isMatch(myUser, likedUser) == true) {
      //   await http.patch(
      //     '$_baseURL/users/${myOwnUser.id}/matchs/${likedUser.id}.json',
      //     body: json.encode({
      //       'userID': likedUser.id,
      //       'name': likedUser.name,
      //       'email': likedUser.email,
      //       'password': likedUser.password,
      //     }),
      //   );
      //   await http.patch(
      //     '$_baseURL/users/${likedUser.id}/matchs/${myOwnUser.id}.json',
      //     body: json.encode({
      //       'userID': myOwnUser.id,
      //       'name': myOwnUser.name,
      //       'email': myOwnUser.email,
      //       'password': myOwnUser.password,
      //     }),
      //   );
      // }
      //
      // fetchUsers();
      //ANTIGO RETIRAR
  }


  Future<bool> isMatch(User myUser, User likedUser) async {
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    //Eu apenas consegui verificar se ja deu match verificando o response.body.lenght./////////////////////
    //Porque sempre que ele estava vazio, ele tinha um lenght de 4.////////////////////////////////////////
    //Outras formas não funcionaram, ex: IsEmpty, etc./////////////////////////////////////////////////////
    //Eu tentei antes com o response.statuscode == 200, porém ele sempre dava 200, não importa a situação//
    //Talvez eu tenha que revisar o FetchUsers que usa essa mesma função de statusCode/////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////


    var isMatch = await dbUsers2.doc(likedUser.id).collection('likes').doc(myUser.id).get();

    print("ISMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAATCH");
    print(isMatch.exists);

    if(isMatch.exists) {
      return true;
    }
    else {
      return false;
    }

    //ANTIGO RETIRAR
    // final response = await http.get(
    //   '$_baseURL/users/${likedUser.id}/likes.json',
    // );
    // if (response.body.length != 4) {
    //   final response2 = await http.get(
    //       '$_baseURL/users/${likedUser.id}/likes/${myUser.id}.json'
    //   );
    //   if (response2.body.length != 4) {
    //     return true;
    //   }
    //   else {
    //     return false;
    //   }
    // }
    // else {
    //   return false;
    // }
    //ANTIGO RETIRAR
  }


  User usersLiked(int i) {
    return myUser.likes.elementAt(i);
  }

  User usersMatched(int i) {
    return myUser.matchs.elementAt(i);
  }

  int get usersLikedCount {
    return myUser.likes.length;
  }

  int get matchsCount {
    return myUser.matchs.length;
  }


  // Games
  void addGame(User myOwnUser, Game addedGame) async {

    var dbUserAddedGame = await dbUsers2.doc(myOwnUser.id).collection('games').doc(addedGame.id).get();
    if(!dbUserAddedGame.exists) {
      //Add the game to the user games database.
      dbUsers2.doc(myOwnUser.id).collection('games').doc(addedGame.id).set(
          {"name": addedGame.name});
      //Add the game to the local user games database.
      myOwnUser.games.add(addedGame);
      //Add the user to the game users database.
      dbGames2.doc(addedGame.id).collection("users").doc(myOwnUser.id).set({
        "email": myOwnUser.email,
      });
    }
    else {
      //Remove the game from the user games database
      dbUsers2.doc(myOwnUser.id).collection("games").doc(addedGame.id).delete();
      //Remove the game from the local user games database.
      myOwnUser.games.remove(addedGame);
      //Remove the user from the game users database.
      dbGames2.doc(addedGame.id).collection("users").doc(myOwnUser.id).delete();
    }
    notifyListeners();
    fetchUsers();


    //ANTIGO RETIRAR
    //Database for the games of the current user.
    // final dbUserGames = FirebaseDatabase.instance.reference().child(
    //     'users/' + myUser.id + '/games/');
    //
    // //Database for the users of the current game.
    // final dbGameUsers = FirebaseDatabase.instance.reference().child(
    //     'games/' + addedGame.id + '/users/');
    //
    // //Snapshot from the dbUserGames used to check if the game is already added to the user games database or not.
    // DataSnapshot snapshot = await dbUserGames.child(addedGame.id).once();
    // if (snapshot.value == null) {
    //   //Add the game to the user games database.
    //   dbUserGames.child(addedGame.id).set({
    //     "name": addedGame.name,
    //   });
    //   //Add the game to the local user games database.
    //   myOwnUser.games.add(Game(id: addedGame.id, name: addedGame.name));
    //   //Add the user to the game users database.
    //   dbGameUsers.child(myOwnUser.id).set({
    //     "email": myOwnUser.email,
    //   });
    // }
    // else {
    //   //Remove the game from the user games database.
    //   dbUserGames.child(addedGame.id).remove();
    //   //Remove the game from the local user games database.
    //   myOwnUser.games.remove(Game(id: addedGame.id, name: addedGame.name));
    //   //Remove the user from the game users database.
    //   dbGameUsers.child(myOwnUser.id).remove();
    // }
    //
    // notifyListeners();
    // fetchUsers();
    //ANTIGO RETIRAR
  }

  Future<bool> alreadyAddedDB(User myUser, Game game) async {
    var dbUserGames2 = await dbUsers2.doc(myUser.id).collection('games').get();

    if(dbUserGames2 != null) {
      return Future<bool>.value(false);
    }
    else {
      return Future<bool>.value(true);
    }


    //ANTIGO RETIRAR
    // final dbUserGames = FirebaseDatabase.instance.reference().child(
    //     'users/' + myUser.id + '/games/');
    //
    // DataSnapshot snapshot = await dbUserGames.child(game.id).once();
    // if (snapshot.value == null) {
    //   return Future<bool>.value(false);
    // }
    // else {
    //   return Future<bool>.value(true);
    // }
    //ANTIGO RETIRAR
  }

  bool alreadyAdded(User myUser, Game game) {
    if (myUser.games != null) {
      int totalGames = myUser.games.length;

      for (int i = 0; i < totalGames; i++) {
        if (game.id == myUser.games.elementAt(i).id) {
          return true;
        }
      }
      return false;
    }
    else {
      return null;
    }
  }

}