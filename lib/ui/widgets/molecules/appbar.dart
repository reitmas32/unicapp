import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unicapp/providers/providers.dart';

class YonestoSearchBar extends ConsumerWidget {
  const YonestoSearchBar({super.key, this.onChanged});

  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor: isDarkMode
              ? const Color.fromARGB(255, 35, 34, 34)
              : const Color.fromARGB(255, 199, 197, 197),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          hintText: "eg: CocaCola",
          suffixIcon: const Icon(
            Icons.search,
            color: Colors.purple,
          ),
        ),
      ),
    );
  }
}
