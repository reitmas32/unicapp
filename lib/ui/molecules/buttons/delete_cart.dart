import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yonesto_ui/providers/providers.dart';
import 'package:yonesto_ui/ui/atoms/package.dart';

class DeleteCartButton extends ConsumerWidget {
  const DeleteCartButton({super.key, this.productName = '', this.onTap});

  final VoidCallback? onTap;
  final String productName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);
    return InkWell(
      onTap: () {
        onTap!();

        ScaffoldMessenger.of(context)
            .showSnackBar(generateSnackBar(isDarkMode));
      },
      child: const Icon(Icons.delete),
    );
  }

  generateSnackBar(bool isDarkMode) => SnackBar(
        content: Text(
          '¡Se Eliminaron todos los $productName del Carrito!',
          style: TextStyle(
            color: isDarkMode ? CustomColors.textDark : CustomColors.textLight,
          ),
        ),
        duration: const Duration(milliseconds: 750),
        backgroundColor: isDarkMode
            ? CustomColors.snackBarBgDark
            : CustomColors.snackBarBgLight, // Duración de la visibilidad
      );
}
