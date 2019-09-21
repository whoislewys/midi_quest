import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class MyGame extends Game {

  MyGame() {
    Flame.util.addGestureRecognizer(createTapRecognizer());
  }

  @override
  void render(Canvas canvas) {
    print('render');
  }

  @override
  void update(double t) {
    print('update');
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
