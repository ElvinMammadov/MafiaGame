part of home;

class HomeScreenForm extends StatefulWidget {
  final void Function({
    String typeOfGame,
    String typeOfController,
    int numberOfGamers,
    String gameName,
  })? onChange;

  HomeScreenForm({
    this.onChange,
    super.key,
  });

  final TextEditingController _gameNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FocusNode _gameNameFocusNode = FocusNode();

  @override
  _HomeScreenFormState createState() => _HomeScreenFormState();
}

class _HomeScreenFormState extends State<HomeScreenForm> {
  final List<String> typeOfGames = <String>[
    AppStrings.open,
    AppStrings.close,
  ];
  final List<String> typeOfController = <String>[
    AppStrings.controller,
    AppStrings.application,
  ];
  final List<int> numberOfGamers =
      List<int>.generate(23, (int index) => index + 1);

  String selectedValue = 'Option 1';

  @override
  Widget build(BuildContext context) => Card(
        color: Colors.transparent,
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Form(
          key: widget._formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: widget._gameNameController,
                style: MafiaTheme.themeData.textTheme.titleMedium,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  labelText: AppStrings.nameOfGame,
                  labelStyle: MafiaTheme.themeData.textTheme.titleMedium,
                  icon: Icon(
                    Icons.gamepad,
                    color: MafiaTheme.themeData.colorScheme.secondary,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: MafiaTheme.themeData.colorScheme.secondary,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: MafiaTheme.themeData.colorScheme.secondary,
                    ),
                  ),
                ),
                onFieldSubmitted: (_) {
                  FocusScope.of(context)
                      .requestFocus(widget._gameNameFocusNode);
                },
                onChanged: (String value) {
                  widget.onChange!(
                    gameName: value,
                  );
                },
                onSaved: (String? value) {
                  selectedValue = value!;
                },
                validator: Validator.validateText,
              ).padding(top: 16.0),
              DropdownButtonFormField2<String>(
                isExpanded: true,
                decoration: InputDecoration(
                  // labelText: 'Choose',
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.padding8,
                  ),
                  labelStyle: MafiaTheme.themeData.textTheme.displaySmall,
                  icon: Icon(
                    Icons.videogame_asset,
                    color: MafiaTheme.themeData.colorScheme.secondary,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: MafiaTheme.themeData.colorScheme.secondary,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: MafiaTheme.themeData.colorScheme.secondary,
                    ),
                  ),
                ),
                hint: Text(
                  AppStrings.typeOfGame,
                  style: MafiaTheme.themeData.textTheme.displaySmall,
                ),
                items: typeOfGames
                    .map(
                      (String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: MafiaTheme.themeData.textTheme.titleMedium,
                        ),
                      ),
                    )
                    .toList(),
                validator: (String? value) {
                  if (value == null) {
                    return 'Please select gender.';
                  }
                  return null;
                },
                onChanged: (String? value) {
                  widget.onChange!(
                    typeOfGame: value!,
                  );
                },
                onSaved: (String? value) {
                  selectedValue = value.toString();
                },
                // buttonStyleData: const ButtonStyleData(
                //   padding: EdgeInsets.only(right: 5),
                // ),

                iconStyleData: const IconStyleData(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.grey,
                  ),
                ),
                dropdownStyleData: DropdownStyleData(
                  offset: const Offset(35, 0),
                  width: 375,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: MafiaTheme.themeData.colorScheme.primary,
                    border: Border.all(
                      color: MafiaTheme.themeData.colorScheme.secondary,
                    ),
                  ),
                ),
                // menuItemStyleData: const MenuItemStyleData(
                //   padding: EdgeInsets.symmetric(horizontal: 16),
                // ),
              ).padding(top: Dimensions.padding16),
              DropdownButtonFormField2<String>(
                isExpanded: true,
                decoration: InputDecoration(
                  // labelText: 'Choose',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  labelStyle: MafiaTheme.themeData.textTheme.displaySmall,
                  icon: Icon(
                    Icons.interpreter_mode_rounded,
                    color: MafiaTheme.themeData.colorScheme.secondary,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: MafiaTheme.themeData.colorScheme.secondary,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: MafiaTheme.themeData.colorScheme.secondary,
                    ),
                  ),
                ),
                hint: Text(
                  AppStrings.typeOfController,
                  style: MafiaTheme.themeData.textTheme.displaySmall,
                ),
                items: typeOfController
                    .map(
                      (String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: MafiaTheme.themeData.textTheme.titleMedium,
                        ),
                      ),
                    )
                    .toList(),
                validator: (String? value) {
                  if (value == null) {
                    return 'Please select gender.';
                  }
                  return null;
                },
                onChanged: (String? value) {
                  widget.onChange!(
                    typeOfController: value!,
                  );
                },
                onSaved: (String? value) {
                  selectedValue = value.toString();
                },
                // buttonStyleData: const ButtonStyleData(
                //   padding: EdgeInsets.only(right: 5),
                // ),

                iconStyleData: const IconStyleData(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.grey,
                  ),
                ),
                dropdownStyleData: DropdownStyleData(
                  offset: const Offset(35, 0),
                  width: 375,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: MafiaTheme.themeData.colorScheme.primary,
                    border: Border.all(
                      color: MafiaTheme.themeData.colorScheme.secondary,
                    ),
                  ),
                ),
                // menuItemStyleData: const MenuItemStyleData(
                //   padding: EdgeInsets.symmetric(horizontal: 16),
                // ),
              ).padding(top: Dimensions.padding16),
              DropdownButtonFormField2<int>(
                isExpanded: true,
                decoration: InputDecoration(
                  // labelText: 'Choose',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  labelStyle: MafiaTheme.themeData.textTheme.displaySmall,
                  icon: Icon(
                    Icons.pin,
                    color: MafiaTheme.themeData.colorScheme.secondary,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: MafiaTheme.themeData.colorScheme.secondary,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: MafiaTheme.themeData.colorScheme.secondary,
                    ),
                  ),
                ),
                hint: Text(
                  AppStrings.numberOfGamers,
                  style: MafiaTheme.themeData.textTheme.displaySmall,
                ),
                items: numberOfGamers
                    .map<DropdownMenuItem<int>>(
                      (int item) => DropdownMenuItem<int>(
                        value: item,
                        child: Text(
                          item.toString(), // Convert int to String
                          style: MafiaTheme.themeData.textTheme.titleMedium,
                        ),
                      ),
                    )
                    .toList(),
                validator: (int? value) {
                  if (value == null) {
                    return 'Please select gender.';
                  }
                  return null;
                },
                onChanged: (int? value) {
                  widget.onChange!(
                    numberOfGamers: value!,
                  );
                },
                onSaved: (int? value) {
                  selectedValue = value.toString();
                },
                // buttonStyleData: const ButtonStyleData(
                //   padding: EdgeInsets.only(right: 5),
                // ),

                iconStyleData: const IconStyleData(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.grey,
                  ),
                ),
                dropdownStyleData: DropdownStyleData(
                  offset: const Offset(340, 0),
                  width: 70,
                  maxHeight: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: MafiaTheme.themeData.colorScheme.primary,
                    border: Border.all(
                      color: MafiaTheme.themeData.colorScheme.secondary,
                    ),
                  ),
                ),
                // menuItemStyleData: const MenuItemStyleData(
                //   padding: EdgeInsets.symmetric(horizontal: 16),
                // ),
              ).padding(top: Dimensions.padding16),
            ],
          ),
        ).padding(all: Dimensions.padding16),
      );
}
