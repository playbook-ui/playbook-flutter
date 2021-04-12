import 'package:flutter/material.dart';

class ThemeProvider extends InheritedWidget {
  const ThemeProvider({
    Key? key,
    required Widget child,
    required this.theme,
  }) : super(key: key, child: child);

  final ThemeData theme;

  static ThemeProvider of(BuildContext context) {
    // TODO(Keeeeen): 確認
    return context.dependOnInheritedWidgetOfExactType<ThemeProvider>()!;
  }

  @override
  bool updateShouldNotify(covariant ThemeProvider oldWidget) => false;
}
