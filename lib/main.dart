import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'game_ui.dart';

import 'my_game.dart';

main() async {
  // init flame
  await Flame.util.fullScreen();
  await Flame.util.setOrientation(DeviceOrientation.portraitUp);

  Size size = await Flame.util.initialDimensions();
  // todo: load flame images here

  MyGame game = new MyGame();
  // run an app with two base elements
  // 1. the game element, which has flame lifecycle elems like render, update
  // 2. a flutter UI element, which allows you to draw flutter widgets on top of your canvas
  runApp(MaterialApp(
    home: Container(
      constraints: BoxConstraints.expand(), // make the container fill the screen
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          /// Fill the screen with Flame powered canvas
          Positioned.fill(child: game.widget),
          // Positioned.fill(
          //   child: GestureDetector(
          //     onTapDown: game.onTapDown,
          //     child: game.widget,
          //   )
          // ), 
          /// On top of Flame powered canvas, fill the screen with a Flutter powered widget tree 
        ],
      )
    )
  ));
  
  Flame.util.addGestureRecognizer(game.createTapRecognizer());
}