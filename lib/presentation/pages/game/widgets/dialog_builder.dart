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
                  imageFile!,
                  gamerId,
                );
                print('gamerId: $gamerId, imageUrl: $imageUrl');
                BlocProvider.of<GameBloc>(context).add(
                  UpdateGamer(
                    gamer: Gamer(
                      name: textEditingController.text,
                      id: gameId,
                      gamerId: gamerId,
                      imageUrl: imageUrl,
                      role: roleName,
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
}
