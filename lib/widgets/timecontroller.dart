import 'dart:async';

import 'package:flutter/material.dart';
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
      primary: Colors.white,
      minimumSize: Size(89, 44),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
    );

    final provider = Provider.of<TimerService>(context);

    return Center(
      child: Container(
        child: TextButton(
          style: flatButtonStyle,
          onPressed: () {
            // if (provider.timerPlaying) {
            //   print('eiei');
            // } else {
            //   Provider.of<TimerService>(context, listen: false).start();
            // }
          },
          child: Text('Cancel'),
        ),
      ),
    );
  }
}
