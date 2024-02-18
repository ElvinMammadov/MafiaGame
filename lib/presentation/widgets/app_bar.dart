import 'package:flutter/material.dart';
import 'package:mafia_game/utils/theme/theme.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;

  const DefaultAppBar({
    super.key,
    required this.title,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) => AppBar(
        title: Text(
          title,
          style: MafiaTheme.themeData.textTheme.headlineSmall,
        ),
        automaticallyImplyLeading: showBackButton,
        centerTitle: true,
        backgroundColor: MafiaTheme.themeData.colorScheme.background,
        leading: showBackButton
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
                color: MafiaTheme.themeData.colorScheme.surface,
              )
            : null,
      );

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
