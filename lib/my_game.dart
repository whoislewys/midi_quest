import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'screens/battle_screen/batttle_screen.dart';

class MyGame extends Game {

  BattleScreen _battleScreen;

  MyGame() {
    Flame.util.addGestureRecognizer(createTapRecognizer());
    _battleScreen = new BattleScreen();
  }

  @override
  void render(Canvas canvas) {
    _battleScreen.render();
  }

  @override
  void update(double t) {
    _battleScreen.update();
  }

  @override
  void resize(Size size) {
    print('resize');
  }

  TapGestureRecognizer createTapRecognizer() {
    return new TapGestureRecognizer()
      ..onTapDown = (TapDownDetails details) {
        print(details.globalPosition);
        // level.handleTap(details.globalPosition);
      };
  }
}
