import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unicapp/shared/providers/theme.dart';
import 'package:unicapp/ui/common/molecules/search_bar.dart';

class YonestoSearchBar extends ConsumerStatefulWidget {
  YonestoSearchBar({super.key, required this.onChanged});

  final dynamic Function(String) onChanged;

  @override
  ConsumerState<YonestoSearchBar> createState() => _YonestoSearchBarState();
}

class _YonestoSearchBarState extends ConsumerState<YonestoSearchBar> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = ref.watch(isDarkModeProvider);
    return UicappAnimationSearchBar(
      backIconColor: Colors.white,
      centerTitle: 'Yonesto',
      textStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
      centerTitleStyle:
          TextStyle(color: Theme.of(context).colorScheme.onPrimary),
      searchIconColor: Theme.of(context).colorScheme.onPrimary,
      closeIconColor: Theme.of(context).colorScheme.onPrimary,
      hintStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
      searchFieldDecoration: BoxDecoration(
        color: Colors.black.withOpacity(.05),
        border: Border.all(
            color: isDarkTheme
                ? Colors.white.withOpacity(.2)
                : Colors.black.withOpacity(.2),
            width: .5),
        borderRadius: BorderRadius.circular(15),
      ),
      onChanged: (value) => widget.onChanged(controller.text),
      searchTextEditingController: controller,
      horizontalPadding: 5,
      searchBarWidth: MediaQuery.of(context).size.width - 100,
      isBackButtonVisible: false,
    );
  }
}
