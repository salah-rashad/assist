import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/controller/auth_cubit.dart';

typedef AuthBuilder =
    Widget Function(
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
