part of game;

class DialogBuilder {
  void showAddUserModal(
    BuildContext context,
    int id,
  ) {
    final ValueNotifier<bool> isButtonEnabledNotifier =
        ValueNotifier<bool>(false);
    final TextEditingController textEditingController = TextEditingController();
    textEditingController.addListener(() {
      isButtonEnabledNotifier.value = textEditingController.text.isNotEmpty;
    });
    final FirestoreService firestoreService = FirestoreService();
    File? imageFile;
    String? roleName;
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
              action: () async {
                final String gamerId = UniqueKey().toString();
                final String imageUrl =
                    await firestoreService.uploadImageToFirebaseStorage(
                  imageFile == null
                      ? await getImageFileFromAssets('mafioz.jpg')
                      : imageFile!,
                  gamerId,
                );
                BlocProvider.of<GameBloc>(context).add(
                  UpdateGamer(
                    gamer: Gamer(
                      name: textEditingController.text,
                      id: id,
                      gamerId: gamerId,
                      imageUrl: imageUrl,
                      role: roleName,
                      isNameChanged: true,
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
              right: 16,
            ),
            child: IconButton(
              onPressed: Navigator.of(context).pop,
              icon: const Icon(
                Icons.close,
                size: 32,
                color: Colors.white,
              ),
            ),
          ),
          child: ImagePickerSheet(
            textEditingController: textEditingController,
            onImageChanged: (File? file) {
              imageFile = file;
            },
            onRoleChanged: (String? role) {
              roleName = role;
            },
          ),
        ),
      ],
      modalTypeBuilder: (BuildContext context) => WoltModalType.dialog,
    );
  }

  Future<File> getImageFileFromAssets(String path) async {
    final ByteData byteData = await rootBundle.load('assets/$path');

    final File file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(
      byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
    );

    return file;
  }

  void showPlayGame(
    BuildContext context, {
    required bool isVotingStarted,
    required int gamerId,
  }) {
    final ValueNotifier<bool> isButtonEnabledNotifier =
        ValueNotifier<bool>(false);
    final TextEditingController textEditingController = TextEditingController();
    textEditingController.addListener(() {
      isButtonEnabledNotifier.value = textEditingController.text.isNotEmpty;
    });

    final List<Gamer> gamers =
        BlocProvider.of<GameBloc>(context).state.gamersState.gamers;
    final List<String> items = <String>[];
    for (int i = 0; i < gamers.length; i++) {
      items.add(gamers[i].name!);
    }

    void checkGamer(String gamerName) {
      for (final Gamer gamer in gamers) {
        if (gamer.name == gamerName) {
          BlocProvider.of<GameBloc>(context).add(
            AddVoteToGamer(gamer: gamer),
          );
          Navigator.of(context).pop();
          break;
        }
      }
    }

    String? selectedValue;
    WoltModalSheet.show<void>(
      context: context,
      pageListBuilder: (BuildContext modalSheetContext) =>
          <SliverWoltModalSheetPage>[
        WoltModalSheetPage(
          hasSabGradient: false,
          isTopBarLayerAlwaysVisible: true,
          hasTopBarLayer: false,
          // topBarTitle: Text(
          //   AppStrings.createGamer,
          //   style: MafiaTheme.themeData.textTheme.headlineSmall,
          // ),
          trailingNavBarWidget: Padding(
            padding: const EdgeInsets.only(
              right: 16,
            ),
            child: IconButton(
              onPressed: Navigator.of(context).pop,
              icon: const Icon(
                Icons.close,
                size: 32,
                color: Colors.white,
              ),
            ),
          ),
          child: Column(
            children: <Widget>[
              if (isVotingStarted)
                DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          AppStrings.vote,
                          style: MafiaTheme.themeData.textTheme.headlineSmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    barrierColor: Colors.black.withOpacity(0.5),
                    items: items
                        .map(
                          (String item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style:
                                  MafiaTheme.themeData.textTheme.headlineSmall,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                        .toList(),
                    value: selectedValue,
                    onChanged: (String? value) {
                      checkGamer(value!);
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
                        color: MafiaTheme.themeData.colorScheme.secondary
                            .withOpacity(0.5),
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
                        color: MafiaTheme.themeData.colorScheme.secondary
                            .withOpacity(0.5),
                      ),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: MaterialStateProperty.all(6),
                        thumbVisibility: MaterialStateProperty.all(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding: EdgeInsets.only(left: 150),
                    ),
                  ),
                ).padding(
                  horizontal: 16,
                  vertical: 16,
                ),

              // BaseButton(
              //   label: AppStrings.vote,
              //   textStyle: MafiaTheme.themeData.textTheme.headlineSmall,
              //   backgroundColor:
              //       MafiaTheme.themeData.colorScheme.secondary.withOpacity(0.5),
              //   action: () {
              //     Navigator.of(context).pop();
              //   },
              // ),
              BaseButton(
                label: AppStrings.fol,
                textStyle: MafiaTheme.themeData.textTheme.headlineSmall,
                backgroundColor:
                    MafiaTheme.themeData.colorScheme.secondary.withOpacity(0.5),
                action: () {
                  BlocProvider.of<GameBloc>(context).add(
                    AddFaultToGamer(gamerId: gamerId),
                  );
                  Navigator.of(context).pop();
                },
              ),
              BaseButton(
                label: AppStrings.profile,
                textStyle: MafiaTheme.themeData.textTheme.headlineSmall,
                backgroundColor:
                    MafiaTheme.themeData.colorScheme.secondary.withOpacity(0.5),
                action: () {
                  Navigator.of(context).pop();
                },
              ),
              BaseButton(
                label: AppStrings.delete,
                textStyle: MafiaTheme.themeData.textTheme.headlineSmall,
                backgroundColor: MafiaTheme.themeData.colorScheme.primary,
                action: () {
                  Navigator.of(context).pop();
                },
              ),
              // BaseButton(
              //   label: AppStrings.add,
              //   textStyle: MafiaTheme.themeData.textTheme.headlineSmall,
              //   backgroundColor: MafiaTheme.themeData.disabledColor,
              //   action: () {
              //     Navigator.of(context).pop();
              //   },
              // ),
              // BaseButton(
              //   label: AppStrings.add,
              //   textStyle: MafiaTheme.themeData.textTheme.headlineSmall,
              //   backgroundColor: MafiaTheme.themeData.disabledColor,
              //   action: () {
              //     Navigator.of(context).pop();
              //   },
              // ),
            ],
          ),
        ),
      ],
      modalTypeBuilder: (BuildContext context) => WoltModalType.dialog,
    );
  }
}
