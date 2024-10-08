import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yonesto_ui/providers/providers.dart';
import 'package:yonesto_ui/ui/pages/cart.dart';
import 'package:yonesto_ui/ui/pages/error.dart';
import 'package:yonesto_ui/ui/pages/home.dart';
import 'package:yonesto_ui/ui/pages/sigin.dart';

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        ScaleTransition(scale: animation, child: child),
  );
}

class Yonesto extends ConsumerStatefulWidget {
  const Yonesto({
    super.key,
  });

  @override
  ConsumerState<Yonesto> createState() => _YonestoState();
}

class _YonestoState extends ConsumerState<Yonesto> {
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => const SingInPage(),
      ),
      GoRoute(
        path: "/home",
        builder: (context, state) => const HomePage(),
        pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
          context: context,
          state: state,
          child: const HomePage(),
        ),
      ),
      GoRoute(
        path: "/cart",
        builder: (context, state) => const CartPage(),
        pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
          context: context,
          state: state,
          child: const CartPage(),
        ),
      ),
    ],
    errorBuilder: (context, state) => const ErrorPage(),
  );

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(isDarkModeProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: isDarkMode ? AppTheme.uniDarkTheme : AppTheme.uniLightTheme,
      darkTheme: AppTheme.uniDarkTheme,
      themeMode: ThemeMode.light,
    );
  }
}
