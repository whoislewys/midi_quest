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
    ByteData midiBytes = await rootBundle.load('assets/songs/test_song/midi/test_song.MID');
    List<List<Note>> notes = loadNotesForTrackFromMidi(midiBytes);
  }

  render() {
    // print('BattleScreen render');
     
  }

  update() {
    // print('BattleScreen update');
  }
}
