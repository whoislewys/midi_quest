import 'package:flutter/material.dart';
import 'package:midi_quest/screens/battle_screen/battle_screen_ui.dart';

class _GameUIState extends State<GameUI> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      color: new Color(0xFF000000),
      constraints: BoxConstraints.expand(),
      child: BattleScreenUI(),
    );
  }
}

class GameUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GameUIState();
  }
}