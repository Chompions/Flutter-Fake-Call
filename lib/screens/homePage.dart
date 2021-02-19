import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/Home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Infake Call"),
      ),
      body: Column(
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, '/WhatsAppIncoming');
            },
            child: Text("Whatsapp"),
          ),
          FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, '/ProfileCreate');
            },
            child: Text("Profile Create"),
          ),
        ],
      ),
    );
  }
}
