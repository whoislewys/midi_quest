import 'package:flutter/material.dart';

/// some cool hacky shit to be able to use built in flutter widgets on top
///  of your hand drawn Flame canvas
class BattleScreenUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('building');
    return Center(
      child: Container(
        color: const Color(0x220000FF),
      ),
    );
  }
}