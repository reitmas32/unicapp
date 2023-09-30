import 'package:flutter/material.dart';

class BackgroudButton extends StatelessWidget {
  const BackgroudButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: Colors.purple,
      ),
    );
  }
}
