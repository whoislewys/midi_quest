import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flutter/material.dart';
import 'package:midi_quest/screens/battle_screen/note.dart';

/// The track that notes fall down on
class NoteTrack extends Component {
  double xPos;

  double trackHeight = 450.0;
  double trackWidth = 5.0;
  double trackTop = 100.0;

  NoteTrack(double xPos) {
    this.xPos = xPos - trackWidth/2;
  }

  render(Canvas canvas) {
    canvas.drawRect(
        Rect.fromLTWH(xPos, trackTop,  trackWidth, trackHeight),
        Paint()..color = Colors.white
    );
  }

  update(double t) {

  }

}

class FallingNotes extends PositionComponent {
  List<Note> notes;
  Offset rectOffset;
  double width;
  Color color;

  FallingNotes(List<Note> notes, Offset rectOffset, double width, Color color) {
    this.notes = notes;
    this.rectOffset = rectOffset;
    this.width = width;
    this.color = color;
  }

  render(Canvas canvas) {
    canvas.drawRect(
      Rect.fromCircle(center: rectOffset, radius: width),
      Paint()..color = color
    );
  }

  update(double t) {
    rectOffset = new Offset(rectOffset.dx + t, rectOffset.dy);
  }
}