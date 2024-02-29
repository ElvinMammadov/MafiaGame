import 'package:flutter/material.dart';
import 'package:mafia_game/utils/dimensions.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class AddUser {
  AddUser._();

  static WoltModalSheetPage build({
    VoidCallback? onSabPressed,
    required VoidCallback onClosed,
    BuildContext? context,
  }) {
    final ValueNotifier<bool> isButtonEnabledNotifier =
        ValueNotifier<bool>(false);
    final TextEditingController textEditingController = TextEditingController();
    textEditingController.addListener(() {
      isButtonEnabledNotifier.value = textEditingController.text.isNotEmpty;
    });
    return WoltModalSheetPage(
      stickyActionBar: ValueListenableBuilder<bool>(
        valueListenable: isButtonEnabledNotifier,
        builder: (BuildContext context, bool isEnabled, __) => Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: ElevatedButton(
            onPressed: isEnabled ? onSabPressed : null,
            child: const Text(
              "Submit",
            ),
          ),
        ),
      ),
      pageTitle: const Text('Page with text field'),
      topBarTitle: const Text('Page with text field'),
      trailingNavBarWidget: IconButton(
        constraints: const BoxConstraints(
          maxHeight: Dimensions.itemHeight24,
          maxWidth: Dimensions.itemWidth24,
        ),
        padding: const EdgeInsets.all(
          16,
        ),
        onPressed: onClosed,
        icon: const Icon(
          Icons.close,
        ),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(bottom: 80, top: 16, right: 16, left: 16),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: TextFormField(
                autofocus: true,
                maxLines: 3,
                controller: textEditingController,
                scrollPadding: const EdgeInsets.only(top: 300),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
