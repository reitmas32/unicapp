import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unicapp/apps/yonesto/providers/providers.dart';
import 'package:unicapp/ui/common/atoms/circular_button.dart';

class AppButton extends ConsumerWidget {
  const AppButton({
    super.key,
    required this.backgroundColor,
    required this.route,
    required this.iconData,
    required this.lable,
  });

  final Color backgroundColor;
  final String route;
  final IconData iconData;
  final String lable;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final isDarkTheme = ref.watch(isDarkModeProvider);
    return SizedBox(
      width: size.width / 3,
      child: Column(
        children: [
          CircularButton(
            backgroundColor: backgroundColor,
            onTap: route != '' ? () => context.go(route) : null,
            child: Icon(
              iconData,
              color: isDarkTheme
                  ? Colors.white
                  : const Color.fromARGB(255, 49, 49, 49),
            ),
          ),
          Text(lable)
        ],
      ),
    );
  }
}
