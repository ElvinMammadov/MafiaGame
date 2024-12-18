part of game;

class DialogBuilder {
  void showAddUserModal(
    BuildContext context,
    int id,
    Role role, {
    bool isPositionMode = false,
    int numberOfGamers = 0,
    int position = 0,
  }) {
    final ValueNotifier<bool> isButtonEnabledNotifier =
        ValueNotifier<bool>(false);
    final TextEditingController textEditingController = TextEditingController();
    final ValueNotifier<Gamer?> chosenGamerNotifier =
        ValueNotifier<Gamer?>(null);
    final ValueNotifier<int?> positionOnTableNotifier =
        ValueNotifier<int?>(null);
    final ValueNotifier<File?> imageNotifier = ValueNotifier<File?>(
      null,
    );
    textEditingController.addListener(() {
      isButtonEnabledNotifier.value = textEditingController.text.isNotEmpty;
      if (textEditingController.text.isNotEmpty) {
        chosenGamerNotifier.value = null;
      }
    });

    WoltModalSheet.show<void>(
      context: context,
      pageListBuilder: (BuildContext modalSheetContext) =>
          <SliverWoltModalSheetPage>[
        WoltModalSheetPage(
          hasSabGradient: false,
          isTopBarLayerAlwaysVisible: true,
          hasTopBarLayer: true,
          navBarHeight: 48,
          stickyActionBar: ValueListenableBuilder<bool>(
            valueListenable: isButtonEnabledNotifier,
            builder: (_, bool isEnabled, __) => ValueListenableBuilder<Gamer?>(
              valueListenable: chosenGamerNotifier,
              builder: (_, Gamer? chosenGamer, __) =>
                  ValueListenableBuilder<File?>(
                valueListenable: imageNotifier,
                builder: (_, File? imageFile, __) => SaveButton(
                  isEnabled: isEnabled,
                  chosenGamer: chosenGamer,
                  imageFile: imageFile,
                  positionOnTableNotifier: positionOnTableNotifier,
                  isPositionMode: isPositionMode,
                  position: position,
                  id: id,
                  textEditingController: textEditingController,
                ),
              ),
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
              onPressed: () {
                BlocProvider.of<GameBloc>(context).add(
                  const ChangeSaveStatus(
                    saveStatus: FirebaseSaveStatus.Initial,
                  ),
                );
                Navigator.of(context).pop();
              },
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
              imageNotifier.value = file;
            },
            gamerChosenFromFirebase: (Gamer? gamer) {
              chosenGamerNotifier.value = gamer;
            },
            onPositionChange: (int? position) {
              positionOnTableNotifier.value = position;
            },
            isPositionMode: isPositionMode,
            numberOfGamers: numberOfGamers,
          ),
        ),
      ],
      modalTypeBuilder: (BuildContext context) => WoltModalType.dialog,
    );
  }



  void showChosenGamersDialog(
    BuildContext context,
    List<Gamer> gamers, {
    String description = "",
    String buttonTitle = "",
    required void Function(Gamer?) onGamerSelected,
  }) {
    final GlobalKey<FormFieldState<Gamer>> selectedGamerKey =
        GlobalKey<FormFieldState<Gamer>>();
    Gamer? selectedGamer;
    WoltModalSheet.show<void>(
      context: context,
      maxDialogWidth: 540,
      minDialogWidth: 540,
      pageListBuilder: (BuildContext modalSheetContext) =>
          <SliverWoltModalSheetPage>[
        WoltModalSheetPage(
          hasSabGradient: false,
          isTopBarLayerAlwaysVisible: true,
          hasTopBarLayer: true,
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
              Text(
                description,
                textAlign: TextAlign.center,
                style: MafiaTheme.themeData.textTheme.headlineMedium,
              ).padding(
                bottom: 20.0,
                horizontal: 20.0,
              ),
              DropdownButtonFormField2<Gamer>(
                isExpanded: true,
                key: selectedGamerKey,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  labelStyle: MafiaTheme.themeData.textTheme.titleMedium
                      ?.copyWith(height: 1),
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
                  AppStrings.gamers,
                  style: MafiaTheme.themeData.textTheme.titleMedium
                      ?.copyWith(height: 1),
                ),
                items: gamers
                    .map(
                      (Gamer gamer) => DropdownMenuItem<Gamer>(
                        value: gamer,
                        child: Text(
                          gamer.name ?? '',
                          style: MafiaTheme.themeData.textTheme.titleMedium
                              ?.copyWith(height: 1),
                        ),
                      ),
                    )
                    .toList(),
                value: selectedGamer,
                onChanged: (Gamer? gamer) {
                  selectedGamer = gamer;
                },
                onSaved: (Gamer? gamer) {
                  selectedGamer = gamer;
                },
                iconStyleData: const IconStyleData(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.grey,
                  ),
                ),
                dropdownStyleData: DropdownStyleData(
                  width: 480,
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
                horizontal: Dimensions.padding16,
              ),
              Center(
                child: SizedBox(
                  width: 280.0,
                  child: BaseButton(
                    action: () {
                      Navigator.of(context).pop();
                      onGamerSelected(selectedGamer);
                    },
                    label: buttonTitle,
                    textStyle: MafiaTheme.themeData.textTheme.headlineSmall,
                  ),
                ).padding(
                  horizontal: 16.0,
                  vertical: Dimensions.padding32,
                ),
              ),
            ],
          ).padding(
            horizontal: 16.0,
            vertical: 16.0,
          ),
        ),
      ],
      modalTypeBuilder: (BuildContext context) => WoltModalType.dialog,
    );
  }
}

