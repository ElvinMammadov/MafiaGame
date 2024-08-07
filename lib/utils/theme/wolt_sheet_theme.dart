part of theme;

class WoltModalSheetTheme extends WoltModalSheetThemeData {
   const WoltModalSheetTheme()
      : super(
    dialogShape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(16),
      ),
    ),
     bottomSheetShape: const RoundedRectangleBorder(
       borderRadius: BorderRadius.only(
         topRight: Radius.circular(16),
         topLeft: Radius.circular(16),
       ),
     ),
     backgroundColor: Colors.transparent,
     // maxDialogWidth: 560,
     shadowColor: const Color(0xFFEAD08A),
  );
}
