part of theme;

class MafiaTheme {
  const MafiaTheme();

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
        textTheme: MafiaTextTheme(),
        hintColor: Colors.white,
        primaryColor: const Color(0xFFA9001B),
        secondaryHeaderColor: const Color(0xFFEAD08A),
        extensions: <ThemeExtension>[
          WoltModalSheetTheme(),
        ],
      );
}
