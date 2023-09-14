import 'package:flutter/material.dart';

class AwesomButton extends StatefulWidget {
  const AwesomButton({super.key, required this.lable, this.onTap});
  final String lable;
  final VoidCallback? onTap;

  @override
  State<AwesomButton> createState() => _AwesomButtonState();
}

class _AwesomButtonState extends State<AwesomButton> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(17),
      child: SizedBox(
        //width: 300,
        height: 60,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Container(
                color: Colors.purple,
              ),
            ),
            SizedBox(
              //width: 300,
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(16.0),
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: widget.onTap,
                child: Center(child: Text(widget.lable)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
