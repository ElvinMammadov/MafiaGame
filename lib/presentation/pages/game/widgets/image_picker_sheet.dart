part of game;

class ImagePickerSheet extends StatefulWidget {
  final TextEditingController textEditingController;
  final ValueChanged<File?> onImageChanged;
  final ValueChanged<Role?> onRoleChanged;

  const ImagePickerSheet({
    super.key,
    required this.textEditingController,
    required this.onImageChanged,
    required this.onRoleChanged,
  });

  @override
  State<ImagePickerSheet> createState() => _ImagePickerSheetState();
}

class _ImagePickerSheetState extends State<ImagePickerSheet> {
  File? image;
  Role? selectedRole;
  final ImagePicker picker = ImagePicker();
  // final Stream<QuerySnapshot> _usersStream =
  //     FirebaseFirestore.instance.collection('gamers').snapshots();

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

  Future<List> fetchData() async {
    await Future.delayed(
      const Duration(
        milliseconds: 1000,
      ),
    );
    final List list = <String>[];
    final String inputText = widget.textEditingController.text;
    list.add('$inputText Item 1');
    list.add('$inputText Item 2');
    list.add('$inputText Item 3');
    return list;
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
                          ? const Image(
                              image: AssetImage('assets/mafioz.jpg'),
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
              // TextFieldSearch(
              //   label: AppStrings.nameOfGamer,
              //   controller: widget.textEditingController,
              //   decoration: InputDecoration(
              //     contentPadding: const EdgeInsets.symmetric(
              //       horizontal: 8,
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       borderSide: BorderSide(
              //         color: MafiaTheme.themeData.colorScheme.secondary,
              //       ),
              //     ),
              //     enabledBorder: OutlineInputBorder(
              //       borderSide: BorderSide(
              //         color: MafiaTheme.themeData.colorScheme.secondary,
              //       ),
              //     ),
              //   ),
              //   textStyle: MafiaTheme.themeData.textTheme.headlineSmall,
              //   scrollbarDecoration: ScrollbarDecoration(
              //     controller: ScrollController(),
              //     theme: ScrollbarThemeData(
              //       radius: const Radius.circular(30.0),
              //       thickness: MaterialStateProperty.all(20.0),
              //       thumbVisibility: MaterialStateProperty.all(true),
              //       trackColor: MaterialStateProperty.all(Colors.blue),
              //       thumbColor: MaterialStateProperty.all(Colors.cyan),
              //     ),
              //   ),
              //   future: () {
              //     print('fetchData ${fetchData()}');
              //     return fetchData();
              //   },
              // ),

              TextFormField(
                controller: widget.textEditingController,
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
