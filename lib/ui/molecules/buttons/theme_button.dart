import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unicapp/providers/providers.dart';

class ThemeButton extends ConsumerWidget {
  const ThemeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);

    return IconButton(
      onPressed: () {
        ref.read(isDarkModeProvider.notifier).update((state) => !state);
      },
      icon: Icon(
        isDarkMode ? Icons.wb_sunny : EvaIcons.moon,
      ),
    );
  }
}
