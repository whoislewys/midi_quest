import 'dart:ui';

import 'package:flame/components/events/gestures.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'screens/battle_screen/batttle_screen.dart';
import 'screens/battle_screen/note_button.dart';

/*
1. extend basegame. pass the add function down to the battlescreen
*/
class MyGame extends BaseGame {
  BattleScreen _battleScreen;

  /// `components` is a set from the BaseGame class that gets rendered, updated every game tick.
  /// you add to it with the add() method
  Iterable<Tapeable> get _tapeableComponents =>
      components.where((c) => c is Tapeable).cast();
      
  MyGame() {
    _battleScreen = new BattleScreen(add);
    _battleScreen.initBattleScreen();
  }

  @override
  onTapCancel() {
    _tapeableComponents.forEach((c) => c.onTapCancel());
  }

  /// for some reason, the collision resolution in BaseGame's onTapDown (_checkTapOverlap method)
  /// was swallowing onTapDown events for my components. override to fix that
  @override
  onTapDown(TapDownDetails details) {
    _tapeableComponents.forEach((c) => c.onTapDown(details));
  }

  @override
  onTapUp(TapUpDetails details) {
    _tapeableComponents.forEach((c) => c.onTapUp(details));
  }

  /// a TapGestureRecognizer is created and attached on Game instantiation for you
  /// if you want more advanced gesture recognizers, you have to make them yourself as below
  /// To use them, call them in `main.dart`
  // TapGestureRecognizer createTapRecognizer() {
  //   // might be able to remove tap gesture recognizer
  //   // looks like base game class attaches one on game attach and initial build
  //   print('created tap recognizer');
  //   return new TapGestureRecognizer()
  //   ..onTapUp = super.onTapUp
  //   ..onTapCancel = super.onTapCancel
  //   ..onTapDown = super.onTapDown;
  // }
}
