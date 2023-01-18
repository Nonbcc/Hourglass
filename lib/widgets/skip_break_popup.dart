import 'package:flutter/material.dart';
import 'package:hrg/time_service.dart';
import 'package:provider/provider.dart';
import 'package:hrg/utils.dart';

class SkipBreakPopup {
  void skipBreakPopup(BuildContext context) {
    final provider = Provider.of<TimerService>(context, listen: false);
    showDialog(
      context: context,
      builder: (ctx2) => AlertDialog(
        alignment: Alignment.center,
        title: Text(
          'Do you want to skip the break?',
          style: textStyle(18),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (provider.currentState == TimerState.breakTime) {
                Provider.of<TimerService>(context, listen: false)
                    .skipBreak(context);
              }
              Navigator.of(ctx2).pop();
              Provider.of<TimerService>(context, listen: false).start(context);
            },
            child: Text(
              'Yes',
              style: textStyle(16),
            ),
          ),
          TextButton(
            onPressed: () {
              if (provider.currentState == TimerState.focus) {
                provider.sumTime -=
                    provider.inputSession - provider.currentDuration;
              }
              Navigator.of(ctx2).pop();
              Provider.of<TimerService>(context, listen: false).start(context);
            },
            child: Text(
              'No',
              style: textStyle(16),
            ),
          ),
        ],
      ),
    );
  }
}
