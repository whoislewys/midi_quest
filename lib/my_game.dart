import 'dart:io';
import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/components/events/gestures.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'screens/battle_screen/note.dart';
import 'screens/battle_screen/note_loader.dart';

import 'screens/battle_screen/batttle_screen.dart';

/*
1. extend basegame. pass the add function down to the battlescreen
*/
class MyGame extends BaseGame {
  // BattleScreen _battleScreen;
  // constants for bottom row of noteButtons
  Size size;
  
  double noteTouchWidth = 30;
  double middle = 0.0;
  double firstPlaySquareX = 0.0;
  double secondPlaySquareX = 0.0;
  double thirdPlaySquareX = 0.0;
  double playSquaresY = 0.0;

  // components is a set from the BaseGame class. you add to it with the add() method
  Iterable<Tapeable> get _tapeableComponents =>
      components.where((c) => c is Tapeable).cast();
      
  MyGame() {
    // _battleScreen = new BattleScreen();
    // _battleScreen.initBattleScreen();
    print('constructing mygame. size: $size');
    size ??= window.physicalSize / window.devicePixelRatio;
    print('constructed mygame. size: $size');
    middle = size.width/2;
    firstPlaySquareX = middle - size.width * .2;
    secondPlaySquareX = middle; 
    thirdPlaySquareX = middle + size.width * .2;  
    playSquaresY = size.height - (size.height / 4);

    Offset firstRectOffset = new Offset(firstPlaySquareX, playSquaresY);
    add(NoteTouch(firstRectOffset, noteTouchWidth));
    Offset secondRectOffset = new Offset(secondPlaySquareX, playSquaresY);
    add(NoteTouch(secondRectOffset, noteTouchWidth));
    Offset thirdRectOffset = new Offset(thirdPlaySquareX, playSquaresY);
    add(NoteTouch(thirdRectOffset, noteTouchWidth));
    print('tapable components: ${components.where((c) => c is Tapeable).cast()}');
  }

  @override onTapCancel() {
    _tapeableComponents.forEach((c) => c.onTapCancel());
  }

  /// for some reason, the collision resolution in BaseGame (_checkTapOverlap method)
  /// was swallowing onTapDown events for my components
  @override onTapDown(TapDownDetails details) {
    _tapeableComponents.forEach((c) => c.onTapDown(details));
  }

  @override onTapUp(TapUpDetails details) {
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

class NoteTouch extends PositionComponent with Tapeable {
  Offset rectOffset;
  double width;

  NoteTouch(Offset rectOffset, double width) {
    print('constructing notetouch, offset $rectOffset');
    this.rectOffset = rectOffset;
    this.width = width;
  }

  render(Canvas canvas) {
    canvas.drawRect(Rect.fromCircle(center: rectOffset, radius: width), Paint()..color = const Color(0xFF00FF00));
  }


  update(double t) {
  }

  @override
  onTapDown(TapDownDetails details) {
    print('tap down');
    // print('tapped down in notetouch with offset $details');
  }

  @override
  onTapUp(TapUpDetails details) {
    print('tap upppppppppppppp');
    // print('tapped up notetouch with offset $details');
  }

  @override
  onTapCancel() {
    print('tap cancel');
  }
}