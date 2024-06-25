part of game;

class ImagePickerSheet extends StatefulWidget {
  final TextEditingController textEditingController;
  final ValueChanged<File?> onImageChanged;
  final ValueChanged<Role?> onRoleChanged;
  final ValueChanged<Gamer?>? gamerChosenFromFirebase;

  const ImagePickerSheet({
    super.key,
    required this.textEditingController,
    required this.onImageChanged,
    required this.onRoleChanged,
    this.gamerChosenFromFirebase,
  });

  @override
  State<ImagePickerSheet> createState() => _ImagePickerSheetState();
}

class _ImagePickerSheetState extends State<ImagePickerSheet> {
  File? image;
  Role? selectedRole;
  final ImagePicker picker = ImagePicker();
  late String imageUrl = '';

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
        builder: (BuildContext context, AppState state) {
          final Roles roles = state.gamersState.roles;
          return Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  CircleAvatar(
                    radius: 90,
                    child: ClipOval(
                      child: image == null
                          ? imageUrl.isEmpty ?const Image(
                              image: AssetImage('assets/mafioz.jpg'),
                              fit: BoxFit.fill,
                              width: 192,
                              height: 180,
                            )
                          :Image.network(
                              imageUrl,
                              fit: BoxFit.fill,
                              width: 192,
                              height: 180,
                            ): Image.file(
                        image!,
                        fit: BoxFit.fill,
                        width: 192,
                        height: 180,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -10,
                    left: 120,
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
                  final List<Gamer> gamers = await FirestoreService().getGamers(search);
                  return gamers;
                },
                hideOnEmpty: true,
                builder: (
                  BuildContext context,
                  TextEditingController controller,
                  FocusNode focusNode,
                ) =>
                    TextField(
                  controller: widget.textEditingController,
                  focusNode: focusNode,
                  autofocus: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: MafiaTheme.themeData.colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
                decorationBuilder: (BuildContext context, Widget child) =>
                    Material(
                  color: MafiaTheme.themeData.colorScheme.secondary
                      .withOpacity(0.8),
                  type: MaterialType.card,
                  elevation: 4,
                  borderRadius: BorderRadius.circular(10),
                  child: child,
                ),
                itemBuilder: (
                  BuildContext context,
                  Gamer? gamer,
                ) {
                  if(widget.textEditingController.text.isEmpty) {
                    return Container();
                  }
                  return ListTile(
                  title: Text(gamer?.name ?? '1'),
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
              DropdownButtonFormField2<Role>(
                isExpanded: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.padding8,
                  ),
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
                hint: Text(
                  AppStrings.roleOfGamer,
                  style: MafiaTheme.themeData.textTheme.headlineSmall,
                ),
                value: selectedRole,
                items: roles.roles
                    .map(
                      (Role item) => DropdownMenuItem<Role>(
                        value: item,
                        child: Text(
                          item.name,
                          style: MafiaTheme.themeData.textTheme.headlineSmall,
                        ),
                      ),
                    )
                    .toList(),
                validator: (Role? value) {
                  if (value == null) {
                    return 'Please select gender.';
                  }
                  return null;
                },
                onChanged: (Role? value) {
                  // widget.onChange!(
                  //   typeOfGame: value!,
                  // );
                  selectedRole = value;
                  widget.onRoleChanged(selectedRole);
                },
                onSaved: (Role? value) {
                  selectedRole = value;
                },
                iconStyleData: const IconStyleData(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.grey,
                  ),
                ),
                dropdownStyleData: DropdownStyleData(
                  offset: const Offset(5, 0),
                  width: 370,
                  maxHeight: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.transparent,
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
          ).padding(
            bottom: 100,
            horizontal: 16,
          );
        },
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
