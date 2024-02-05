part of theme;

extension MafiaStyles on MafiaTheme {
  static const String fontFamily = "Roboto";

  static TextStyle displayLarge = GoogleFonts.getFont(
    fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 57.0,
    color: MafiaTheme.themeData.colorScheme.surface,
  );

  static TextStyle displayMedium = GoogleFonts.getFont(
    fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 45.0,
    color: MafiaTheme.themeData.colorScheme.surface,
  );

  static TextStyle displaySmall = GoogleFonts.getFont(
    fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 36.0,
    color: MafiaTheme.themeData.colorScheme.surface,
  );

  static TextStyle headlineLarge = GoogleFonts.getFont(
    fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 32.0,
    color: MafiaTheme.themeData.colorScheme.surface,
  );

  static TextStyle headlineMedium = GoogleFonts.getFont(
    fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 28.0,
    color: MafiaTheme.themeData.colorScheme.surface,
  );

  static TextStyle headlineSmall = GoogleFonts.getFont(
    fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 24.0,
    color: MafiaTheme.themeData.colorScheme.surface,
  );

  static TextStyle titleLarge = GoogleFonts.getFont(
    fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 24.0,
    color: MafiaTheme.themeData.colorScheme.surface,
  );

  static TextStyle titleMedium = GoogleFonts.getFont(
    fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 16.0,
    color: MafiaTheme.themeData.colorScheme.surface,
  );

  static TextStyle titleSmall = GoogleFonts.getFont(
    fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
    color: MafiaTheme.themeData.colorScheme.surface,
  );

  static TextStyle labelLarge = GoogleFonts.getFont(
    fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
    color: MafiaTheme.themeData.colorScheme.surface,
  );

  static TextStyle labelMedium = GoogleFonts.getFont(
    fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 12.0,
    color: MafiaTheme.themeData.colorScheme.surface,
  );
  static TextStyle labelSmall = GoogleFonts.getFont(
    fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 11.0,
    color: MafiaTheme.themeData.colorScheme.surface,
  );

  static TextStyle bodyLarge = GoogleFonts.getFont(
    fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 16.0,
    color: MafiaTheme.themeData.colorScheme.surface,
    height: 1.5,
  );

  static TextStyle bodyMedium = GoogleFonts.getFont(
    fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 14.0,
    color: MafiaTheme.themeData.colorScheme.surface,
  );

  static TextStyle bodySmall = GoogleFonts.getFont(
    fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 12.0,
    color: MafiaTheme.themeData.colorScheme.surface,
  );

  static TextStyle hintTextField = bodyLarge.copyWith(
    color: MafiaTheme.themeData.colorScheme.surface,
  );

  static TextStyle labelTextField = labelLarge.copyWith(
    color: MafiaTheme.themeData.colorScheme.surface,
  );

  static TextStyle inputTextFieldError = bodyMedium.copyWith(
    color: MafiaTheme.themeData.colorScheme.surface,
  );
}
