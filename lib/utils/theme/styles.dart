part of theme;

extension MafiaStyles on MafiaTheme {
  static const String fontFamily = "Roboto";

  static TextStyle displayLarge = GoogleFonts.getFont(
    fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 57.0,
    color: Colors.white,
  );

  static TextStyle displayMedium = GoogleFonts.getFont(
    fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 45.0,
    color: Colors.white,
  );

  static TextStyle displaySmall = GoogleFonts.getFont(
    fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 36.0,
    color: Colors.white,
  );

  static TextStyle headlineLarge = GoogleFonts.getFont(
    fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 32.0,
    color: Colors.white,
  );

  static TextStyle headlineMedium = GoogleFonts.getFont(
    fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 28.0,
    color: Colors.white,
  );

  static TextStyle headlineSmall = GoogleFonts.getFont(
    fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 24.0,
    color: Colors.white,
  );

  static TextStyle titleLarge = GoogleFonts.getFont(
    fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 24.0,
    color: Colors.white,
  );

  static TextStyle titleMedium = GoogleFonts.getFont(
    fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 16.0,
    color: Colors.white,
  );

  static TextStyle titleSmall = GoogleFonts.getFont(
    fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
    color: Colors.white,
  );

  static TextStyle labelLarge = GoogleFonts.getFont(
    fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
    color: Colors.white,
  );

  static TextStyle labelMedium = GoogleFonts.getFont(
    fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 12.0,
    color: Colors.white,
  );
  static TextStyle labelSmall = GoogleFonts.getFont(
    fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 11.0,
    color: Colors.white,
  );

  static TextStyle bodyLarge = GoogleFonts.getFont(
    fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 16.0,
    color: Colors.white,
    height: 1.5,
  );

  static TextStyle bodyMedium = GoogleFonts.getFont(
    fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 14.0,
    color: Colors.white,
  );

  static TextStyle bodySmall = GoogleFonts.getFont(
    fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 12.0,
    color: Colors.white,
  );

  static TextStyle hintTextField = bodyLarge.copyWith(
    color: Colors.white,
  );

  static TextStyle labelTextField = labelLarge.copyWith(
    color: Colors.white,
  );

  static TextStyle inputTextFieldError = bodyMedium.copyWith(
    color: Colors.white,
  );
}
