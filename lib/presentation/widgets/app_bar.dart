import 'package:flutter/material.dart';

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
      title: Text(title),
      automaticallyImplyLeading: showBackButton,
      centerTitle: true,
    );

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
