import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:unihacks_ui_kit/themes/theme_preference.dart';
import 'package:unihacks_ui_kit/themes/theme_provider.dart';
import 'package:unihacks_ui_kit/themes/themes.dart';
import 'package:yonesto_ui/ui/pages/cart.dart';
import 'package:yonesto_ui/ui/pages/error.dart';
import 'package:yonesto_ui/ui/pages/home.dart';
import 'package:yonesto_ui/ui/pages/sigin.dart';
import 'package:yonesto_ui/ui/pages/splash.dart';

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

class Yonesto extends StatefulWidget {
  const Yonesto({
    super.key,
  });

  @override
  State<Yonesto> createState() => _YonestoState();
}

class _YonestoState extends State<Yonesto> {
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
    final currentTheme = Provider.of<ThemeProvider>(context);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: currentTheme.isDarkTheme()
          ? AppTheme.uniDarkTheme
          : AppTheme.uniLightTheme,
      darkTheme: AppTheme.uniDarkTheme,
      themeMode: ThemeMode.light,
    );
  }
}

class MinimalistAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MinimalistAppBar({
    super.key,
  });

  @override
  State<MinimalistAppBar> createState() => _MinimalistAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MinimalistAppBarState extends State<MinimalistAppBar> {
  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeProvider>(context);
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0.5,
      actions: [
        IconButton(
          onPressed: () {
            if (currentTheme.isDarkTheme()) {
              setState(() {
                currentTheme.setTheme = ThemePreference.LIGHT;
              });
            } else {
              setState(() {
                currentTheme.setTheme = ThemePreference.DARK;
              });
            }
          },
          icon: Icon(
            currentTheme.isDarkTheme() ? Icons.wb_sunny : EvaIcons.moon,
          ),
        ),
      ],
      title: Center(
        child: Text(
          'Sign In',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w200,
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}
