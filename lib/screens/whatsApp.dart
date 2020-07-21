import 'package:flutter/material.dart';
import '../utilities/waBottomButton.dart';

class WhatsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Container(
              color: Color(0xFF004B44),
              padding: EdgeInsets.only(top: 3, bottom: 6),
              child: SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(children: [
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Icon(
                              Icons.lock,
                              color: Colors.white.withOpacity(.5),
                              size: 15.0,
                            ),
                          ),
                          TextSpan(
                            text: "  End-to-end encrypted",
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white.withOpacity(.5),
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ]),
                      ),
                      Container(
                        margin: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.3),
                              spreadRadius: 4,
                              blurRadius: 6,
                            )
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 50.0,
                        ),
                      ),
                      Text(
                        "Name",
                        style: TextStyle(
                          fontSize: 35.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      Text(
                        "WhatsApp voice call",
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Color(0xFF1F2831),
              padding: EdgeInsets.only(bottom: 25, left: 30, right: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  // Center(
                  //   child: Container(
                  //     height: 150,
                  //     width: 100,
                  //     child: DragTarget<String>(
                  //       builder: (context, candidateData, rejectedData) {
                  //         return SizedBox();
                  //       },
                  //       onWillAccept: (data) => data == "Accept",
                  //       onAccept: (data) {
                  //         Navigator.popAndPushNamed(context, '/WhatsAppCall');
                  //       },
                  //     ),
                  //   ),
                  // ),
                  BottomButton(),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Swipe up to accept",
                    style: TextStyle(
                      color: Colors.white.withOpacity(.6),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
