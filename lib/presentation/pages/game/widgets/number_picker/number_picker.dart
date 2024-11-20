part of game;

class NumberPicker extends StatefulWidget {
  final List<Gamer> gamers;
  final Function(Gamer)? deletedGamer;

  const NumberPicker({
    required this.gamers,
    this.deletedGamer,
  });

  @override
  _NumberPickerState createState() => _NumberPickerState();
}

class _NumberPickerState extends State<NumberPicker> {
  late List<bool> animateStates;
  int? mainButton;
  int? selectedButton;
  int? selectedGamer;
  List<int> selectedButtons = <int>[];
  Map<int, int?> gamerSelectedNumbers = <int, int?>{};
  int quantityOfButtons = 8;
  bool isMainButtonPressed = false;
  VoteDirection? pickedDirection = VoteDirection.NotSet;

  @override
  void initState() {
    super.initState();
    animateStates = List<bool>.generate(
      widget.gamers.length,
      (int index) => false,
    );
    if (widget.gamers.length == 3) {
      quantityOfButtons = 9;
    } else if (widget.gamers.length > 3) {
      quantityOfButtons = 10;
    }
    widget.gamers.asMap().forEach((int index, Gamer gamer) {
      gamerSelectedNumbers[index] = null;
    });
  }

  void assignNumberToGamer(int gamerIndex, int number) {
    setState(() {
      gamerSelectedNumbers[gamerIndex] = number;
    });
  }

  int? findGamerWithMainNumber(
    int mainNumber,
    Map<int, int?> gamerSelectedNumbers,
  ) {
    for (final MapEntry<int, int?> entry in gamerSelectedNumbers.entries) {
      if (entry.value == mainNumber) {
        return entry.key;
      }
    }
    return null;
  }

  Gamer getGamerAtIndex(int index, List<Gamer> gamers) => gamers[index];

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 170,
              width: 500,
              child: ListView.builder(
                itemCount: widget.gamers.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) =>
                    GestureDetector(
                  onTap: () {
                    if (isMainButtonPressed) {
                      selectedGamer = index;
                      setState(() {
                        for (int i = 0; i < widget.gamers.length; i++) {
                          animateStates[i] = (i == index);
                        }
                      });
                    }
                  },
                  child: Column(
                    children: <Widget>[
                      AvatarGlow(
                        glowColor: Colors.orange,
                        glowCount: 1,
                        // glowRadiusFactor: 0.4,
                        curve: Curves.easeInOut,
                        animate: isMainButtonPressed && animateStates[index],
                        child: Material(
                          elevation: 8.0,
                          shape: const CircleBorder(),
                          child: CircleAvatar(
                            radius: 50.0,
                            child: ClipOval(
                              child: widget.gamers[index].hasImage
                                  ? Image.network(
                                      widget.gamers[index].imageUrl!,
                                      fit: BoxFit.fill,
                                      height: 100,
                                    )
                                  : Image.asset(
                                      'assets/logo_m.png',
                                      fit: BoxFit.fill,
                                      height: 100,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          minimumSize: const Size(60, 30),
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
                          widget.gamers.isNotEmpty
                              ? '${widget.gamers[index].name}'
                              : '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ).padding(
                        top: 8,
                      ),
                    ],
                  ),
                ).padding(
                  horizontal: 16,
                ),
              ),
            ),
            const Divider(
              thickness: 1,
              color: Colors.black,
            ).padding(
              bottom: 46,
              top: 16,
            ),
            NumberButtons(
              number: quantityOfButtons,
              onPressed: (int buttonNumber) {
                // Adjust index
                if (selectedGamer != null &&
                    selectedGamer! >= 0 &&
                    selectedGamer! < widget.gamers.length) {
                  assignNumberToGamer(selectedGamer!, buttonNumber);
                }
                if (buttonNumber == mainButton && mainButton != null) {
                  final Gamer deletedGamer = getGamerAtIndex(
                    findGamerWithMainNumber(
                      buttonNumber,
                      gamerSelectedNumbers,
                    )!,
                    widget.gamers,
                  );
                  for (final Gamer gamer in widget.gamers) {
                    if (gamer.id != deletedGamer.id) {
                      BlocProvider.of<GameBloc>(context).add(
                        RemoveVote(gamer: gamer),
                      );
                    }
                  }
                  widget.deletedGamer!(
                    deletedGamer,
                  );
                }
                if (selectedButton == null && mainButton == null) {
                  setState(() {
                    mainButton = buttonNumber;
                    isMainButtonPressed = true;
                  });
                } else if (selectedButton == null && mainButton != null) {
                  _assignSelectedGamer(buttonNumber);
                } else if (selectedButton != null) {
                  _assignSelectedGamer(buttonNumber);
                }
              },
              mainButton: mainButton,
              selectedButton: selectedButton,
              selectedButtons: selectedButtons,
            ),
            const Divider(
              thickness: 1,
              color: Colors.black,
            ),
            if (pickedDirection == VoteDirection.NotSet && mainButton != null)
              PickedDirection(
                isMainButtonPressed: selectedGamer != null,
                pickedDirection: (VoteDirection direction) {
                  setState(() {
                    pickedDirection = direction;
                  });
                },
              ),
          ],
        ).padding(
          vertical: 46,
          horizontal: 32,
        ),
      );

  void _assignSelectedGamer(int buttonNumber) {
    setState(() {
      selectedButton = buttonNumber;
      selectedButtons.add(buttonNumber);
    });
    if (pickedDirection == VoteDirection.Left) {
      selectedGamer =
          (selectedGamer! - 1 + widget.gamers.length) % widget.gamers.length;
    } else if (pickedDirection == VoteDirection.Right) {
      selectedGamer = (selectedGamer! + 1) % widget.gamers.length;
    }
    for (int i = 0; i < widget.gamers.length; i++) {
      animateStates[i] = (i == selectedGamer);
    }
  }
}
