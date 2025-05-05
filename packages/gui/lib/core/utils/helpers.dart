import 'package:assist_gui/core/utils/extensions.dart';
import 'package:assist_gui/features/auth/controller/auth_cubit.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

typedef AuthBuilder = Widget Function(
  BuildContext context,
  AuthCubit authCubit,
  AuthState state,
  bool isAuthenticated,
);

Widget authBuilder(BuildContext context, {required AuthBuilder builder}) {
  return BlocBuilder<AuthCubit, AuthState>(
    builder: (context, state) {
      final authCubit = context.read<AuthCubit>();
      return builder(context, authCubit, state, state is Authenticated);
    },
  );
}

Future<void> copyAndToast(String text, BuildContext context) async {
  await Clipboard.setData(ClipboardData(text: text));
  if (context.mounted) {
    context.showSonner(
      ShadToast(
        title: Text('Copied'),
      ),
    );
  }
}

TextStyle terminalStyle(BuildContext context) => GoogleFonts.ubuntuMono(
      color: context.colorScheme.mutedForeground,
      fontSize: 14,
    );
