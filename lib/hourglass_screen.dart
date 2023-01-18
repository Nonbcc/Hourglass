import 'package:flutter/material.dart';
import 'package:hrg/widgets/dialog_box.dart';
import 'package:hrg/widgets/display_timer.dart';
import 'package:hrg/widgets/time_controller.dart';

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
