import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unihacks_ui_kit/buttons/theme_swtcher.dart';

class YonestoAppBar extends StatefulWidget implements PreferredSizeWidget {
  const YonestoAppBar({
    super.key,
    required this.title,
  });

  final Widget title;

  @override
  State<YonestoAppBar> createState() => _YonestoAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _YonestoAppBarState extends State<YonestoAppBar> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: widget.title,
      titleSpacing: size.width > 750 ? 200 : 0,
      actions: const [
        ThemeSwitcher(),
      ],
      leading: IconButton(
        icon: Icon(Icons.home),
        onPressed: () {
          context.go('/home');
        },
      ),
    );
  }
}
