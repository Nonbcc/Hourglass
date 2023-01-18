import 'package:flutter/material.dart';
import 'package:hrg/submit_screen.dart';
import 'package:hrg/time_service.dart';
import 'package:hrg/utils.dart';
import 'package:provider/provider.dart';

class ShowResultPopup {
  void showResultPopup(BuildContext context) {
    final provider = Provider.of<TimerService>(context, listen: false);
    String sec = Provider.of<TimerService>(context, listen: false)
        .changeSecondsUnit(provider.sumTime);
    String min = Provider.of<TimerService>(context, listen: false)
        .changeMinutesUnit(provider.sumTime);
    String hr = Provider.of<TimerService>(context, listen: false)
        .changeHoursUnit(provider.sumTime);

    showDialog(
      context: context,
      builder: (ctx3) => AlertDialog(
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
              Navigator.push(ctx3,
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
}
