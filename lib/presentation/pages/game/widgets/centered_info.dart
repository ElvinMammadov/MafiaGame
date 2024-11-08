part of game;

class CenteredInfo extends StatelessWidget {
  const CenteredInfo({
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) => Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: MafiaTheme.themeData.colorScheme.secondary.withOpacity(0.4),
        child: SizedBox(
          height: 100.0,
          width: 300.0,
          child: Center(
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: MafiaTheme.themeData.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ).padding(bottom: 20.0, horizontal: 16.0),
          ),
        ),
      );
}
