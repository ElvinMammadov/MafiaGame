part of game;

class DialogBuilder {
  void showAddUserModal(
    BuildContext context,
      int gameId,
  ) {
    final ValueNotifier<bool> isButtonEnabledNotifier =
    ValueNotifier<bool>(false);
    final TextEditingController textEditingController = TextEditingController();
    textEditingController.addListener(() {
      isButtonEnabledNotifier.value = textEditingController.text.isNotEmpty;
    });
    WoltModalSheet.show<void>(
      context: context,
      pageListBuilder: (BuildContext modalSheetContext) =>
          <SliverWoltModalSheetPage>[
        WoltModalSheetPage(
          hasSabGradient: false,
          isTopBarLayerAlwaysVisible: true,
          hasTopBarLayer: true,
          stickyActionBar: ValueListenableBuilder<bool>(
            valueListenable: isButtonEnabledNotifier,
            builder: (_, bool isEnabled, __) => BaseButton(
              label: AppStrings.add,
              enabled: isEnabled,
              textStyle: MafiaTheme.themeData.textTheme.headlineSmall,
              action: () {
                BlocProvider.of<GameBloc>(context).add(
                  UpdateGamerName(
                    gamer: Gamer(
                      name: textEditingController.text,
                      id: gameId,
                    ),
                  ),
                );
                Navigator.of(context).pop();
              },
            ),
          ),
          topBarTitle: Text(
            AppStrings.createGamer,
            style: MafiaTheme.themeData.textTheme.headlineSmall,
          ),
          trailingNavBarWidget: Padding(
            padding: const EdgeInsets.only(
              right: 32,
            ),
            child: IconButton(
              constraints: const BoxConstraints(
                maxHeight: Dimensions.itemHeight32,
                maxWidth: Dimensions.itemWidth32,
              ),
              onPressed: Navigator.of(context).pop,
              icon: const Icon(
                Icons.close,
                size: 32,
                color: Colors.white,
              ),
            ),
          ),
          child: TextFormField(
            controller: textEditingController,
            style: MafiaTheme.themeData.textTheme.headlineSmall,
            keyboardType: TextInputType.emailAddress,
            autofocus: true,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              labelText: AppStrings.nameOfGamer,
              labelStyle: MafiaTheme.themeData.textTheme.headlineSmall,
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
            onChanged: (String value) {
              // Handle onChanged event
            },
            onSaved: (String? value) {
              // Handle onSaved event
            },
            validator: Validator.validateText,
          ).padding(
            bottom: 100,
            top: 16,
            horizontal: 16,
          ),
        ),
        // Add more SliverWoltModalSheetPage as needed
      ],
      modalTypeBuilder: (BuildContext context) => WoltModalType.dialog,
    );
  }
}
