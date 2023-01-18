class DisplayTime {
  int hour;
  int minute;
  int second;

  DisplayTime({
    required this.hour,
    required this.minute,
    required this.second,
  });

  factory DisplayTime.fromSecond(int duration) {
    return DisplayTime(hour: 0, minute: 0, second: 0);
  }
}
