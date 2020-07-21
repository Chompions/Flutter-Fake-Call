import 'package:flutter/material.dart';

class WhatsAppCall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            color: Color(0xFF004B44),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(color: Colors.white),
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: Color(0xFF004B44),
          ),
        ),
      ],
    ));
  }
}
