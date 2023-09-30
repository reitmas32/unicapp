import 'package:flutter/material.dart';
import '../../atoms/package.dart';

class UpdateCartButton extends StatelessWidget {
  const UpdateCartButton({
    super.key,
    required this.iconData,
    required this.avalible,
    this.onTap,
  });

  final bool avalible;
  final VoidCallback? onTap;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      onTap: avalible ? onTap : null,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          width: size.width > 750 ? 40 : 25,
          decoration: BoxDecoration(
            borderRadius: BordersRadius.br100,
            color: avalible
                ? Colors.purple
                : const Color.fromARGB(255, 101, 69, 107),
          ),
          child: Icon(
            iconData,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
