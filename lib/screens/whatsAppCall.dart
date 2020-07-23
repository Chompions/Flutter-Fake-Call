import 'package:flutter/material.dart';
import 'dart:async';

class WhatsAppCall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Column(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 3, bottom: 20, left: 5, right: 10),
            color: Color(0xFF004B44),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.expand_more,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: RichText(
                          text: TextSpan(children: [
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Icon(
                                Icons.lock,
                                color: Colors.white.withOpacity(.6),
                                size: 14.0,
                              ),
                            ),
                            TextSpan(
                              text: "  End-to-end encrypted",
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.white.withOpacity(.6),
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ]),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.person_add,
                          color: Colors.white,
                          size: 27,
                        ),
                      )
                    ],
                  ),
                  Text(
                    "Name",
                    style: TextStyle(
                      fontSize: 28.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  TickingTimer(),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                color: Colors.white,
              ),
              Positioned(
                bottom: 40,
                child: RawMaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  elevation: 2,
                  fillColor: Color(0xFFE91C43),
                  child: Icon(
                    Icons.call_end,
                    size: 30,
                    color: Colors.white,
                  ),
                  constraints: BoxConstraints.tightFor(
                    width: 60,
                    height: 60,
                  ),
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(16.0),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: Color(0xFF004B44),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Icon(
                  Icons.volume_up,
                  color: Color(0xFFB4CAC7),
                  size: 28,
                ),
                Icon(
                  Icons.videocam,
                  color: Color(0xFFB4CAC7),
                  size: 32,
                ),
                Icon(
                  Icons.mic_off,
                  color: Color(0xFFB4CAC7),
                  size: 28,
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}

class TickingTimer extends StatefulWidget {
  @override
  _TickingTimerState createState() => _TickingTimerState();
}

class _TickingTimerState extends State<TickingTimer> {
  bool currentRun;
  int intMin = 0;
  int intSec = 00;
  String seconds = "00";
  String minutes = "0";
  Timer callTimer;

  void startTimer() {
    callTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (intSec < 9) {
        setState(() {
          intSec++;
          seconds = "0$intSec";
        });
      } else if (intSec == 59) {
        setState(() {
          intSec = 0;
          intMin++;
          seconds = "0$intSec";
          minutes = "$intMin";
        });
      } else {
        setState(() {
          intSec++;
          seconds = "$intSec";
        });
      }
    });
  }

  @override
  void initState() {
    setState(() {
      currentRun = true;
    });
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    setState(() {
      currentRun = false;
      callTimer.cancel();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "$minutes:$seconds",
      style: TextStyle(
        fontSize: 17.0,
        color: Colors.white,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
