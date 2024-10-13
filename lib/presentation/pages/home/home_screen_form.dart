part of home;

class HomeScreenForm extends StatefulWidget {
  final void Function({
    String typeOfGamer,
    String typeOfController,
    int numberOfGamers,
    String gameName,
    List<Role> selectedRoles,
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
  late List<Role> selectedRoles;
  late Map<Role, int> roleOriginalIndexMap;

  final FocusNode _gameNameFocusNode = FocusNode();
  final List<String> typeOfGamers = <String>[
    AppStrings.savedGamers,
    AppStrings.newGamers,
  ];
  final List<int> numberOfGamers =
      List<int>.generate(23, (int index) => index + 1);

  String? selectedTypeofGamers;
  String? selectedTypeOfController;
  int? selectedNumberOfGamers;

  @override
  void initState() {
    super.initState();
    final List<Role> roles =
        BlocProvider.of<GameBloc>(context).state.gamersState.roles.roles;
    selectedRoles = List<Role>.from(roles);
    roleOriginalIndexMap = <Role, int>{
      for (int i = 0; i < roles.length; i++) roles[i]: i,
    };
  }

  void _toggleRole(Role role) {
    setState(() {
      if (selectedRoles.contains(role)) {
        selectedRoles.remove(role);
      } else {
        final int index = roleOriginalIndexMap[role]!;
        if (index >= selectedRoles.length) {
          selectedRoles.add(role);
        } else {
          selectedRoles.insert(index, role);
        }
      }
      widget.onChange!(
        selectedRoles: selectedRoles,
      );
    });
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<GameBloc, AppState>(
        builder: (BuildContext context, AppState state) {
          final Roles roles = state.gamersState.roles;

          return SizedBox(
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
                      style: MafiaTheme.themeData.textTheme.titleMedium,
                      keyboardType: TextInputType.emailAddress,
                      autofocus: true,
                      key: _gameNameFieldKey,
                      focusNode: _gameNameFocusNode,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 8),
                        labelText: AppStrings.nameOfGame,
                        labelStyle: MafiaTheme.themeData.textTheme.titleMedium,
                        icon: Icon(
                          Icons.border_color,
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
                    DropdownButtonHideUnderline(
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.interpreter_mode_rounded,
                            color: MafiaTheme.themeData.colorScheme.secondary,
                          ).padding(right: Dimensions.padding16),
                          DropdownButton2<Role>(
                            isExpanded: true,
                            hint: Text(
                              AppStrings.chooseRoles,
                              style: MafiaTheme.themeData.textTheme.titleMedium,
                            ),
                            items: roles.roles
                                .map(
                                  (Role role) => DropdownMenuItem<Role>(
                                    value: role,
                                    enabled: false,
                                    child: StatefulBuilder(
                                      builder: (
                                        BuildContext context,
                                        Function menuSetState,
                                      ) {
                                        final bool isSelected =
                                            selectedRoles.contains(role);
                                        return InkWell(
                                          onTap: () {
                                            _toggleRole(role);
                                            setState(() {});
                                            menuSetState(
                                              () {},
                                            );
                                          },
                                          child: SizedBox(
                                            height: 50,
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Text(
                                                    role.name,
                                                    style: MafiaTheme
                                                        .themeData
                                                        .textTheme
                                                        .headlineSmall,
                                                  ),
                                                ),
                                                const SizedBox(width: 16),
                                                if (isSelected)
                                                  const Icon(
                                                    Icons.check_box_outlined,
                                                    color: Colors.white,
                                                    size: 32,
                                                  )
                                                else
                                                  const Icon(
                                                    Icons
                                                        .check_box_outline_blank,
                                                    color: Colors.white,
                                                    size: 32,
                                                  ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (Role? role) {},
                            selectedItemBuilder: (BuildContext context) =>
                                roles.roles
                                    .map(
                                      (Role item) => Container(
                                        alignment: AlignmentDirectional.center,
                                        child: Text(
                                          selectedRoles.join(', '),
                                          style: const TextStyle(
                                            fontSize: 14,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          maxLines: 1,
                                        ),
                                      ),
                                    )
                                    .toList(),
                            buttonStyleData: ButtonStyleData(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              height: 50,
                              width: 470,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.transparent,
                                border: Border.all(
                                  color: MafiaTheme
                                      .themeData.colorScheme.secondary,
                                ),
                              ),
                            ),
                            dropdownStyleData: DropdownStyleData(
                              width: 470,
                              maxHeight: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.amber.withOpacity(.3),
                                border: Border.all(
                                  color: MafiaTheme
                                      .themeData.colorScheme.secondary,
                                ),
                              ),
                            ),
                            iconStyleData: const IconStyleData(
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.grey,
                              ),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 50,
                              padding: EdgeInsets.symmetric(horizontal: 16),
                            ),
                          ),
                        ],
                      ),
                    ).padding(top: Dimensions.padding16),
                    DropdownButtonFormField2<int>(
                      isExpanded: true,
                      key: _gamersNumberFieldKey,
                      decoration: InputDecoration(
                        // labelText: 'Choose',
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 8),
                        labelStyle: MafiaTheme.themeData.textTheme.titleMedium
                            ?.copyWith(height: 1),
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
                        style: MafiaTheme.themeData.textTheme.titleMedium
                            ?.copyWith(height: 1),
                      ),
                      items: numberOfGamers
                          .map<DropdownMenuItem<int>>(
                            (int item) => DropdownMenuItem<int>(
                              value: item,
                              child: Text(
                                item.toString(),
                                style: MafiaTheme
                                    .themeData.textTheme.titleMedium
                                    ?.copyWith(height: 1),
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
                          selectedRoles: selectedRoles,
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
                    DropdownButtonFormField2<String>(
                      isExpanded: true,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.padding8,
                        ),
                        labelStyle: MafiaTheme.themeData.textTheme.titleMedium
                            ?.copyWith(height: 1),
                        icon: Icon(
                          Icons.save,
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
                        AppStrings.usageOfGamers,
                        style: MafiaTheme.themeData.textTheme.titleMedium
                            ?.copyWith(height: 1),
                      ),
                      value: selectedTypeofGamers,
                      items: typeOfGamers
                          .map(
                            (String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: MafiaTheme
                                    .themeData.textTheme.titleMedium
                                    ?.copyWith(height: 1),
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
                          typeOfGamer: value!,
                        );
                        selectedTypeofGamers = value;
                      },
                      onSaved: (String? value) {
                        selectedTypeofGamers = value.toString();
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
                          color: Colors.transparent,
                          border: Border.all(
                            color: MafiaTheme.themeData.colorScheme.secondary,
                          ),
                        ),
                      ),
                    ).padding(top: Dimensions.padding16),
                  ],
                ),
              ).padding(
                all: Dimensions.padding16,
              ),
            ),
          );
        },
      );
}

void _updateControllerText(String? value, TextEditingController controller) {
  final TextSelection cursorPosition = controller.selection;
  controller.text = value ?? "";
  controller.selection = cursorPosition;
}
