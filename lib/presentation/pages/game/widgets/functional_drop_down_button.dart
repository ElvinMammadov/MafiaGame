part of game;

class FunctionalDropDownButton extends StatefulWidget {
  final List<String> items;
  final Function(String)? onChanged;
  final String title;

  const FunctionalDropDownButton({
    required this.items,
    this.onChanged,
    required this.title,
  });

  @override
  _FunctionalDropDownButtonState createState() =>
      _FunctionalDropDownButtonState();
}

class _FunctionalDropDownButtonState extends State<FunctionalDropDownButton> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                widget.title,
                style: MafiaTheme.themeData.textTheme.headlineSmall,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          barrierColor: Colors.black.withOpacity(0.5),
          items: widget.items
              .map(
                (String item) => DropdownMenuItem<String>(
                  value: item,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      minimumSize: const Size(400, 50),
                      side: BorderSide(
                        color: MafiaTheme.themeData.colorScheme.secondary,
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onPressed: () {
                      widget.onChanged!(item);
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      item ,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ).padding(vertical: 4),
                ),
              )
              .toList(),
          // value: selectedValue,
          onChanged: (String? value) {
            widget.onChanged!(value!);
          },
          buttonStyleData: ButtonStyleData(
            height: 48,
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: Colors.black26,
              ),
              color:
                  MafiaTheme.themeData.colorScheme.secondary.withOpacity(0.5),
            ),
            elevation: 2,
          ),
          iconStyleData: IconStyleData(
            icon: const Icon(
              Icons.arrow_forward_ios_outlined,
            ),
            iconSize: 18,
            iconEnabledColor: MafiaTheme.themeData.hintColor,
            iconDisabledColor: Colors.grey,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color:
                  MafiaTheme.themeData.colorScheme.secondary.withOpacity(0.5),
            ),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: MaterialStateProperty.all(6),
              thumbVisibility: MaterialStateProperty.all(true),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 60,
            // padding: EdgeInsets.only(left: 100),
          ),
        ),
      ).padding(
        horizontal: 16,
        vertical: 16,
      );
}
