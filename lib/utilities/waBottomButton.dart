import 'package:fake_call/utilities/custom_icons.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'waMiddleButton.dart';

class BottomButton extends StatefulWidget {
  @override
  _BottomButtonState createState() => _BottomButtonState();
}

class _BottomButtonState extends State<BottomButton> with TickerProviderStateMixin {
  Timer incomingCallTimer;
  int incomingCallDuration = 20;
  AnimationController controller;
  bool visibleAnimation = true;
  double buttonPosition = 0.0;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    incomingCallTimer = Timer.periodic(oneSec, (timer) {
      setState(() {
        if (incomingCallDuration < 1) {
          incomingCallTimer.cancel();
          Navigator.pop(context);
        } else {
          incomingCallDuration = incomingCallDuration - 1;
          // print(incomingCallDuration);
        }
      });
    });
  }

  @override
  void initState() {
    startTimer();
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    super.initState();
  }

  @override
  void dispose() {
    incomingCallTimer.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        RawMaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          elevation: 0,
          fillColor: Color(0xFF0b0d0f),
          child: Icon(
            Icons.call_end,
            size: 30,
            color: Colors.red,
          ),
          constraints: BoxConstraints.tightFor(
            width: 60,
            height: 60,
          ),
          shape: CircleBorder(),
          padding: EdgeInsets.all(16.0),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: 200,
                width: 100,
              ),
              ArrowStack(
                controller: controller,
              ),
              GestureDetector(
                onPanStart: (details) {
                  setState(() {
                    visibleAnimation = false;
                  });
                },
                onPanUpdate: (details) {
                  setState(() {
                    buttonPosition = details.localPosition.dy.clamp(-200.0, 0.0);
                  });
                  // print(buttonPosition);
                },
                onPanEnd: (details) {
                  setState(() {
                    if (buttonPosition == -200.0) {
                      Navigator.popAndPushNamed(context, '/WhatsAppCall');
                    } else {
                      buttonPosition = 0.0;
                      visibleAnimation = true;
                    }
                  });
                },
                child: Transform.translate(
                  offset: Offset(0.0, buttonPosition),
                  child: Container(
                    child: Stack(
                      children: <Widget>[
                        Visibility(
                          visible: visibleAnimation == false,
                          child: MiddleButton(),
                        ),
                        Visibility(
                          visible: visibleAnimation == true,
                          child: AnimatedMiddleButton(
                            controller: controller,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        RawMaterialButton(
          onPressed: null,
          elevation: 0,
          fillColor: Color(0xFF0b0d0f),
          child: Icon(
            MyFlutterApp.message_reply,
            size: 25,
            color: Colors.white,
          ),
          constraints: BoxConstraints.tightFor(
            width: 60,
            height: 60,
          ),
          shape: CircleBorder(),
        ),
      ],
    );
  }
}
