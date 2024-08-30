part of game;

class ImagePickerSheet extends StatefulWidget {
  final TextEditingController textEditingController;
  final ValueChanged<File?> onImageChanged;
  final ValueChanged<Gamer?>? gamerChosenFromFirebase;
  final ValueChanged<int?> onPositionChange;
  final int? numberOfGamers;
  final bool? isPositionMode;

  const ImagePickerSheet({
    super.key,
    required this.textEditingController,
    required this.onImageChanged,
    required this.onPositionChange,
    this.gamerChosenFromFirebase,
    this.numberOfGamers,
    this.isPositionMode,
  });

  @override
  State<ImagePickerSheet> createState() => _ImagePickerSheetState();
}

class _ImagePickerSheetState extends State<ImagePickerSheet> {
  File? image;
  Role? selectedRole;
  final ImagePicker picker = ImagePicker();
  late String imageUrl = '';
  final GlobalKey<FormFieldState<int>> _positionFieldKey =
      GlobalKey<FormFieldState<int>>();
  int? selectedPosition;

  List<int> get numberOfPositions =>
      List<int>.generate(widget.numberOfGamers!, (int index) => index + 1);

  Future<void> getImageFromGallery() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        widget.onImageChanged(image);
      }
    });
  }

  Future<void> getImageFromCamera() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        widget.onImageChanged(image);
      }
    });
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<GameBloc, AppState>(
        builder: (BuildContext context, AppState state) => Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  CircleAvatar(
                    radius: 70,
                    child: ClipOval(
                      child: image == null
                          ? imageUrl.isEmpty
                              ? const Image(
                                  image: AssetImage('assets/logo_m.png'),
                                  fit: BoxFit.fill,
                                  width: 192,
                                  height: 180,
                                )
                              : Image.network(
                                  imageUrl,
                                  fit: BoxFit.fill,
                                  width: 192,
                                  height: 180,
                                )
                          : Image.file(
                              image!,
                              fit: BoxFit.fill,
                              width: 192,
                              height: 180,
                            ),
                    ),
                  ),
                  Positioned(
                    bottom: -10,
                    left: 100,
                    child: IconButton(
                      onPressed: () {
                        showImagePickerSheet(context);
                      },
                      icon: const Icon(
                        Icons.add_a_photo_outlined,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),
                ],
              ).padding(
                top: 16,
                bottom: 16,
              ),
              TypeAheadField<Gamer>(
                controller: widget.textEditingController,
                suggestionsCallback: (String search) async {
                  if (search.isNotEmpty) {
                    final List<Gamer> gamers =
                        await FirestoreService().getGamers(search);
                    return gamers;
                  } else {
                    return <Gamer>[];
                  }
                },
                hideOnEmpty: true,
                hideOnLoading: true,
                builder: (
                  BuildContext context,
                  TextEditingController controller,
                  FocusNode focusNode,
                ) =>
                    TextField(
                  controller: widget.textEditingController,
                  focusNode: focusNode,
                  autofocus: true,
                  style: MafiaTheme.themeData.textTheme.headlineSmall
                      ?.copyWith(height: 1),
                  decoration: InputDecoration(
                    labelStyle: MafiaTheme.themeData.textTheme.headlineSmall
                        ?.copyWith(height: 1),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    hintStyle: MafiaTheme.themeData.textTheme.headlineSmall
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
                ),
                decorationBuilder: (BuildContext context, Widget child) =>
                    Material(
                  color: MafiaTheme.themeData.colorScheme.secondary
                      .withOpacity(0.6),
                  type: MaterialType.card,
                  elevation: 4,
                  borderRadius: BorderRadius.circular(10),
                  child: child,
                ),
                itemBuilder: (
                  BuildContext context,
                  Gamer? gamer,
                ) {
                  if (widget.textEditingController.text.isEmpty) {
                    return Container();
                  }
                  return ListTile(
                    title: Text(
                      gamer?.name ?? '1',
                      style: MafiaTheme.themeData.textTheme.headlineSmall
                          ?.copyWith(height: 1),
                    ),
                    textColor: Colors.white,
                  );
                },
                onSelected: (Gamer? gamer) {
                  widget.textEditingController.text = gamer!.name!;
                  setState(() {
                    imageUrl = gamer.imageUrl!;
                  });
                  widget.gamerChosenFromFirebase!(gamer);
                },
              ),
              if (widget.isPositionMode == true)
                DropdownButtonFormField2<int>(
                  isExpanded: true,
                  key: _positionFieldKey,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    labelStyle: MafiaTheme.themeData.textTheme.headlineSmall
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
                    AppStrings.positionOfGamer,
                    style: MafiaTheme.themeData.textTheme.headlineSmall
                        ?.copyWith(height: 1),
                  ),
                  items: numberOfPositions
                      .map<DropdownMenuItem<int>>(
                        (int item) => DropdownMenuItem<int>(
                          value: item,
                          child: Text(
                            item.toString(),
                            style: MafiaTheme.themeData.textTheme.headlineSmall
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
                  value: selectedPosition,
                  onChanged: (int? value) {
                    print('value: $value');
                    selectedPosition = value;
                    widget.onPositionChange(selectedPosition);
                  },
                  onSaved: (int? value) {
                    _positionFieldKey.currentState!.validate();
                    selectedPosition = value;
                  },
                  iconStyleData: const IconStyleData(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                    ),
                  ),
                  dropdownStyleData: DropdownStyleData(
                    offset: const Offset(300, 0),
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
          ).padding(
            bottom: 100,
            horizontal: 16,
          ),
      );

  void showImagePickerSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => SizedBox(
        width: 400,
        child: CupertinoActionSheet(
          actions: <CupertinoActionSheetAction>[
            CupertinoActionSheetAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);

                getImageFromCamera();
              },
              child: const Text(AppStrings.camera),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);

                getImageFromGallery();
              },
              child: const Text(AppStrings.gallery),
            ),
          ],
        ),
      ),
    );
  }
}
