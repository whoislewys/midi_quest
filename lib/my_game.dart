import 'dart:ui';

import 'package:flame/components/events/gestures.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'screens/battle_screen/note.dart';
import 'screens/battle_screen/note_loader.dart';

import 'screens/battle_screen/batttle_screen.dart';
import 'screens/battle_screen/note_button.dart';

/*
1. extend basegame. pass the add function down to the battlescreen
*/
class MyGame extends BaseGame {
  // BattleScreen _battleScreen;
  // constants for bottom row of noteButtons
  Size size;
  
  double screenMiddle = 0.0;

  double noteTouchWidth = 30;
  double playSquaresY = 0.0;

  // components is a set from the BaseGame class. you add to it with the add() method
  Iterable<Tapeable> get _tapeableComponents =>
      components.where((c) => c is Tapeable).cast();
      
  MyGame() {
    print('constructing mygame. size: $size');
    size ??= window.physicalSize / window.devicePixelRatio;
    print('constructed mygame. size: $size');
    screenMiddle = size.width/2;
    playSquaresY = size.height - (size.height / 4);

    // _battleScreen = new BattleScreen();
    // _battleScreen.initBattleScreen();

    _renderNoteButtonRow();

    // print('tappable components: ${components.where((c) => c is Tapeable).cast()}');
  }

  /// Adds bottom row of note buttons to baseGame component list
  void _renderNoteButtonRow() {
    double firstNoteButtonX = screenMiddle - size.width * .2;
    Offset firstRectOffset = new Offset(firstNoteButtonX, playSquaresY);
    Color firstNoteButtonColor = const Color(0xFF990000);

    double secondNoteButtonX = screenMiddle; 
    Offset secondRectOffset = new Offset(secondNoteButtonX, playSquaresY);
    Color secondNoteButtonColor = const Color(0xFF009900);

    double thirdNoteButtonX = screenMiddle + size.width * .2;  
    Offset thirdRectOffset = new Offset(thirdNoteButtonX, playSquaresY);
    Color thirdNoteButtonColor = const Color(0xFF000099);

    add(NoteButton(firstRectOffset, noteTouchWidth, firstNoteButtonColor));
    add(NoteButton(secondRectOffset, noteTouchWidth, secondNoteButtonColor));
    add(NoteButton(thirdRectOffset, noteTouchWidth, thirdNoteButtonColor));
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