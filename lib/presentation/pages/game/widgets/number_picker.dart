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

  @override
  void initState() {
    super.initState();
    animateStates = List<bool>.generate(widget.gamers.length, (int index) =>
    false,);
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
    return null; // Main number not found
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
                        glowColor: Colors.red,
                        glowCount: 1,
                        animate:
                            isMainButtonPressed ? animateStates[index] : false,
                        child: Material(
                          elevation: 8.0,
                          shape: const CircleBorder(),
                          child: CircleAvatar(
                            radius: 50.0,
                            child: ClipOval(
                              child: Image.network(
                                widget.gamers[index].imageUrl!,
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
                  widget.deletedGamer!(
                    getGamerAtIndex(
                      findGamerWithMainNumber(
                        buttonNumber,
                        gamerSelectedNumbers,
                      )!,
                      widget.gamers,
                    ),
                  );
                }
                if (selectedButton == null && mainButton == null) {
                  setState(() {
                    mainButton = buttonNumber;
                    isMainButtonPressed = true;
                  });
                } else if (selectedButton == null && mainButton != null) {
                  setState(() {
                    selectedButton = buttonNumber;
                    selectedButtons.add(buttonNumber);
                  });
                } else if (selectedButton != null) {
                  setState(() {
                    selectedButton = buttonNumber;
                    selectedButtons.add(buttonNumber);
                  });
                }
              },
              mainButton: mainButton,
              selectedButton: selectedButton,
              selectedButtons: selectedButtons,
            ),
          ],
        ).padding(
          vertical: 46,
          horizontal: 32,
        ),
      );
}
