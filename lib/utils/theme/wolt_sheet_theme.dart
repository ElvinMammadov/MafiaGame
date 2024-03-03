part of theme;

class WoltModalSheetTheme extends WoltModalSheetThemeData {
   WoltModalSheetTheme()
      : super(
    dialogShape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(8.0),
        topLeft: Radius.circular(8.0),
      ),
    ),
     backgroundColor: Colors.transparent,
     navBarHeight: 56,
     maxDialogWidth: 560,
     shadowColor: const Color(0xFFEAD08A),
  );
}
