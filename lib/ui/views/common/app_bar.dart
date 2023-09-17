import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yonesto_ui/ui/widgets/buttons/theme_button.dart';

class UNICappAppBar extends StatefulWidget implements PreferredSizeWidget {
  const UNICappAppBar({
    super.key,
    required this.title,
  });

  final Widget title;

  @override
  State<UNICappAppBar> createState() => _UNICappAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _UNICappAppBarState extends State<UNICappAppBar> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: widget.title,
      titleSpacing: size.width > 750 ? 200 : 0,
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          Scaffold.of(context).openDrawer();
          //context.go('/home');
        },
      ),
    );
  }
}

class MinimalistAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MinimalistAppBar({
    super.key,
    this.leading,
  });

  final Widget? leading;

  @override
  State<MinimalistAppBar> createState() => _MinimalistAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MinimalistAppBarState extends State<MinimalistAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0.5,
      leading: widget.leading,
      title: Stack(
        children: [
          Center(
            child: Text(
              'Sign In',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w200,
                fontSize: 25,
              ),
            ),
          ),
          const Positioned(
            right: -5,
            top: -10,
            child: ThemeButton(),
          )
        ],
      ),
    );
  }
}
