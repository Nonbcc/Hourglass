import 'package:flutter/material.dart';
import 'package:hrg/widgets/dialogbox.dart';
import 'package:hrg/widgets/displaytimer.dart';
import 'package:hrg/widgets/timecontroller.dart';

class HourglassScreen extends StatelessWidget {
  const HourglassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: const [
              DisplayTimer(),
              DialogBox(),
              SizedBox(
                height: 20,
              ),
              TimeController(),
            ],
          ),
        ),
      ),
    );
  }
}
