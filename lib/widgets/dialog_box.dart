import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  const DialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 323,
        height: 351,
        decoration: BoxDecoration(
          color: Colors.white,
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
      ),
    );
  }
}