class SaveButton extends StatefulWidget {
  final bool isEnabled;
  final Gamer? chosenGamer;
  final File? imageFile;
  final ValueNotifier<int?> positionOnTableNotifier;
  final bool isPositionMode;
  final int position;
  final int id;
  final TextEditingController textEditingController;

  const SaveButton({
    required this.isEnabled,
    required this.chosenGamer,
    required this.imageFile,
    required this.positionOnTableNotifier,
    required this.isPositionMode,
    required this.position,
    required this.id,
    required this.textEditingController,
    super.key,
  });

  @override
  _SaveButtonState createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  @override
  Widget build(BuildContext context) => BlocBuilder<GameBloc, AppState>(
        builder: (BuildContext context, AppState state) {
          final FirestoreService firestoreService = FirestoreService();
          final FirebaseSaveStatus saveStatus =
              BlocProvider.of<GameBloc>(context).state.game.saveStatus;
          return BaseButton(
            label: AppStrings.add,
            enabled:
                saveStatus != FirebaseSaveStatus.Saving && widget.isEnabled,
            isLoading: saveStatus == FirebaseSaveStatus.Saving,
            textStyle: MafiaTheme.themeData.textTheme.headlineSmall,
            action: () async {
              bool isNameExist(String name) =>
                  BlocProvider.of<GameBloc>(context)
                      .state
                      .gamersState
                      .gamers
                      .any(
                        (Gamer gamer) => gamer.name == name,
                      );
              if (widget.isPositionMode &&
                  widget.positionOnTableNotifier.value == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(
                      AppStrings.chooseGamerPosition,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                );
              } else if (widget.chosenGamer != null) {
                if (isNameExist(widget.chosenGamer?.name ?? '')) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                        AppStrings.gamerAlreadyExistInGame,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  );
                } else {
                  BlocProvider.of<GameBloc>(context).add(
                    UpdateGamer(
                      isGamerExist: true,
                      gamer: Gamer(
                        name: widget.chosenGamer!.name,
                        id: widget.id,
                        gamerId: widget.chosenGamer!.gamerId,
                        imageUrl: widget.chosenGamer!.imageUrl,
                        positionOnTable: widget.isPositionMode
                            ? widget.positionOnTableNotifier.value!
                            : widget.position,
                        isNameChanged: true,
                        role: const Mirniy.empty(),
                        hasImage: widget.chosenGamer!.hasImage,
                      ),
                      showErrorMessage: (String errorMessage) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              errorMessage,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                  Navigator.of(context).pop();
                }
              } else {
                if (isNameExist(widget.textEditingController.text)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                        AppStrings.gamerAlreadyExistInGame,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  );
                } else {
                  final String gamerId = idGenerator();
                  final File imageFile = widget.imageFile == null
                      ? await getImageFileFromAssets('logo_m.png')
                      : widget.imageFile!;
                  final String fileName = gamerId;
                  UploadResult result = UploadResult(
                    success: true,
                    imageUrl: '',
                  );

                  BlocProvider.of<GameBloc>(context).add(
                    const ChangeSaveStatus(
                      saveStatus: FirebaseSaveStatus.Saving,
                    ),
                  );

                  if (widget.imageFile != null) {
                    result =
                        await firestoreService.uploadImageToFirebaseStorage(
                      imageFile,
                      fileName,
                    );
                  }

                  if (result.success) {
                    BlocProvider.of<GameBloc>(context).add(
                      UpdateGamer(
                        gamer: Gamer(
                          name: widget.textEditingController.text,
                          id: widget.id,
                          gamerId: gamerId,
                          imageUrl: result.imageUrl,
                          positionOnTable: widget.isPositionMode
                              ? widget.positionOnTableNotifier.value!
                              : widget.position,
                          isNameChanged: true,
                          role: const Mirniy.empty(),
                          hasImage: result.imageUrl != '',
                        ),
                        updated: () {
                          BlocProvider.of<GameBloc>(context).add(
                            const ChangeSaveStatus(
                              saveStatus: FirebaseSaveStatus.Initial,
                            ),
                          );
                          Navigator.of(context).pop();
                        },
                        showErrorMessage: (String errorMessage) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                errorMessage,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.0,
                                ),
                              ),
                            ),
                          );
                          BlocProvider.of<GameBloc>(context).add(
                            const ChangeSaveStatus(
                              saveStatus: FirebaseSaveStatus.Initial,
                            ),
                          );
                        },
                      ),
                    );
                  }
                }
              }
            },
          ).padding(
            vertical: 16.0,
            horizontal: 36.0,
          );
        },
      );

  Future<File> getImageFileFromAssets(String path) async {
    final ByteData byteData = await rootBundle.load('assets/$path');

    final File file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(
      byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
    );

    return file;
  }
}
