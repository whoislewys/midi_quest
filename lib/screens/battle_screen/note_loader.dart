import 'package:dart_midi/dart_midi.dart';
import 'package:flutter/services.dart';

import 'note.dart';

List<List<Note>> loadNotesForTrackFromMidi(ByteData midiBytes) {  
  var parser = MidiParser();
  List<int> buf = midiBytes.buffer.asUint8List();
  MidiFile parsedMidi = parser.parseMidiFromBuffer(buf);

  /*
  TODO: i need to parse this track into
  [
    track1: [
      new Note(
      midiNote (48),
      noteStartTime,
      noteEndTime,
      )
    ]
  ]
  */

  /*
  i need a global time counter to keep track of total midi ticks
  eeach midi note on/off pair read, will add its deltatime to the global time
  i will then make a Note obj by using the global time and relative time
  */

  // filter to only noteon /off evts
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
      print('tics so far: $ticksSoFar');
      ticksSoFar += noteStartEvt.deltaTime;
      // now set the start time to NOW on the note obj
      // curNote.noteStartTime = ticksSofar;
    } else {
      // if no empty time before note start, just set start time to NOW on the note obj
      // curNote.noteStartTime = ticksSofar;
    }

    if (noteEndEvt.deltaTime != 0) {
      // if note end has empty time before it, inc time counter
      ticksSoFar += noteEndEvt.deltaTime;
      // curNote.noteEnd = ticksSofar;
    } else {
      // curNote.noteEnd = ticksSofar;
    }

    notes.add(curNote);
  }

  // print('delta times');
  // int noteOnCount=1;
  // int noteOffCount=1;
  // noteOnOffEvents.forEach((noteOnOffEvent) {
  //   // since im parsing the play events for one midi note at a time
  //   // i am guaranteed to get a note on followed by a note off each time
  //   // i want to get two events at a time and build a note object from them
  //   // increment global time using the info from those events
  //   // and build up my list of notes from that
  //   if(noteOnOffEvent is NoteOnEvent) {
  //     print('noteonevent num: $noteOnCount');
  //     noteOnCount++;
  //   }
  //   if(noteOnOffEvent is NoteOffEvent) {
  //     print('noteoffevent num: $noteOffCount');
  //     noteOffCount++;
  //   }
  //   if (noteOnOffEvent.deltaTime != 0) {
  //     ticksSoFar += noteOnOffEvent.deltaTime;
  //   }
  //   print('tricks sofar $ticksSoFar');
  // });

  // how to get pairs of items from an iterable in dart?

  return [notes];
}



/// Returns BPM/tempo given a MIDI SetTempoEvent
double getBpmForMidiEvent(SetTempoEvent tempoEvent) {
  // todo: for more generality, replace [oneMinuteInMicroseconds] with calculation of tempo using time signature and microsecondsperbeat
  // info: https://stackoverflow.com/questions/2038313/converting-midi-ticks-to-actual-playback-seconds
  // info: http://www.lastrayofhope.co.uk/2009/12/23/midi-delta-time-ticks-to-seconds/
  int oneMinuteInMicroseconds = 60000000;
  return oneMinuteInMicroseconds/tempoEvent.microsecondsPerBeat;
}
