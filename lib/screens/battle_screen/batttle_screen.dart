import 'dart:io';
import 'dart:ui';
import 'dart:async';
import 'package:flame/components/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'note.dart';
import 'note_button.dart';
import 'note_loader.dart';

class BattleScreen {
  void Function(Component) add;
  
  List<Note> _firstTrackNotes = [];
  // List<Note> _secondTrackNotes = [];
  // List<Note> _thirdTrackNotes = [];

  // constants for bottom row of noteButtons
  Size size;
  
  double screenMiddle = 0.0;
  double noteButtonsY = 0.0;
  double noteButtonWidth = 30;

  /// Constructs a new BattleScreen
  /// @param add The function from BaseGame to add components to the global set of components to render
  /// Renders what the player is about to play
  BattleScreen(void Function(Component) add) {
    // init members
    size ??= window.physicalSize / window.devicePixelRatio;
    screenMiddle = size.width/2;
    noteButtonsY = size.height - (size.height / 4);
    this.add = add;

    // start rendering
    _renderNoteButtonRow();
  }

  /// Loads notes for the song that player is about to play
  void initBattleScreen() async {
    // Load notes for the current song
    ByteData trackOneMidiBytes = await rootBundle.load('assets/songs/test_song/midi/test_song_C3.MID');
    List<Note> firstTrackNotes = loadNotesForTrackFromMidi(trackOneMidiBytes); 
    _firstTrackNotes = firstTrackNotes;

    // TODO: load the rest of the tracks once the first one is working
    // ByteData trackTwoMidiBytes = await rootBundle.load('assets/songs/test_song/midi/test_song_Db3.MID');
    // List<Note> secondTrackNotes = loadNotesForTrackFromMidi(trackOneMidiBytes); 
    // _secondTrackNotes = firstTrackNotes;

    // ByteData trackThreeMidiBytes = await rootBundle.load('assets/songs/test_song/midi/test_song_D3.MID');
    // List<Note> thirdTrackNotes = loadNotesForTrackFromMidi(trackOneMidiBytes); 
    // _thirdTrackNotes = firstTrackNotes;
  }

  /// Adds bottom row of note buttons to baseGame component list
  void _renderNoteButtonRow() {
    double firstNoteButtonX = screenMiddle - size.width * .2;
    Offset firstRectOffset = new Offset(firstNoteButtonX, noteButtonsY);
    Color firstNoteButtonColor = const Color(0xFF990000);

    double secondNoteButtonX = screenMiddle; 
    Offset secondRectOffset = new Offset(secondNoteButtonX, noteButtonsY);
    Color secondNoteButtonColor = const Color(0xFF009900);

    double thirdNoteButtonX = screenMiddle + size.width * .2;  
    Offset thirdRectOffset = new Offset(thirdNoteButtonX, noteButtonsY);
    Color thirdNoteButtonColor = const Color(0xFF000099);

    add(NoteButton(firstRectOffset, noteButtonWidth, firstNoteButtonColor));
    add(NoteButton(secondRectOffset, noteButtonWidth, secondNoteButtonColor));
    add(NoteButton(thirdRectOffset, noteButtonWidth, thirdNoteButtonColor));
  }
}
