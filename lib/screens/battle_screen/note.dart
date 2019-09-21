/// This is the model for the notes that people can play in the game
/// The game will load a dictionary where the keys is the start times of each midi note
/// The values will be a list of these notes models

// 3 midi are used notes
// 48, 49, 50
class Note {
  double noteTrack; // first track is closest to left thumb, second is in the middle, third is close to right thumb
  double noteEnd;
  double noteStartTime;

  Note(double noteTrack, double noteEnd, double noteStartTime) {
    this.noteTrack = noteTrack;
    this.noteEnd = noteTrack;
    this.noteStartTime = noteStartTime;
  }
}