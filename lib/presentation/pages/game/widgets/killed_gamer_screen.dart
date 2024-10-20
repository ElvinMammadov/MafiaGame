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
              radius: 70.0,
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
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _divider(),
                _buildTextRow(
                  AppStrings.nameOfGamer,
                  widget.killedGamer.name ?? '',
                ),
                _divider(),
                _buildTextRow(
                  AppStrings.roleOfGamer,
                  widget.killedGamer.role.name,
                ),
                _divider(),
                if (widget.isKillerExist)
                  _buildTextRow(
                    AppStrings.roleOfKiller,
                    _rolesOfKiller,
                  ),
              ],
            ).padding(
              vertical: 8,
              horizontal: 16,
            ),
          ).padding(
            top: 8,
            horizontal: 32,
            bottom: 16,
          ),
        ],
      );

  Widget _divider() => const Divider(
        height: 8.0,
        thickness: 1.0,
        color: Colors.white24, // Subtle divider
      );

  Widget _buildTextRow(String labelText, String text) => Row(
        children: <Widget>[
          Text(
            '$labelText:  ',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ).padding(
        vertical: 8,
        horizontal: 16,
      );

  String get _rolesOfKiller {
    late String rolesOfKiller = '';
    if (widget.killedGamer.wasKilledByMafia &&
        widget.killedGamer.wasKilledByKiller) {
      rolesOfKiller +=
          '${const Mafia.empty().name} ${const Killer.empty().name}';
    } else if (widget.killedGamer.wasKilledByMafia) {
      rolesOfKiller += const Mafia.empty().name;
    } else if (widget.killedGamer.wasKilledByKiller) {
      rolesOfKiller += const Killer.empty().name;
    } else if (widget.killedGamer.wasKilledBySheriff) {
      return rolesOfKiller + const Sheriff.empty().name;
    } else if (!widget.killedGamer.wasKilledByKiller &&
        !widget.killedGamer.wasKilledByMafia &&
        !widget.killedGamer.wasBoomeranged &&
        widget.killedGamer.role.roleType == RoleType.Security) {
      return rolesOfKiller + AppStrings.securitySacrificedHimself;
    } else if (widget.killedGamer.wasKilledByWerewolf) {
      return rolesOfKiller + const Werewolf.empty().name;
    } else if (widget.killedGamer.wasBoomeranged) {
      return rolesOfKiller + AppStrings.gamerBoomeranged;
    }
    return rolesOfKiller;
  }
}
