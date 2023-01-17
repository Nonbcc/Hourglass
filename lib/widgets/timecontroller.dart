import 'package:flutter/material.dart';
import 'package:hrg/submitscreen.dart';
import 'package:hrg/timeservice.dart';
import 'package:provider/provider.dart';
import 'package:hrg/utils.dart';

class TimeController extends StatefulWidget {
  const TimeController({super.key});

  @override
  State<TimeController> createState() => _TimeControllerState();
}

class _TimeControllerState extends State<TimeController> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: Colors.redAccent,
      foregroundColor: Colors.white,
      minimumSize: const Size(89, 44),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
    );
    final ButtonStyle flatButtonStyle2 = TextButton.styleFrom(
      backgroundColor: Colors.brown,
      foregroundColor: Colors.white,
      minimumSize: const Size(89, 44),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
    );

    final provider = Provider.of<TimerService>(context);

    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      if (provider.currentState == TimerState.breakTime) ...[
        TextButton(
          style: flatButtonStyle2,
          onPressed: () {
            Provider.of<TimerService>(context, listen: false).pause();
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
                      Provider.of<TimerService>(context, listen: false)
                          .start(context);
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
                      Provider.of<TimerService>(context, listen: false)
                          .start(context);
                    },
                    child: Text(
                      'No',
                      style: textStyle(16),
                    ),
                  ),
                ],
              ),
            );
          },
          child: const Text('Skip Break'),
        ),
        const SizedBox(
          width: 30,
        ),
        TextButton(
          style: flatButtonStyle,
          onPressed: () {
            Provider.of<TimerService>(context, listen: false).pause();
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
                      Provider.of<TimerService>(context, listen: false)
                          .start(context);
                    },
                    child: Text(
                      'No',
                      style: textStyle(16),
                    ),
                  ),
                ],
              ),
            );
          },
          child: const Text('Cancel'),
        ),
      ] else if (provider.currentState == TimerState.focus) ...[
        TextButton(
          style: flatButtonStyle,
          onPressed: () {
            Provider.of<TimerService>(context, listen: false).pause();
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
                      Provider.of<TimerService>(context, listen: false)
                          .start(context);
                    },
                    child: Text(
                      'No',
                      style: textStyle(16),
                    ),
                  ),
                ],
              ),
            );
          },
          child: const Text('Cancel'),
        ),
      ]
    ]);
  }
}
