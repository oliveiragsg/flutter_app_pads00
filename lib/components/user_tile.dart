import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_pads00/models/user.dart';
import 'package:like_button/like_button.dart';

class UserTile extends StatelessWidget {
  final User user;
  const UserTile(this.user);

  @override
  Widget build(BuildContext context) {
    final avatar = user.avatarURL==null || user.avatarURL.isEmpty
        ? CircleAvatar(child: Icon(Icons.person))
          : CircleAvatar(backgroundImage: NetworkImage(user.avatarURL));

    return Padding(
      padding: const EdgeInsets.only(left:5.0, top:5.0, right:5.0, bottom: 5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: Colors.black,
              width: 2.0),
          borderRadius: BorderRadius.circular(50.0)
        ),
        child: ListTile(
          leading: avatar,
          title: Text(user.name),
          subtitle: Text(user.email),
          trailing: Container(
            width: 60,
            child: Row(
              children: <Widget>[
                LikeButton(
                  size: 30.0,
                  circleColor:
                  CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
                  bubblesColor: BubblesColor(
                    dotPrimaryColor: Color(0xff33b5e5),
                    dotSecondaryColor: Color(0xff0099cc),
                  ),
                  likeBuilder: (bool isLiked) {
                    return Icon(
                      Icons.favorite,
                      color: isLiked ? Colors.red : Colors.redAccent,
                      size: 30.0,
                    );
                  },
                  likeCount: 0,
                  countBuilder: (int count, bool isLiked, String text) {
                    var color = isLiked ? Colors.deepPurpleAccent : Colors.grey;
                    Widget result;
                    if (count == 0) {
                      result = Text(
                        "love",
                        style: TextStyle(color: color),
                      );
                    } else
                      result = Text(
                        text,
                        style: TextStyle(color: color),
                      );
                    return result;
                  },
                  onTap:
                  onLikeButtonTapped,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<bool> onLikeButtonTapped(bool isLiked) async{
  return !isLiked;
}