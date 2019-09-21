import 'package:flame/flame.dart';
import 'package:flutter/widgets.dart';

import 'my_game.dart';

main() async {
  Flame.initializeWidget();
  runApp(new MyGame().widget);
}