part of home;

class MafiaGameTabs extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Widget? imageIcon;

  const MafiaGameTabs({
    required this.label,
    this.icon,
    this.imageIcon,
  });

  @override
  Widget build(BuildContext context) => Tab(
    child: Column(
      children: <Widget>[
        if(icon == null)
          imageIcon!.padding(
            top: 12.0,
            bottom: 6.0,
          )else // Adjust as needed
          Icon(
            icon,
            size: 24.0,
            color: MafiaTheme.themeData.colorScheme.surface,
          ).padding(
            top: 10.0,
            bottom: 4.0,
          ), // Adjust as needed
        Text(
          label,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w800,
            color: MafiaTheme.themeData.colorScheme.surface,
          ),
        ),
      ],
    ),
  );
}
