import 'package:assist_gui/features/settings/controller/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ThemeSwitchIconButton extends StatelessWidget {
  const ThemeSwitchIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final cubit = context.read<SettingsCubit>();
        return ShadIconButton.ghost(
          icon: Icon(
            cubit.themeMode == ThemeMode.dark
                ? LucideIcons.sun
                : LucideIcons.moon,
          ),
          onPressed: cubit.toggleThemeMode,
        );
      },
    );
  }
}
