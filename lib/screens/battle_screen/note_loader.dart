import 'package:dart_midi/dart_midi.dart';
import 'package:flutter/services.dart';

import 'note.dart';

List<List<Note>> loadNotesForTrackFromMidi(ByteData midiBytes) {  
  var parser = MidiParser();
  List<int> buf = midiBytes.buffer.asUint8List();
  MidiFile parsedMidi = parser.parseMidiFromBuffer(buf);

  // print('parsedmidi tracks: ${parsedMidi.tracks[0].toString()}');
/*
TODO: i need to parse this track into
[
  track1: [
    new Note(
    midiNote (48,49, or 50),
    noteStartTime,
    noteEnd,
    )
  ]
]
*/
  // i should be getting 12 note on events. Good!
  int count = 0;
  parsedMidi.tracks[0].forEach((midiEvent) {
    //  print('midi event tostr: ${midiEvent.toString()}');
     if (midiEvent is NoteOnEvent) {
       count++;
       print('noteonevent');
       print('midi event deltatime: ${midiEvent.deltaTime}');
     }
   });
     print('noteonevvents ct: $count');

  // List<NoteOnEvent> noteStarts = parsedMidi.tracks[0].where((midiEvent) {
  //    print('midi event tostr: ${midiEvent.toString()}');
  //    if (midiEvent is NoteOnEvent) {
  //      print('noteonevent');
  //    }
  //    return midiEvent is NoteOnEvent;
  //  }).toList();
  // List<NoteOnEvent> noteStarts = parsedMidi.tracks[0].where((midiEvent) => midiEvent is NoteOnEvent).toList();
  // List<NoteOffEvent> noteEnds = parsedMidi.tracks[0].where((midiEvent) => midiEvent is NoteOffEvent).toList();
  // List<int> noteNumbers = noteStarts.map((noteStart) => noteStart.noteNumber).toList();

  // print('notestarts: {$noteStarts.toString()}');
  // print('notestarts: {$noteEnds.toString()}');
  // print('notestarts: $noteNumbers');

  return [[new Note(0, 12, 30)]];
}