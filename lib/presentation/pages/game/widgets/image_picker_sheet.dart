part of game;

class ImagePickerSheet extends StatefulWidget {
  final TextEditingController textEditingController;

  const ImagePickerSheet({super.key, required this.textEditingController});

  @override
  State<ImagePickerSheet> createState() => _ImagePickerSheetState();
}

class _ImagePickerSheetState extends State<ImagePickerSheet> {
  File? image;
  final ImagePicker picker = ImagePicker();

  //Image Picker function to get image from gallery
  Future<void> getImageFromGallery() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      }
    });
  }

  //Image Picker function to get image from camera
  Future<void> getImageFromCamera() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
               CircleAvatar(
                radius: 90,
                child: ClipOval(
                  child: image == null ? const Image(
                    image: AssetImage('assets/roles/mirniy.png'),
                    fit: BoxFit.fill,
                    width: 192,
                    height: 180,
                  ) : Image.file(
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
        ],
      ).padding(
        bottom: 100,
        top: 16,
        horizontal: 16,
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
