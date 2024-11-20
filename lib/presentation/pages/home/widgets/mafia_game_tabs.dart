part of home;

class MafiaGameTabs extends StatelessWidget {
  final String label;
  final IconData? icon;

  const MafiaGameTabs({
    required this.label,
    this.icon,
  });

  @override
  Widget build(BuildContext context) => Tab(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              icon,
              size: 24.0,
              color: MafiaTheme.themeData.colorScheme.surface,
            ), // Adjust as needed
            Text(
              label,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w800,
                color: MafiaTheme.themeData.colorScheme.surface,
              ),
            ),
          ],
        ),
      );
}
