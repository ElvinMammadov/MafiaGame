part of game;

class KilledGamerScreen extends StatefulWidget {
  final Gamer killedGamer;
  final String title;
  final bool isKillerExist;

  const KilledGamerScreen({
    required this.killedGamer,
    required this.title,
    this.isKillerExist = false,
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
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            color: MafiaTheme.themeData.colorScheme.secondary.withOpacity(0.5),
            child: Column(
              children: <Widget>[
                Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(
                  height: 16.0,
                  thickness: 1.0,
                  color: Colors.white24, // Subtle divider
                ),
                _buildTextRow(
                  AppStrings.nameOfGamer,
                  widget.killedGamer.name ?? '',
                ),
                const Divider(
                  height: 16.0,
                  thickness: 1.0,
                  color: Colors.white24, // Subtle divider
                ),
                _buildTextRow(
                  AppStrings.roleOfGamer,
                  widget.killedGamer.role?.name ?? '',
                ),
                const Divider(
                  height: 16.0,
                  thickness: 1.0,
                  color: Colors.white24, // Subtle divider
                ),
                if (widget.isKillerExist)
                  _buildTextRow(
                    AppStrings.roleOfKiller,
                    widget.killedGamer.wasKilledByMafia
                        ? const Mafia.empty().name
                        : widget.killedGamer.wasKilledByKiller
                        ? const Killer.empty().name
                        : const Sheriff.empty().name,
                  ),
              ],
            ).padding(
              vertical: 16,
              horizontal: 16,
            ),
          ).padding(
            top: 16,
            horizontal: 32,
            bottom: 32,
          ),
        ],
      );

  Widget _buildTextRow(String labelText, String text) => Row(
        children: <Widget>[
          Text(
            '$labelText:  ',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ).padding(
        vertical: 16,
        horizontal: 16,
      );
}
