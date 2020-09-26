import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';


class Screen3 extends StatelessWidget {

  void playSound(int soundNumber) {
    final player = AudioCache();
    // Cada drum é um som sendo:
    // drum1: Kick
    // drum2: Floortom 1
    // drum3: Floortom 2
    // drum4: Racktom 1
    // drum5: Racktom 2
    // drum6: Racktom 3
    // drum7: Snare
    // drum8: Hi-Hat Close
    // drum9: Hi-Hat Open
    // drum10: Ride
    // drum11: Cymbal 1
    // drum12: Cymbal 2
    // drum13: Cymbal 3
    // drum14: Cymbal 4
    player.play('audios/drum/drum$soundNumber.wav');
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
        title: Text('Drum'),
      ),
      backgroundColor: Colors.pink,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
          child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column (
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      buildKey(color: Colors.red, soundNumber: 13, soundName: 'Cymbal 3'),
                      buildKey(color: Colors.red, soundNumber: 10, soundName: 'Ride'),
                      buildKey(color: Colors.red, soundNumber: 7, soundName: 'Snare'),
                      buildKey(color: Colors.red, soundNumber: 4, soundName: 'Racktom 1'),
                      buildKey(color: Colors.red, soundNumber: 1, soundName: 'Kick'),
                    ],
                  ),
                  Column (
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      buildKey(color: Colors.yellow, soundNumber: 14, soundName: 'Cymbal 4'),
                      buildKey(color: Colors.yellow, soundNumber: 11, soundName: 'Cymbal 1'),
                      buildKey(color: Colors.yellow, soundNumber: 8, soundName: 'Hi-Hat Close'),
                      buildKey(color: Colors.yellow, soundNumber: 5, soundName: 'Racktom 2'),
                      buildKey(color: Colors.yellow, soundNumber: 2, soundName: 'Floortom 1'),
                    ],
                  ),
                  Column (
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      buildKey(color: Colors.blue, soundNumber: 14, soundName: 'Cymbal 4'),
                      buildKey(color: Colors.blue, soundNumber: 12, soundName: 'Cymbal 2'),
                      buildKey(color: Colors.blue, soundNumber: 9, soundName: 'Hi-Hat Open'),
                      buildKey(color: Colors.blue, soundNumber: 6, soundName: 'Racktom 3'),
                      buildKey(color: Colors.blue, soundNumber: 3, soundName: 'Floortom 2'),
                    ],
                  ),
                ],
              )
          ),
        ),
      ),
    );
  }
}