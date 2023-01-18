import 'package:flutter/material.dart';
import 'package:hrg/time_service.dart';
import 'package:hrg/widgets/cancel_popup.dart';
import 'package:hrg/widgets/skip_break_popup.dart';
import 'package:provider/provider.dart';

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
    SkipBreakPopup skipBreakPopup = SkipBreakPopup();
    CancelPopup cancelPopup = CancelPopup();

    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      if (provider.currentState == TimerState.breakTime) ...[
        TextButton(
          style: flatButtonStyle2,
          onPressed: () {
            Provider.of<TimerService>(context, listen: false).pause();
            skipBreakPopup.skipBreakPopup(context);
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
            cancelPopup.cancelPopup(context);
          },
          child: const Text('Cancel'),
        ),
      ] else if (provider.currentState == TimerState.focus) ...[
        TextButton(
          style: flatButtonStyle,
          onPressed: () {
            Provider.of<TimerService>(context, listen: false).pause();
            cancelPopup.cancelPopup(context);
          },
          child: const Text('Cancel'),
        ),
      ]
    ]);
  }
}
