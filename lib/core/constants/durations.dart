class Durations {
  Durations._(); 
  
  // Animation durations
  static const fast = Duration(milliseconds: 150);
  static const normal = Duration(milliseconds: 300);
  static const slow = Duration(milliseconds: 500);
  static const verySlow = Duration(milliseconds: 800);

  // Delays
  static const shortDelay = Duration(milliseconds: 100);
  static const mediumDelay = Duration(milliseconds: 500);
  static const longDelay = Duration(seconds: 1);

  // Timeouts
  static const apiTimeout = Duration(seconds: 30);
  static const shortTimeout = Duration(seconds: 10);
}
