import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hrg/submitscreen.dart';
import 'package:hrg/utils.dart';

enum TimerState { focus, cancel, breakTime, end, pause }

class TimerService extends ChangeNotifier {
  final sessionDurationController = TextEditingController();
  final sessionNumberController = TextEditingController();
  final breakTimeController = TextEditingController();

  int enteredSessionDuration = 0;
  int enteredSessionNumberDuration = 0;
  int enteredBreakTime = 0;

  Timer? timer;
  int sumTime = 0;
  int currentDuration = 0;
  int seconds = 0;
  int minutes = 0;
  bool timerPlaying = false;
  int iteration = 1;
  TimerState currentState = TimerState.focus;
  String twoDigits(int n) => n.round().toString().padLeft(2, '0');

  void submitData(BuildContext context) {
    enteredSessionDuration = int.parse(sessionDurationController.text);
    enteredSessionNumberDuration = int.parse(sessionNumberController.text);
    enteredBreakTime = int.parse(breakTimeController.text);

    if (enteredSessionDuration <= 0 ||
        enteredSessionNumberDuration <= 0 ||
        enteredBreakTime <= 0) {}

    if (currentState == TimerState.cancel || currentState == TimerState.end) {
      iteration = 1;
      sumTime = 0;
      currentState = TimerState.focus;
      currentDuration = 0;
      currentDuration = enteredSessionDuration;
      start(context);
    } else {
      currentDuration = enteredSessionDuration;
      start(context);
    }

    print(enteredSessionDuration);
    print(enteredSessionNumberDuration);
    print(enteredBreakTime);
    notifyListeners();
  }

  void start(BuildContext context) {
    timerPlaying = true;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (currentDuration == 0) {
        handleNextIteration(context);
      } else {
        currentDuration--;
        notifyListeners();
      }
    });
  }

  void pause() {
    if (currentState == TimerState.focus) {
      sumTime += (enteredSessionDuration - currentDuration);
    }
    print('sum = $sumTime');
    print(currentState);
    timer!.cancel();
    timerPlaying = false;
    notifyListeners();
  }

  void stop() {
    timer!.cancel();
    timerPlaying = false;
    currentState = TimerState.end;
    notifyListeners();
  }

  void cancelSession(BuildContext context) {
    timer!.cancel();
    timerPlaying = false;
    currentState = TimerState.cancel;
    notifyListeners();
  }

  void handleNextIteration(BuildContext context) {
    if (currentState == TimerState.focus) {
      if (iteration < enteredSessionNumberDuration) {
        sumTime += (enteredSessionDuration - currentDuration);
        print('sum = $sumTime');
        currentState = TimerState.breakTime;
        currentDuration = enteredBreakTime;
        iteration++;
      } else if (iteration >= enteredSessionNumberDuration) {
        sumTime += (enteredSessionDuration - currentDuration);
        print('sum = $sumTime');
        print('eiei');
        stop();
        showResult(context);
      }
    } else if (currentState == TimerState.breakTime) {
      currentState = TimerState.focus;
      currentDuration = enteredSessionDuration;
    }
    notifyListeners();
  }

  void showResult(BuildContext context) {
    String sec = changeSecondsUnit(sumTime);
    String min = changeMinutesUnit(sumTime);
    String hr = changeHoursUnit(sumTime);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reading result'),
        content: Row(
          children: [
            Text(hr),
            const SizedBox(
              width: 5,
            ),
            const Text(
              'h',
            ),
            const SizedBox(
              width: 5,
            ),
            Text(min),
            const SizedBox(
              width: 5,
            ),
            const Text(
              'm',
            ),
            const SizedBox(
              width: 5,
            ),
            Text(sec),
            const SizedBox(
              width: 5,
            ),
            const Text(
              's',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return const SubmitScreen();
              }));
            },
            child: Text(
              'Ok',
              style: textStyle(16),
            ),
          ),
        ],
      ),
    );
  }

  String changeSecondsUnit(int time) {
    seconds = time % 60;
    if (seconds == 0) {
      return "${seconds.round()}0";
    } else {
      return twoDigits(seconds);
    }
  }

  String changeMinutesUnit(int time) {
    minutes = time % 3600;
    if (minutes == 0) {
      return "${minutes.round()}0";
    } else {
      return twoDigits((minutes ~/ 60));
    }
  }

  String changeHoursUnit(int time) {
    return twoDigits((time ~/ 3600));
  }
}
