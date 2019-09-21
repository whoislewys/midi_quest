import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'my_game.dart';

main() async {
// MyGame game = new MyGame();

Flame.initializeWidget();

//   runApp(MaterialApp(
//       home: Scaffold(
//           body: Container(
//     child: GameWrapper(game),
//   ))));

  // could also just do this
  runApp(new MyGame().widget);
}

// class GameWrapper extends StatelessWidget {
//   final MyGame game;
//   GameWrapper(this.game);

//   @override
//   Widget build(BuildContext context) {
//     return game.widget;
//   }
// }