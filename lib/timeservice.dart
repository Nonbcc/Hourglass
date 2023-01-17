import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hrg/submitscreen.dart';
import 'package:hrg/utils.dart';

enum TimerState { focus, cancel, breakTime, end, pause }

class TimerService extends ChangeNotifier {
  final sessionController = TextEditingController();
  final sessionNumController = TextEditingController();
  final breakController = TextEditingController();

  int inputSession = 0;
  int inputSessionNum = 0;
  int inputBreak = 0;

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
    inputSession = int.parse(sessionController.text);
    inputSessionNum = int.parse(sessionNumController.text);
    inputBreak = int.parse(breakController.text);

    if (inputSession <= 0 || inputSessionNum <= 0 || inputBreak <= 0) {}

    if (currentState == TimerState.cancel || currentState == TimerState.end) {
      iteration = 1;
      sumTime = 0;
      currentState = TimerState.focus;
      currentDuration = 0;
      currentDuration = inputSession;
      start(context);
    } else {
      currentDuration = inputSession;
      start(context);
    }

    print(inputSession);
    print(inputSessionNum);
    print(inputBreak);
    notifyListeners();
  }

  void start(BuildContext context) {
    timerPlaying = true;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (currentDuration == 0) {
        handleNextIteration(context);
      } else {
        currentDuration--;
        print("dura = $sumTime");
        notifyListeners();
      }
    });
  }

  void pause() {
    if (currentState == TimerState.focus) {
      sumTime += (inputSession - currentDuration);
    }
    print('sum = $sumTime');
    print(currentState);
    timer!.cancel();
    // timerPlaying = false;
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

  void skipBreak(BuildContext context) {
    timer!.cancel();
    currentState = TimerState.focus;
    currentDuration = inputSession;
    notifyListeners();
  }

  void handleNextIteration(BuildContext context) {
    if (currentState == TimerState.focus) {
      if (iteration < inputSessionNum) {
        sumTime += (inputSession - currentDuration);
        print('sum = $sumTime');
        currentState = TimerState.breakTime;
        currentDuration = inputBreak;
        iteration++;
      } else if (iteration >= inputSessionNum) {
        sumTime += (inputSession - currentDuration);
        print('sum = $sumTime');
        print('eiei');
        stop();
        showResult(context);
      }
    } else if (currentState == TimerState.breakTime) {
      currentState = TimerState.focus;
      currentDuration = inputSession;
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
