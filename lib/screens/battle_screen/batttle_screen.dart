import 'dart:io';
import 'dart:ui';
import 'dart:async';
import 'package:flame/components/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:midi_quest/screens/battle_screen/note_track.dart';

import 'note.dart';
import 'note_button.dart';
import 'note_loader.dart';

class BattleScreen {
  void Function(Component) add;
  
  List<Note> _firstTrackNotes;
  List<Note> _secondTrackNotes;
  List<Note> _thirdTrackNotes;

  // constants for bottom row of noteButtons
  Size size;
  
  double screenMiddle;

  double noteButtonsY;
  double firstNoteButtonX;
  Offset firstRectOffset;
  Color firstNoteButtonColor;
  double secondNoteButtonX;
  Offset secondRectOffset;
  Color secondNoteButtonColor;
  double thirdNoteButtonX;
  Offset thirdRectOffset;
  Color thirdNoteButtonColor;

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
    List<List<Note>> allTrackNotes = [_firstTrackNotes, _secondTrackNotes, _thirdTrackNotes];
    _renderTracks();
    _renderFallingNotes(allTrackNotes);
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
    firstNoteButtonX = screenMiddle - size.width * .2;
    firstRectOffset = new Offset(firstNoteButtonX, noteButtonsY);
    Color firstNoteButtonColor = const Color(0xFF990000);

    secondNoteButtonX = screenMiddle; 
    secondRectOffset = new Offset(secondNoteButtonX, noteButtonsY);
    Color secondNoteButtonColor = const Color(0xFF009900);

    thirdNoteButtonX = screenMiddle + size.width * .2;  
    thirdRectOffset = new Offset(thirdNoteButtonX, noteButtonsY);
    Color thirdNoteButtonColor = const Color(0xFF000099);

    add(NoteButton(firstRectOffset, noteButtonWidth, firstNoteButtonColor));
    add(NoteButton(secondRectOffset, noteButtonWidth, secondNoteButtonColor));
    add(NoteButton(thirdRectOffset, noteButtonWidth, thirdNoteButtonColor));
  }

  void _renderTracks(){ 
    add(new NoteTrack(firstNoteButtonX));
    add(new NoteTrack(secondNoteButtonX));
    add(new NoteTrack(thirdNoteButtonX));
  }

  void _renderFallingNotes(List<List<Note>> allTrackNotes) {
    var firstTrackNotes = allTrackNotes[0];

    // first track
    add(new FallingNotes(firstTrackNotes, firstRectOffset, noteButtonWidth, firstNoteButtonColor));
  }
}