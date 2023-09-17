import 'package:flutter/material.dart';
import 'package:flutter_loading_animation_kit/flutter_loading_animation_kit.dart';
import 'package:icon_animated/icon_animated.dart';

class ProccessRequest extends StatelessWidget {
  const ProccessRequest({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FourCirclePulse(
          circleColor: Colors.purple, //The color of the circles
          dimension: 100, // The size of the widget.
          turns: 3, //Turns in each loop
          loopDuration: Duration(
            seconds: 1,
          ), // Duration of each loop
          curve: Curves.linear, //Curve of the animation
        ),
        Text('Procesando Compra'),
      ],
    );
  }
}

class SuccessRequest extends StatelessWidget {
  const SuccessRequest({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconAnimated(
          color: Colors.green,
          active: true, // boolean
          size: 100,
          iconType: IconType.check,
        ),
        Text('Disfruta tu compra'),
      ],
    );
  }
}

class ErrorRequest extends StatelessWidget {
  const ErrorRequest({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconAnimated(
          color: Colors.red,
          active: true, // boolean
          size: 100,
          iconType: IconType.fail,
        ),
        Text('Hubo un Error en tu compra'),
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
  });

  final Widget child;

  final bool responseSuccess;
  final bool initProccess;
  final bool detachProccess;

  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: !initProccess
          ? child
          : Container(
              child: !detachProccess
                  ? const ProccessRequest()
                  : responseSuccess
                      ? const SuccessRequest()
                      : const ErrorRequest(),
            ),
      actions: actions,
    );
  }
}
