import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';


class Screen1 extends StatelessWidget {

  void playSound(int soundNumber) {
    final player = AudioCache();
    // Começa do C3 sendo o piano1 e vai até o D5 sendo o piano27. Ascende cromaticamente, ex: C3, C#3, D3, D#3....
    player.play('audios/piano/piano$soundNumber.wav');
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
          child: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column (
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    buildKey(color: Colors.red, soundNumber: 25, soundName: 'C5'),
                    buildKey(color: Colors.red, soundNumber: 22, soundName: 'A4'),
                    buildKey(color: Colors.red, soundNumber: 19, soundName: 'F#4'),
                    buildKey(color: Colors.red, soundNumber: 16, soundName: 'D#4'),
                    buildKey(color: Colors.red, soundNumber: 13, soundName: 'C4'),
                    buildKey(color: Colors.red, soundNumber: 10, soundName: 'A3'),
                    buildKey(color: Colors.red, soundNumber: 7, soundName: 'F#3'),
                    buildKey(color: Colors.red, soundNumber: 4, soundName: 'D#3'),
                    buildKey(color: Colors.red, soundNumber: 1, soundName: 'C3'),
                  ],
                ),
                Column (
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    buildKey(color: Colors.green, soundNumber: 26, soundName: 'C#5'),
                    buildKey(color: Colors.green, soundNumber: 23, soundName: 'A#4'),
                    buildKey(color: Colors.green, soundNumber: 20, soundName: 'G4'),
                    buildKey(color: Colors.green, soundNumber: 17, soundName: 'E4'),
                    buildKey(color: Colors.green, soundNumber: 14, soundName: 'C#4'),
                    buildKey(color: Colors.green, soundNumber: 11, soundName: 'A#3'),
                    buildKey(color: Colors.green, soundNumber: 8, soundName: 'G3'),
                    buildKey(color: Colors.green, soundNumber: 5, soundName: 'E3'),
                    buildKey(color: Colors.green, soundNumber: 2, soundName: 'C#3'),
                  ],
                ),
                Column (
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    buildKey(color: Colors.blue, soundNumber: 27, soundName: 'D5'),
                    buildKey(color: Colors.blue, soundNumber: 24, soundName: 'B4'),
                    buildKey(color: Colors.blue, soundNumber: 21, soundName: 'G#4'),
                    buildKey(color: Colors.blue, soundNumber: 18, soundName: 'F4'),
                    buildKey(color: Colors.blue, soundNumber: 15, soundName: 'D4'),
                    buildKey(color: Colors.blue, soundNumber: 12, soundName: 'B3'),
                    buildKey(color: Colors.blue, soundNumber: 9, soundName: 'G#3'),
                    buildKey(color: Colors.blue, soundNumber: 6, soundName: 'F3'),
                    buildKey(color: Colors.blue, soundNumber: 3, soundName: 'D3'),
                  ],
                )
              ],
            ),
          )
        ),
    );
  }
}