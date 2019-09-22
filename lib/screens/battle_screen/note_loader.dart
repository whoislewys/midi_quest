import 'package:dart_midi/dart_midi.dart';
import 'package:flutter/services.dart';

import 'note.dart';

/// a script to parse midi notes from a file, get their start, ends, and lengths
List<Note> loadNotesForTrackFromMidi(ByteData midiBytes) {  
  var parser = MidiParser();
  List<int> buf = midiBytes.buffer.asUint8List();
  MidiFile parsedMidi = parser.parseMidiFromBuffer(buf);

  // filter all MIDI events in track down to only noteon/off evts
  List<MidiEvent> noteOnOffEvents = parsedMidi.tracks[0].where((midiEvent) => midiEvent is NoteOnEvent || midiEvent is NoteOffEvent).toList();
  
  // init time counter
  int ticksSoFar = 0;
  List<Note> notes = [];

  for (int i=0; i < noteOnOffEvents.length-1; i+=2) {
    Note curNote = new Note();
    var noteStartEvt = noteOnOffEvents[i];
    var noteEndEvt = noteOnOffEvents[i+1];
    if (noteStartEvt.deltaTime != 0) {
      // if note start has empty time before it, inc time counter
      ticksSoFar += noteStartEvt.deltaTime;
      // now set the start time to NOW on the note obj
      curNote.noteStartTime = ticksSoFar;
    } else {
      // if no empty time before note start, just set start time to NOW on the note obj
      curNote.noteStartTime = ticksSoFar;
    }

    if (noteEndEvt.deltaTime != 0) {
      // if note end has empty time before it, inc time counter
      ticksSoFar += noteEndEvt.deltaTime;
      curNote.noteEnd = ticksSoFar;
    } else {
      curNote.noteEnd = ticksSoFar;
    }
    notes.add(curNote);
  }

  return notes;
}

/// Returns BPM/tempo given a MIDI SetTempoEvent
double getBpmForMidiEvent(SetTempoEvent tempoEvent) {
  // todo: for more generality, replace [oneMinuteInMicroseconds] with calculation of tempo using time signature and microsecondsperbeat
  // info: https://stackoverflow.com/questions/2038313/converting-midi-ticks-to-actual-playback-seconds
  // info: http://www.lastrayofhope.co.uk/2009/12/23/midi-delta-time-ticks-to-seconds/
  int oneMinuteInMicroseconds = 60000000;
  return oneMinuteInMicroseconds/tempoEvent.microsecondsPerBeat;
}
