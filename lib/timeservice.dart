import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hrg/utils.dart';

class TimerService extends ChangeNotifier {
  final sessionDurationController = TextEditingController();
  final sessionNumberController = TextEditingController();
  final breakTimeController = TextEditingController();

  int enteredsessionDuration = 0;
  int enteredsessionNumberDuration = 0;
  int enteredbreakTime = 0;

  Timer? timer;
  int currentDuration = 0;
  int seconds = 0;
  int minutes = 0;
  bool timerPlaying = false;
  int iteration = 1;
  String currentState = "Focus";
  String twoDigits(int n) => n.round().toString().padLeft(2, '0');

  void submitData() {
    enteredsessionDuration = int.parse(sessionDurationController.text);
    enteredsessionNumberDuration = int.parse(sessionNumberController.text);
    enteredbreakTime = int.parse(breakTimeController.text);

    if (enteredsessionDuration <= 0 ||
        enteredsessionNumberDuration <= 0 ||
        enteredbreakTime <= 0) {
      print('Error');
    }

    currentDuration = enteredsessionDuration;
    start();

    print(enteredsessionDuration);
    print(enteredsessionNumberDuration);
    print(enteredbreakTime);
  }

  void start() {
    timerPlaying = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (currentDuration == 0) {
        handleNextIteration();
      } else if (iteration == enteredsessionNumberDuration + 1) {
        stop();
      } else {
        currentDuration--;
        notifyListeners();
      }
    });
  }

  void stop() {
    timer!.cancel();
    timerPlaying = false;
    notifyListeners();
  }

  void cancelSession() {}

  void handleNextIteration() {
    if (currentState == "Focus") {
      currentState = "Break Time";
      currentDuration = enteredbreakTime;
      iteration++;
    } else if (currentState == "Break Time") {
      currentState = "Focus";
      currentDuration = enteredsessionDuration;
    }
    notifyListeners();
  }

  Widget? changesecondsunit() {
    seconds = currentDuration % 60;

    if (seconds == 0) {
      return Text(
        "${seconds.round()}0",
        style: textStyle(60, Colors.brown, FontWeight.bold),
      );
    } else {
      return Text(
        twoDigits(seconds),
        style: textStyle(60, Colors.brown, FontWeight.bold),
      );
    }
  }

  Widget? changeminutesunit() {
    minutes = currentDuration % 3600;

    if (minutes == 0) {
      return Text(
        "${minutes.round()}0",
        style: textStyle(60, Colors.brown, FontWeight.bold),
      );
    } else {
      return Text(
        twoDigits((minutes ~/ 60)),
        style: textStyle(60, Colors.brown, FontWeight.bold),
      );
    }
  }
}
