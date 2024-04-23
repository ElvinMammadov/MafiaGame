part of game;

class NumberButtons extends StatelessWidget {
  final int number;
  final Function(int) onPressed;
  final int? mainButton;
  final int? selectedButton;
  final List<int> selectedButtons;

  const NumberButtons({
    required this.number,
    required this.onPressed,
    required this.mainButton,
    required this.selectedButton,
    required this.selectedButtons,
    super.key,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 200,
    width: 400,
    child: GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: number,
      itemBuilder: (BuildContext context, int index) => NumberButton(
        number: index + 1,
        onPressed: () {
          onPressed(index + 1);
        },
        isMainButton: mainButton == index + 1,
        isSelected: selectedButtons.contains(index + 1),
      ),
    ),
  );
}

class NumberButton extends StatelessWidget {
  final int number;
  final VoidCallback onPressed;
  final bool isMainButton;
  final bool isSelected;

  const NumberButton({
    required this.number,
    required this.onPressed,
    required this.isMainButton,
    required this.isSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Material(
      color: isMainButton
          ? Colors.red
          : isSelected
          ? theme.colorScheme.secondary.withOpacity(0.8)
          : Colors.transparent,
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(
          color: theme.colorScheme.secondary,
        ), // Customize border color and width
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          width: 50.0,
          height: 50.0,
          alignment: Alignment.center,
          child: Text(
            '$number',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
