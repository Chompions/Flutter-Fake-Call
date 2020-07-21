import 'package:flutter/material.dart';
import 'dart:math' as math;
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
      duration: const Duration(seconds: 3),
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
                  print(buttonPosition);
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
                  )),
                ),
              ),
              // Dismissible(
              //     key: Key("Accept"),
              //     direction: DismissDirection.up,
              //     child: Container(
              //         height: 200,
              //         child: Align(
              //           alignment: Alignment.bottomCenter,
              //           child: Container(
              //             width: 50,
              //             height: 50,
              //             color: Colors.black,
              //             child: MiddleButton(),
              //           ),
              //         )),
              //     dismissThresholds: {DismissDirection.up: 1},
              //     onDismissed: (data) {
              //       Navigator.popAndPushNamed(context, '/WhatsAppCall');
              //     }),
              // Draggable(
              //   axis: Axis.vertical,
              //   feedback: MiddleButton(),
              //   child: AnimatedMiddleButton(
              //     controller: controller,
              //   ),
              //   childWhenDragging: SizedBox(),
              //   data: "Accept",
              // ),
            ],
          ),
        ),
        RawMaterialButton(
          onPressed: null,
          elevation: 0,
          fillColor: Color(0xFF0b0d0f),
          child: Transform.rotate(
            angle: 180 * math.pi / 180,
            child: Icon(
              Icons.message,
              size: 25,
              color: Colors.white,
            ),
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
