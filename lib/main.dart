import 'package:flutter/material.dart';
import 'screens/homePage.dart';
import 'screens/whatsApp.dart';
import 'screens/whatsAppCall.dart';

void main() => runApp(FakeCall());

class FakeCall extends StatefulWidget {
  @override
  _FakeCallState createState() => _FakeCallState();
}

class _FakeCallState extends State<FakeCall> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Fake Call",
      theme: ThemeData(
        fontFamily: 'HelveticNeue',
      ),
      initialRoute: '/Home',
      routes: {
        '/Home': (context) => HomePage(),
        '/WhatsAppIncoming': (context) => WhatsAppIncoming(),
        '/WhatsAppCall': (context) => WhatsAppCall(),
      },
    );
  }
}
