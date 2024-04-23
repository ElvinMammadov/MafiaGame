part of game;

class KilledGamerScreen extends StatefulWidget {
  final Gamer killedGamer;

  const KilledGamerScreen({
    required this.killedGamer,
  });

  @override
  _KilledGamerScreenState createState() => _KilledGamerScreenState();
}

class _KilledGamerScreenState extends State<KilledGamerScreen> {
  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          Material(
            elevation: 8.0,
            shape: const CircleBorder(),
            child: CircleAvatar(
              radius: 100.0,
              child: ClipOval(
                child: Image.network(
                  widget.killedGamer.imageUrl!,
                  fit: BoxFit.fill,
                  height: 200,
                ),
              ),
            ),
          ).padding(
            vertical: 16,
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.transparent,
              minimumSize: const Size(150, 50),
              side: BorderSide(
                color: MafiaTheme.themeData.colorScheme.secondary,
                width: 2,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: () {},
            child: Text(
              widget.killedGamer.name ?? '',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ).padding(vertical: 16),
          const Text(
            AppStrings.duringDayTrial,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ).padding(vertical: 16),
          const Text(
            AppStrings.roleOfGamer,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ).padding(vertical: 16),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.transparent,
              minimumSize: const Size(150, 50),
              side: BorderSide(
                color: MafiaTheme.themeData.colorScheme.secondary,
                width: 2,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: () {},
            child: Text(
              widget.killedGamer.role ?? '',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ).padding(vertical: 16),
        ],
      );
}
