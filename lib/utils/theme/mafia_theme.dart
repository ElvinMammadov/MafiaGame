part of theme;

class MafiaTheme extends InheritedWidget {
  const MafiaTheme({required super.child, super.key});

  static ThemeData get themeData => ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFFA9001B),
          onPrimary: Color(0xFFA9001B),
          secondary: Color(0xFFEAD08A),
          onSecondary: Color(0xFFEAD08A),
          error: Colors.red,
          onError: Colors.red,
          background: Colors.black,
          onBackground: Colors.black,
          surface: Colors.white,
          onSurface: Colors.white,
        ),
      );

  static MafiaTheme? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<MafiaTheme>();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
