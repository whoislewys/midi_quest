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
  print('parsedmidi: ${parsedMidi.toString()}');
  int count = 0;
  parsedMidi.tracks[0].forEach((midiEvent) {
     print('midi event tostr: ${midiEvent.toString()}');
     if (midiEvent is NoteOnEvent) {
       count++;
       print('midi event deltatime: ${midiEvent.deltaTime}');
     }
     if (midiEvent is SetTempoEvent) {
       print('tempo: ${getBpmForMidiEvent(midiEvent)}');
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

/// Returns BPM/tempo given a MIDI SetTempoEvent
double getBpmForMidiEvent(SetTempoEvent tempoEvent) {
  // todo: for more generality, replace [oneMinuteInMicroseconds] with calculation of tempo using time signature and microsecondsperbeat
  // info: https://stackoverflow.com/questions/2038313/converting-midi-ticks-to-actual-playback-seconds
  // info: http://www.lastrayofhope.co.uk/2009/12/23/midi-delta-time-ticks-to-seconds/
  int oneMinuteInMicroseconds = 60000000;
  return oneMinuteInMicroseconds/tempoEvent.microsecondsPerBeat;
}