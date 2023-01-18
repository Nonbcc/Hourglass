import 'package:flutter/material.dart';
import 'package:hrg/hourglass_screen.dart';
import 'package:hrg/time_service.dart';
import 'package:provider/provider.dart';

class InputBox extends StatefulWidget {
  const InputBox({super.key});

  @override
  State<InputBox> createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    backgroundColor: Colors.brown,
    foregroundColor: Colors.white,
    minimumSize: const Size(89, 44),
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(100)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TimerService>(context);
    return Center(
      child: Container(
        alignment: Alignment.center,
        width: 323,
        height: 293,
        decoration: BoxDecoration(
          color: const Color(0xFFEFD3C2),
          borderRadius: BorderRadius.circular(60),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 4,
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const Text(
                  "Session Duration",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF482311),
                  ),
                ),
                TextField(
                  decoration: const InputDecoration(
                    constraints: BoxConstraints(
                      maxHeight: 30,
                      maxWidth: 30,
                    ),
                  ),
                  controller: provider.sessionController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) =>
                      Provider.of<TimerService>(context, listen: false)
                          .submitData(context),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const Text(
                  "Session",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF482311),
                  ),
                ),
                TextField(
                  decoration: const InputDecoration(
                    constraints: BoxConstraints(
                      maxHeight: 30,
                      maxWidth: 30,
                    ),
                  ),
                  controller: provider.sessionNumController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) =>
                      Provider.of<TimerService>(context, listen: false)
                          .submitData(context),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const Text(
                  "Break time",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF482311),
                  ),
                ),
                TextField(
                  decoration: const InputDecoration(
                    constraints: BoxConstraints(
                      maxHeight: 30,
                      maxWidth: 30,
                    ),
                  ),
                  controller: provider.breakController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) =>
                      Provider.of<TimerService>(context, listen: false)
                          .submitData(context),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: TextButton(
                style: flatButtonStyle,
                onPressed: () {
                  Provider.of<TimerService>(context, listen: false)
                      .submitData(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return const HourglassScreen();
                  }));
                },
                child: const Text('Confirm'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
