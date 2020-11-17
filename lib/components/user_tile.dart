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

    return Row(
      children: [
        Container(
          width: 290,
          height: 500,
          child: Padding(
            padding: const EdgeInsets.only(left:5.0, top:5.0, right:5.0, bottom: 5.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: Colors.black,
                    width: 2.0),
                borderRadius: BorderRadius.circular(50.0)
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(500.0),
                      child: Image.asset('assets/images/profilePic.jpg',
                          width: 240.0,
                          height: 240.0,
                          fit: BoxFit.cover),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text('Nome', //Name
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30 ,top: 145),
                    child: Row(
                      children: [
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
                              Icons.backspace,
                              color: isLiked ? Colors.redAccent : Colors.pinkAccent,
                              size: 30.0,
                            );
                          },
                          likeCount: 0,
                          countBuilder: (int count, bool isLiked, String text) {
                            var color = isLiked ? Colors.deepPurpleAccent : Colors.grey;
                            Widget result;
                            if (count == 0) {
                              result = Text(
                                "Ignore",
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
                        Padding(
                          padding: const EdgeInsets.only(left: 90),
                          child: LikeButton(
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
                                color: isLiked ? Colors.red : Colors.pinkAccent,
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
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Future<bool> onLikeButtonTapped(bool isLiked) async{
  return !isLiked;
}