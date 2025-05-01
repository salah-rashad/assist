import 'package:assist_gui/features/main_layout/widgets/theme_switch_icon_button.dart';
import 'package:assist_gui/features/main_layout/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AppTopBar extends PreferredSize {
  const AppTopBar({super.key})
      : super(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: const SizedBox.shrink(),
        );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      // title: Text(Strings.appName),
      actionsPadding: EdgeInsetsDirectional.only(end: 16),
      actions: [
        ShadIconButton.ghost(icon: Icon(LucideIcons.search)),
        ShadIconButton.ghost(icon: Icon(LucideIcons.bell)),
        ThemeSwitchIconButton(),
        SizedBox(width: 8),
        UserAvatar(),
      ],
    );
  }
}
