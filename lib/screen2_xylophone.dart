import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';


class Screen2 extends StatelessWidget {

  void playSound(int soundNumber) {
    final player = AudioCache();
    // Começa do C3 sendo o xylophone1 e vai até o C4 sendo o xylophone13. Ascende cromaticamente, ex: C3, C#3, D3, D#3....
    player.play('audios/xylophone/xylophone$soundNumber.wav');
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
              buildKey(color: Colors.red, soundNumber: 1, soundName: 'C'),
              buildKey(color: Colors.blue, soundNumber: 2, soundName: 'C#'),
              buildKey(color: Colors.yellow, soundNumber: 3, soundName: 'D'),
              buildKey(color: Colors.purple, soundNumber: 4, soundName: 'D#'),
              buildKey(color: Colors.pink, soundNumber: 5, soundName: 'E'),
              buildKey(color: Colors.green, soundNumber: 6, soundName: 'F'),
              buildKey(color: Colors.redAccent, soundNumber: 7, soundName: 'F#'),
              buildKey(color: Colors.blueAccent, soundNumber: 8, soundName: 'G'),
              buildKey(color: Colors.yellowAccent, soundNumber: 9, soundName: 'G#'),
              buildKey(color: Colors.purpleAccent, soundNumber: 10, soundName: 'A'),
              buildKey(color: Colors.pinkAccent, soundNumber: 11, soundName: 'A#'),
              buildKey(color: Colors.greenAccent, soundNumber: 12, soundName: 'B'),
              buildKey(color: Colors.deepOrange, soundNumber: 13, soundName: 'C'),
            ],
          )
      ),
    );
  }
}