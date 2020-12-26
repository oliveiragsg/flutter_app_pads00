import 'package:flutter/material.dart';
import 'package:flutter_app_pads00/data/myUser.dart';
import 'package:flutter_app_pads00/models/game.dart';
import 'package:flutter_app_pads00/models/user.dart';
import 'package:flutter_app_pads00/provider/users.dart';
import 'package:like_button/like_button.dart';


class GameTile extends StatelessWidget {
  final Game game;
  final User user;
  const GameTile(this.game, this.user);

  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: LikeButton(
          isLiked: Users().alreadyAdded(user, game),
          size: 35.0,
          circleColor:
          CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
          bubblesColor: BubblesColor(
            dotPrimaryColor: Color(0xff33b5e5),
            dotSecondaryColor: Color(0xff0099cc),
          ),
          likeBuilder: (bool isLiked) {
            return Icon(
              Icons.favorite,
              color: isLiked ? Colors.redAccent : Colors.pinkAccent,
              size: 30.0,
            );
          },
          likeCount: 0,
          countBuilder: (int count, bool isLiked, String text) {
            var color = isLiked ? Colors.deepPurpleAccent : Colors.black;
            Widget result;
            if (count == 0) {
              result = Text(
                game.name,
                style: TextStyle(color: color),
              );
            } else
              result = Text(
                game.name,
                style: TextStyle(color: color),
              );
            return result;
          },
          onTap: (isLiked) {
            return add(isLiked, myUser, game);
          },
        ),
      ),
    );
  }
}


Future <bool> add(status, User myOwnUser, Game addedGame) async {
  Users().addGame(myOwnUser, addedGame);
  return Future.value(!status);
}

Future<bool> isAdded(User myUser, Game game) async {
  await Users().alreadyAddedDB(myUser, game).then((value) {
    print('função de isAdded no GameTile !!!!!!!!!!!!!!!!!!!');
    print(value);
    if(value == true) {
      return value;
    }
    else {
      return value;
    }
  });
  return false;
}

