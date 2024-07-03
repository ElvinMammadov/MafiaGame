import 'package:flutter/material.dart';
import 'package:mafia_game/utils/app_strings.dart';
import 'package:mafia_game/utils/theme/theme.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final VoidCallback? actionCallback;
  final VoidCallback? onExit;
  final bool showGameMenu;

  const DefaultAppBar({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.actionCallback,
    this.showGameMenu = false,
    this.onExit,
  });

  void _onMenuSelected(String value) {
    switch (value) {
      case 'addGamer':
        // ignore: avoid_print
        print('addGamer');
        break;
      case 'exit':
        onExit?.call();
        break;
      default:
        // ignore: avoid_print
        print('default');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double appBarHeight = AppBar().preferredSize.height;
    return AppBar(
      title: Text(
        title,
        style: MafiaTheme.themeData.textTheme.headlineSmall,
      ),
      automaticallyImplyLeading: showBackButton,
      centerTitle: true,
      actions: showGameMenu
          ? <Widget>[
              PopupMenuButton<String>(
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                onSelected: _onMenuSelected,
                offset: Offset(0.0, appBarHeight),
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'addGamer',
                    child: SizedBox(
                      width: 180,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          const Icon(
                            Icons.person_add_rounded,
                            color: Colors.white,
                          ),
                          Text(
                            AppStrings.addGamer,
                            style: TextStyle(
                              color: MafiaTheme.themeData.colorScheme.surface,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem<String>(
                    value: 'exit',
                    child: SizedBox(
                      width: 180,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          const Icon(
                            Icons.exit_to_app,
                            color: Colors.white,
                          ),
                          Text(
                            AppStrings.leaveGame,
                            style: TextStyle(
                              color: MafiaTheme.themeData.colorScheme.surface,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ]
          : null,
      backgroundColor: MafiaTheme.themeData.colorScheme.background,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                actionCallback?.call();
                Navigator.pop(context);
              },
              color: MafiaTheme.themeData.colorScheme.surface,
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
