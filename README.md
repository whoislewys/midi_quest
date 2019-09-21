# MIDI QUEST

## Making a new playable song
1. make the song in ableton for easy composition and midi editing
1. make a midi track for player to play with max of 3 notes - midi notes 48, 49, and 50 (starts on C3).
1. make a new dir structure for that song like:
```
test_song/
├── midi/
│   ├── test_midi.MID
├── sound/
│   ├── test_sound.wav
```
1. export midi from ableton into the midi subdir you just made, export wav into the sound subdir you just made
1. open the midi you just exported from ableton in REAPER
1. In reaper, `File -> Export project MIDI...`
1. Make sure you check `Merge to Single MIDI track`, and `Embed project tempo...`
