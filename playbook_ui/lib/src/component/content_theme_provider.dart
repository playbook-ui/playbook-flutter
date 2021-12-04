import 'package:flutter/material.dart';

class ContentThemeProvider extends InheritedWidget {
  const ContentThemeProvider({
    Key? key,
    required Widget child,
    required this.theme,
  }) : super(key: key, child: child);

  final ThemeData theme;

  static ContentThemeProvider of(BuildContext context) {
    // TODO(Keeeeen): 確認
    return context.dependOnInheritedWidgetOfExactType<ContentThemeProvider>()!;
  }

  @override
  bool updateShouldNotify(covariant ContentThemeProvider oldWidget) => false;
}
