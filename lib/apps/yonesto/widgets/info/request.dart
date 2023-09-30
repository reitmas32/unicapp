import 'package:flutter/material.dart';
import 'package:flutter_loading_animation_kit/flutter_loading_animation_kit.dart';
import 'package:icon_animated/icon_animated.dart';

class ProccessRequest extends StatelessWidget {
  const ProccessRequest({
    super.key,
    required this.lable,
  });

  final String lable;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const FourCirclePulse(
          circleColor: Colors.purple, //The color of the circles
          dimension: 100, // The size of the widget.
          turns: 3, //Turns in each loop
          loopDuration: Duration(
            seconds: 1,
          ), // Duration of each loop
          curve: Curves.linear, //Curve of the animation
        ),
        Text(lable),
      ],
    );
  }
}

class SuccessRequest extends StatelessWidget {
  const SuccessRequest({
    super.key,
    required this.lable,
  });

  final String lable;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const IconAnimated(
          color: Colors.green,
          active: true, // boolean
          size: 100,
          iconType: IconType.check,
        ),
        Text(lable),
      ],
    );
  }
}

class ErrorRequest extends StatelessWidget {
  const ErrorRequest({
    super.key,
    this.lable = '',
  });

  final String lable;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const IconAnimated(
          color: Colors.red,
          active: true, // boolean
          size: 100,
          iconType: IconType.fail,
        ),
        Text(lable),
      ],
    );
  }
}

class AlertDialogRequest extends StatelessWidget {
  const AlertDialogRequest({
    super.key,
    required this.child,
    this.initProccess = false,
    this.responseSuccess = false,
    this.detachProccess = false,
    this.actions,
    required this.lable,
    required this.successLable,
    required this.errorLable,
  });

  final Widget child;

  final bool responseSuccess;
  final bool initProccess;
  final bool detachProccess;
  final String lable;
  final String successLable;
  final String errorLable;

  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: !initProccess
          ? child
          : Container(
              child: !detachProccess
                  ? ProccessRequest(
                      lable: lable,
                    )
                  : responseSuccess
                      ? SuccessRequest(
                          lable: successLable,
                        )
                      : ErrorRequest(lable: errorLable),
            ),
      actions: actions,
    );
  }
}
