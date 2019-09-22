import 'dart:io';
import 'dart:ui';
import 'dart:async';
import 'package:flame/components/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'note.dart';
import 'note_loader.dart';

class BattleScreen {
  List<Note> _firstTrackNotes = [];
  List<Note> _secondTrackNotes = [];
  List<Note> _thirdTrackNotes = [];

  double firstPlaySquareX = 0.0;
  double secondPlaySquareX = 0.0;
  double thirdPlaySquareX = 0.0;
  double playSquaresY = 0.0;

  void initBattleScreen() async {
    // instead of loading each track from a sep file, could also do a single multitrack file
    // doesnt really matter tbh. just wanna flex how my brain thinks of many possible solutions
    ByteData trackOneMidiBytes = await rootBundle.load('assets/songs/test_song/midi/test_song_C3.MID');
    List<Note> firstTrackNotes = loadNotesForTrackFromMidi(trackOneMidiBytes); 
    _firstTrackNotes = firstTrackNotes;
  }

  /// Flame Lifecycle Methods
  void resize(Size size) {
    double middle = size.width/2;
    firstPlaySquareX = middle - size.width * .2;
    secondPlaySquareX = middle; 
    thirdPlaySquareX = middle + size.width * .2;
  
    playSquaresY = size.height - (size.height / 4);
  }

  render(Canvas canvas) {
    double width = 20;

    // Offset firstRectOffset = new Offset(firstPlaySquareX, playSquaresY);
    // canvas.drawRect(Rect.fromCircle(center: firstRectOffset, radius: width), Paint()..color = const Color(0xFFFF00FF));

    // Offset secondRectOffset = new Offset(secondPlaySquareX, playSquaresY);
    // canvas.drawRect(Rect.fromCircle(center: secondRectOffset, radius: width), Paint()..color = const Color(0xFFFF00FF));

    // Offset thirdRectOffset = new Offset(thirdPlaySquareX, playSquaresY);
    // canvas.drawRect(Rect.fromCircle(center: thirdRectOffset, radius: width), Paint()..color = const Color(0xFFFF00FF));
  }

  update() {
    // print('BattleScreen update');
  }
}