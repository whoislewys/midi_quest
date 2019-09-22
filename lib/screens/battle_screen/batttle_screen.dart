import 'dart:io';
import 'dart:ui';
import 'dart:async';
import 'package:flutter/services.dart';

import 'note.dart';
import 'note_loader.dart';


class BattleScreen {
  BattleScreen() {
  }

  void initBattleScreen() async {
    // instead of loading each track from a sep file, could also do a single multitrack file
    // doesnt really matter tbh. just wanna flex how my brain thinks of many possible solutions
    ByteData midiBytes = await rootBundle.load('assets/songs/test_song/midi/test_song_C3.MID');
    List<List<Note>> notes = loadNotesForTrackFromMidi(midiBytes);
  }

  render() {
    // print('BattleScreen render');
     
  }

  update() {
    // print('BattleScreen update');
  }
}
