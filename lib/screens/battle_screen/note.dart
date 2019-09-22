/// This is the model for the falling notes that people can play in the game
/// The game will load a dictionary where the keys is the start times of each midi note
/// The values will be a list of these notes models
class Note {
  // 3 midi notes are used
  // 48, 49, 50
  int _noteNumber = -1; // first track is closest to left thumb, second is in the middle, third is close to right thumb
  int _noteEnd = -1;
  int _noteStartTime = -1;

  int get noteNumber => _noteNumber;
  void set noteNumber(int noteNumber) => _noteNumber = noteNumber;

  int get noteEnd => _noteEnd;
  void set noteEnd(int noteEnd) => _noteEnd = noteEnd;

  int get noteStartTime => _noteStartTime;
  void set noteStartTime(int noteStartTime) => _noteStartTime = noteStartTime;

  // todo: a getter for noteLength probably just noteEnd - noteStart
}
