import 'package:flutter/material.dart';
import 'dart:math' as math;

// ARROW STACK

class ArrowStack extends StatefulWidget {
  final AnimationController controller;

  ArrowStack({this.controller});

  @override
  _ArrowStackState createState() => _ArrowStackState();
}

class _ArrowStackState extends State<ArrowStack> {
  Animation _colorTween;

  @override
  void initState() {
    _colorTween = Tween(begin: 0.0, end: 1.0).animate(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
          stops: [
            _colorTween.value - 0.3,
            _colorTween.value,
            _colorTween.value + 0.3,
          ],
          colors: [
            Color(0xFF1F2831),
            Colors.white,
            Color(0xFF1F2831),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ).createShader(bounds);
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            height: 200,
            width: 100,
          ),
          SmallArrow(
            positionToHeight: 90.0,
          ),
          SmallArrow(
            positionToHeight: 115.0,
          ),
          SmallArrow(
            positionToHeight: 140.0,
          ),
          SmallArrow(
            positionToHeight: 165.0,
          ),
        ],
      ),
    );
  }
}

// SMALL ARROW

class SmallArrow extends StatelessWidget {
  SmallArrow({@required this.positionToHeight});

  final double positionToHeight;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: (positionToHeight),
      child: Container(
        child: Icon(Icons.expand_less, size: 40, color: Colors.white),
      ),
    );
  }
}

// ANIMATED MIDDLE BUTTON

class AnimatedMiddleButton extends StatefulWidget {
  final AnimationController controller;

  AnimatedMiddleButton({this.controller});

  @override
  _AnimatedMiddleButtonState createState() => _AnimatedMiddleButtonState();
}

class _AnimatedMiddleButtonState extends State<AnimatedMiddleButton> {
  // Future _playAnimation() async {
  //   try {
  //     await widget.controller.forward().orCancel;
  //   } on TickerCanceled {
  //     print("Animation closed");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return StaggerAnimation(
      controller: widget.controller.view,
    );
  }
}

// MIDDLE BUTTON

class MiddleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFF02D65D),
      ),
      constraints: BoxConstraints.tightFor(
        width: 60,
        height: 60,
      ),
      padding: EdgeInsets.all(16.0),
      child: Icon(
        Icons.call,
        size: 30,
        color: Colors.white,
      ),
    );
  }
}

class ShakeCurve extends Curve {
  final double begin;
  final double end;

  ShakeCurve(this.begin, this.end);

  @override
  double transformInternal(double t) {
    t = ((t - begin) / (end - begin)).clamp(0.0, 1.0) as double;
    var val = (0.1 / 0.8 + t) * math.sin((2 * math.pi * t) / 0.4) + 0.5;
    // var val = math.sin(3 * 2 * math.pi * t) * 0.5 + 0.5;
    return val;
  }
}

class StaggerAnimation extends StatelessWidget {
  StaggerAnimation({this.controller})
      : moveUp = Matrix4Tween(
          begin: Matrix4.translationValues(0, 0, 0),
          end: Matrix4.translationValues(0, -30, 0),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0, 0.25),
          ),
        ),
        moveDown = Tween<double>(
          begin: 0,
          end: 30,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.35, 0.5),
          ),
        ),
        shake = Tween<double>(
          begin: -2,
          end: 2,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: ShakeCurve(0.25, 0.35),
          ),
        );

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Container(
      transform: moveUp.value,
      child: Container(
        transform: Matrix4.translationValues(
          shake.value,
          moveDown.value,
          0,
        ),
        child: MiddleButton(),
      ),
    );
  }

  final Animation controller;
  final Animation moveUp;
  final Animation moveDown;
  final Animation shake;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }
}
