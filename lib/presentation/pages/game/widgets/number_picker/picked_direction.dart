part of game;

class PickedDirection extends StatelessWidget {
  final Function(VoteDirection)? pickedDirection;
  final bool isMainButtonPressed;

  const PickedDirection({
    this.pickedDirection,
    this.isMainButtonPressed = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          Text(
            isMainButtonPressed
                ? AppStrings.chooseDirection
                : AppStrings.chooseFirstGamer,
            style: MafiaTheme.themeData.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ).padding(bottom: 20.0),
          if(isMainButtonPressed)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Card(
                elevation: 5,
                color:
                    MafiaTheme.themeData.colorScheme.secondary.withOpacity(0.4),
                child: SizedBox(
                  width: 80.0,
                  child: IconButton(
                    iconSize: 30.0,
                    color: MafiaTheme.themeData.colorScheme.secondary,
                    onPressed: () {
                      pickedDirection?.call(VoteDirection.Left);
                    },
                    icon: const Icon(Icons.arrow_back_outlined),
                  ),
                ),
              ).padding(right: 16.0),
              Card(
                elevation: 5,
                color:
                    MafiaTheme.themeData.colorScheme.secondary.withOpacity(0.4),
                child: SizedBox(
                  width: 80.0,
                  child: IconButton(
                    iconSize: 30.0,
                    color: MafiaTheme.themeData.colorScheme.secondary,
                    onPressed: () {
                      pickedDirection?.call(VoteDirection.Right);
                    },
                    icon: const Icon(Icons.arrow_forward_outlined),
                  ),
                ),
              ),
            ],
          ),
        ],
      ).padding(
        horizontal: 16.0,
        vertical: 16.0,
      );
}
