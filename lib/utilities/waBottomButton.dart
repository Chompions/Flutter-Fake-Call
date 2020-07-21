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
              Draggable(
                axis: Axis.vertical,
                feedback: MiddleButton(),
                child: AnimatedMiddleButton(
                  controller: controller,
                ),
                childWhenDragging: SizedBox(),
                data: "Accept",
              ),
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
