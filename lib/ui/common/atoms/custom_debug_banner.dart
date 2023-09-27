import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicapp/shared/config/envs.dart';

class CustomDebugBanner extends StatelessWidget {
  const CustomDebugBanner({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ENVS.environment != 'production'
        ? Stack(
            children: [
              child,
              Positioned(
                right: -20,
                top: 20,
                child: Transform.rotate(
                  angle: (3.14 / 180) * 45,
                  child: Material(
                    elevation: 5.0,
                    child: Container(
                      color: const Color.fromARGB(255, 146, 27, 19),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 1),
                      child: Text(
                        ENVS.environment.toUpperCase().substring(0, 4),
                        style: GoogleFonts.roboto(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        : child;
  }
}
