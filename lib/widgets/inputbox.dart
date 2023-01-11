import 'package:flutter/material.dart';
import 'package:hrg/hourglassscreen.dart';
import 'package:hrg/timeservice.dart';
import 'package:provider/provider.dart';

class InputBox extends StatefulWidget {
  const InputBox({super.key});

  @override
  State<InputBox> createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    backgroundColor: Colors.brown,
    primary: Colors.white,
    minimumSize: Size(89, 44),
    padding: EdgeInsets.symmetric(horizontal: 16.0),
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
          color: Color(0xFFEFD3C2),
          borderRadius: BorderRadius.circular(60),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 4,
              blurRadius: 4,
              offset: Offset(0, 2),
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
                Text(
                  "Session Duration",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF482311),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    constraints: BoxConstraints(
                      maxHeight: 30,
                      maxWidth: 30,
                    ),
                  ),
                  controller: provider.sessionDurationController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) =>
                      Provider.of<TimerService>(context, listen: false)
                          .submitData(),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "Session",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF482311),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    constraints: BoxConstraints(
                      maxHeight: 30,
                      maxWidth: 30,
                    ),
                  ),
                  controller: provider.sessionNumberController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) =>
                      Provider.of<TimerService>(context, listen: false)
                          .submitData(),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "Break time",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF482311),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    constraints: BoxConstraints(
                      maxHeight: 30,
                      maxWidth: 30,
                    ),
                  ),
                  controller: provider.breakTimeController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) =>
                      Provider.of<TimerService>(context, listen: false)
                          .submitData(),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: TextButton(
                style: flatButtonStyle,
                onPressed: () {
                  Provider.of<TimerService>(context, listen: false)
                      .submitData();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return HourglassScreen();
                  }));
                },
                child: Text('Confirm'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
