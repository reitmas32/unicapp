import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  const CircularButton(
      {super.key,
      required this.child,
      required this.backgroundColor,
      this.onTap,
      this.height = 60,
      this.width = 60});

  final Widget child;
  final Color backgroundColor;
  final VoidCallback? onTap;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: height,
            width: width,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                50,
              ),
              color: onTap == null
                  ? backgroundColor.withAlpha(100)
                  : backgroundColor,
            ),
          ),
          child,
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(
              50,
            ),
            child: Container(
              height: height + 10,
              width: width + 10,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  50,
                ),
                color: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
