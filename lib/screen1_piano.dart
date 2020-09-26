import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';


class Screen1 extends StatelessWidget {

  void playSound(int soundNumber) {
    final player = AudioCache();
    player.play('audios/note$soundNumber.wav');
  }

  Container buildKey({Color color, int soundNumber, String soundName}) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
            width: 110.0,
            height: 110.0,
          child: FlatButton(
            splashColor: Colors.yellow,
            highlightColor: Colors.yellowAccent,
            color: color,
            onPressed: () {
              playSound(soundNumber);

            },
            child: Text('$soundName'),
          ),
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text('Piano'),
        ),
        backgroundColor: Colors.pink,
        body: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column (
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  buildKey(color: Colors.red, soundNumber: 1, soundName: 'Do'),
                  buildKey(color: Colors.red, soundNumber: 2, soundName: 'Re'),
                  buildKey(color: Colors.red, soundNumber: 3, soundName: 'Mi'),
                  buildKey(color: Colors.red, soundNumber: 3, soundName: 'Mi'),
                  buildKey(color: Colors.red, soundNumber: 3, soundName: 'Mi'),
                ],
              ),
              Column (
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  buildKey(color: Colors.green, soundNumber: 4, soundName: 'Fa'),
                  buildKey(color: Colors.green, soundNumber: 5, soundName: 'Sol'),
                  buildKey(color: Colors.green, soundNumber: 6, soundName: 'La'),
                  buildKey(color: Colors.green, soundNumber: 6, soundName: 'La'),
                  buildKey(color: Colors.green, soundNumber: 6, soundName: 'La'),
                ],
              ),
              Column (
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  buildKey(color: Colors.blue, soundNumber: 7, soundName: 'Si'),
                  buildKey(color: Colors.blue, soundNumber: 1, soundName: 'Do2'),
                  buildKey(color: Colors.blue, soundNumber: 2, soundName: 'Re2'),
                  buildKey(color: Colors.blue, soundNumber: 2, soundName: 'Re2'),
                  buildKey(color: Colors.blue, soundNumber: 2, soundName: 'Re2'),
                ],
              )
            ],
          )
        ),
    );
  }
}