import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';


class Screen2 extends StatelessWidget {

  void playSound(int soundNumber) {
    final player = AudioCache();
    player.play('audios/note$soundNumber.wav');
  }

  Expanded buildKey({Color color, int soundNumber, String soundName}) {
    return Expanded(
        child: FlatButton(
          color: color,
          onPressed: () {
            playSound(soundNumber);
          },
          child: Text('$soundName'),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Xylophone'),
      ),
      backgroundColor: Colors.pink,
      body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildKey(color: Colors.red, soundNumber: 1, soundName: 'Do'),
              buildKey(color: Colors.blue, soundNumber: 2, soundName: 'Re'),
              buildKey(color: Colors.yellow, soundNumber: 3, soundName: 'Mi'),
              buildKey(color: Colors.purple, soundNumber: 4, soundName: 'Fa'),
              buildKey(color: Colors.pink, soundNumber: 5, soundName: 'Sol'),
              buildKey(color: Colors.green, soundNumber: 6, soundName: 'La'),
              buildKey(color: Colors.brown, soundNumber: 7, soundName: 'Si'),
            ],
          )
      ),
    );
  }
}