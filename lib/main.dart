import 'package:flutter/material.dart';
import 'screens/homePage.dart';
import 'screens/whatsAppIncoming.dart';
import 'screens/whatsAppCall.dart';
import 'screens/profileCreate.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(FakeCall());
}

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
        HomePage.routeName: (context) => HomePage(),
        WhatsAppIncoming.routeName: (context) => WhatsAppIncoming(),
        '/WhatsAppCall': (context) => WhatsAppCall(),
        ProfileCreate.routeName: (context) => ProfileCreate(),
      },
    );
  }
}
