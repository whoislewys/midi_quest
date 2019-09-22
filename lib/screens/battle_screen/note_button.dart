import 'package:flame/components/component.dart';
import 'package:flame/components/events/gestures.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// The buttons the user can press to play notes
class NoteButton extends PositionComponent with Tapeable {
  Offset rectOffset;
  double width;
  Color color;

  NoteButton(Offset rectOffset, double width, Color color) {
    // TODO: make these buttons pretty.
    // 1. i could instead of drawing rects shit, use a flutter button in the GameUI tree
    // they could be aligned in the same way i align these (relative to window)
    // OR, keep the drawing logic here, and draw a sprite instead of a plain ol rect
    // 2. tap down could switch to a down press sprite
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