import 'package:flutter/material.dart';
import 'package:hrg/submitscreen.dart';
import 'package:provider/provider.dart';
import 'package:hrg/timeservice.dart';

void main() {
  runApp(ChangeNotifierProvider<TimerService>(
    create: (_) => TimerService(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SubmitScreen(),
    );
  }
}
