import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/core/services/navigation_service.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leadingIcon;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.leadingIcon,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: leadingIcon ??
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              context.nav.pop(context);
            },
          ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
