import 'package:flutter/material.dart';
import 'package:hrg/submitscreen.dart';
import 'package:hrg/timeservice.dart';
import 'package:provider/provider.dart';
import 'package:hrg/utils.dart';

class CancelDialog {
  void cancelDialog(BuildContext context) {
    final provider = Provider.of<TimerService>(context, listen: false);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        alignment: Alignment.center,
        title: Text(
          'Do you want to cancel your session?',
          style: textStyle(18),
        ),
        content: Text(
          'Already read: ${Provider.of<TimerService>(context, listen: false).changeHoursUnit(provider.sumTime)} h ${Provider.of<TimerService>(context, listen: false).changeMinutesUnit(provider.sumTime)} m ${Provider.of<TimerService>(context, listen: false).changeSecondsUnit(provider.sumTime)} s ',
          style: textStyle(14),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Provider.of<TimerService>(context, listen: false)
                    .cancelSession(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return const SubmitScreen();
                }));
              },
              child: Text(
                'Yes',
                style: textStyle(16),
              )),
          TextButton(
            onPressed: () {
              if (provider.currentState == TimerState.focus) {
                provider.sumTime -=
                    provider.inputSession - provider.currentDuration;
              }

              Navigator.of(ctx).pop();
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
