part of home;

class HomeScreenForm extends StatefulWidget {
  final void Function({
    String typeOfGame,
    String typeOfController,
    int numberOfGamers,
    String gameName,
  })? onChange;

  const HomeScreenForm({
    this.onChange,
    super.key,
  });

  @override
  _HomeScreenFormState createState() => _HomeScreenFormState();
}

class _HomeScreenFormState extends State<HomeScreenForm> {
  final TextEditingController _gameNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _gameNameFieldKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<int>> _gamersNumberFieldKey =
      GlobalKey<FormFieldState<int>>();

  final FocusNode _gameNameFocusNode = FocusNode();
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

  String? selectedTypeofGames;
  String? selectedTypeOfController;
  int? selectedNumberOfGamers;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 550,
        child: Card(
          color: Colors.transparent,
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: _gameNameController,
                  style: MafiaTheme.themeData.textTheme.headlineSmall,
                  keyboardType: TextInputType.emailAddress,
                  autofocus: true,
                  key: _gameNameFieldKey,
                  focusNode: _gameNameFocusNode,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    labelText: AppStrings.nameOfGame,
                    labelStyle: MafiaTheme.themeData.textTheme.headlineSmall,
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
                    errorStyle: MafiaTheme.themeData.textTheme.bodySmall,
                  ),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_gameNameFocusNode);
                  },
                  onChanged: (String value) {
                    widget.onChange!(
                      gameName: value,
                    );
                    _updateControllerText(
                      value,
                      _gameNameController,
                    );
                    _gameNameFieldKey.currentState!.validate();
                  },
                  onSaved: (String? value) {
                    _gameNameController.text = value!;
                  },
                  validator: Validator.validateText,
                ).padding(top: 16.0),
                DropdownButtonFormField2<String>(
                  isExpanded: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.padding8,
                    ),
                    labelStyle: MafiaTheme.themeData.textTheme.headlineSmall,
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
                    style: MafiaTheme.themeData.textTheme.headlineSmall,
                  ),
                  value: selectedTypeofGames,
                  items: typeOfGames
                      .map(
                        (String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: MafiaTheme.themeData.textTheme.headlineSmall,
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
                    selectedTypeofGames = value;
                  },
                  onSaved: (String? value) {
                    selectedTypeofGames = value.toString();
                  },
                  iconStyleData: const IconStyleData(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                    ),
                  ),
                  dropdownStyleData: DropdownStyleData(
                    offset: const Offset(35, 0),
                    width: 480,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: MafiaTheme.themeData.colorScheme.primary,
                      border: Border.all(
                        color: MafiaTheme.themeData.colorScheme.secondary,
                      ),
                    ),
                  ),
                ).padding(top: Dimensions.padding16),
                DropdownButtonFormField2<String>(
                  isExpanded: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    labelStyle: MafiaTheme.themeData.textTheme.headlineSmall,
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
                    style: MafiaTheme.themeData.textTheme.headlineSmall,
                  ),
                  value: selectedTypeOfController,
                  items: typeOfController
                      .map(
                        (String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: MafiaTheme.themeData.textTheme.headlineSmall,
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
                    selectedTypeOfController = value;
                  },
                  onSaved: (String? value) {
                    selectedTypeOfController = value.toString();
                  },
                  iconStyleData: const IconStyleData(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                    ),
                  ),
                  dropdownStyleData: DropdownStyleData(
                    offset: const Offset(35, 0),
                    width: 480,
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
                  key: _gamersNumberFieldKey,
                  decoration: InputDecoration(
                    // labelText: 'Choose',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    labelStyle: MafiaTheme.themeData.textTheme.headlineSmall,
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
                    style: MafiaTheme.themeData.textTheme.headlineSmall,
                  ),
                  items: numberOfGamers
                      .map<DropdownMenuItem<int>>(
                        (int item) => DropdownMenuItem<int>(
                          value: item,
                          child: Text(
                            item.toString(),
                            style: MafiaTheme.themeData.textTheme.headlineSmall,
                          ),
                        ),
                      )
                      .toList(),
                  validator: (int? value) {
                    if (value == null) {
                      return AppStrings.gamersNumberIsRequired;
                    }
                    return null;
                  },
                  value: selectedNumberOfGamers,
                  onChanged: (int? value) {
                    widget.onChange!(
                      numberOfGamers: value!,
                    );
                    selectedNumberOfGamers = value;
                  },
                  onSaved: (int? value) {
                    _gamersNumberFieldKey.currentState!.validate();
                    selectedNumberOfGamers = value;
                  },
                  iconStyleData: const IconStyleData(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                    ),
                  ),
                  dropdownStyleData: DropdownStyleData(
                    offset: const Offset(440, 0),
                    width: 70,
                    maxHeight: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.transparent,
                      border: Border.all(
                        color: MafiaTheme.themeData.colorScheme.secondary,
                      ),
                    ),
                  ),
                ).padding(
                  top: Dimensions.padding16,
                ),
              ],
            ),
          ).padding(
            all: Dimensions.padding16,
          ),
        ),
      );
}

// bool _submitForm(BuildContext context, GlobalKey<FormState> formKey) {
//   if (formKey.currentState!.validate()) {
//     formKey.currentState!.save();
//     return true;
//   } else {
//     return false;
//   }
// }

void _updateControllerText(String? value, TextEditingController controller) {
  final TextSelection cursorPosition = controller.selection;
  controller.text = value ?? "";
  controller.selection = cursorPosition;
}
