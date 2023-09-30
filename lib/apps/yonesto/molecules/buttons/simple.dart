import 'package:flutter/material.dart';
import '../../atoms/package.dart';

class SimpleButton extends StatefulWidget {
  const SimpleButton({super.key, required this.lable, this.onTap});
  final String lable;
  final VoidCallback? onTap;

  @override
  State<SimpleButton> createState() => _SimpleButtonState();
}

class _SimpleButtonState extends State<SimpleButton> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BordersRadius.br500,
      child: SizedBox(
        //width: 300,
        height: 60,
        child: Stack(
          children: <Widget>[
            const BackgroudButton(),
            SizedBox(
              //width: 300,
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  padding: Paddings.p400,
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: widget.onTap,
                child: Center(
                  child: Text(widget.lable),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
