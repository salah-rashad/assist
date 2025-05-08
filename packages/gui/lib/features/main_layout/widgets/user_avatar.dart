import 'package:assist_gui/features/auth/controller/auth_cubit.dart';
import 'package:assist_gui/shared/dialogs/github_login_verification_dialog.dart';
import 'package:assist_gui/shared/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoginFailure) {
          ShadSonner.maybeOf(context)?.show(
            ShadToast.destructive(
              title: Text('Error'),
              description: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<AuthCubit>();
        final isAuthenticated = state is Authenticated;
        final isLoading = state is AuthLoading;
        return GestureDetector(
          onTap: () {
            if (!isAuthenticated && !isLoading) {
              cubit.loginWithGitHub(
                onAuthCodeReceived: (userCode, verificationUri) {
                  _showVerificationDialog(context, userCode, verificationUri);
                },
              );
            }
          },
          child: isLoading ? buildLoading() : buildShadAvatar(cubit),
        );
      },
    );
  }

  ShadAvatar buildShadAvatar(AuthCubit cubit) {
    return ShadAvatar(cubit.user.avatarUrl ?? LucideIcons.userRound);
  }

  SizedBox buildLoading() {
    return SizedBox.square(
      dimension: 40,
      child: Center(
        child: LoadingIndicator(size: 24, strokeWidth: 2),
      ),
    );
  }

  void _showVerificationDialog(
    BuildContext context,
    String code,
    String verificationUri,
  ) {
    void cancelSession(BuildContext ctx) =>
        ctx.read<AuthCubit>().loginSession.cancel();

    showShadDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              ShadSonner.of(context).show(
                ShadToast(
                  title: Text('Welcome back!'),
                  description: Text('You are now logged in'),
                ),
              );
              context.pop('success');
            }
          },
          child: PopScope(
            onPopInvokedWithResult: (didPop, result) {
              if (didPop && result != 'success') {
                cancelSession(context);
              }
            },
            child: GithubLoginVerificationDialog(
              code: code,
              verificationUri: verificationUri,
            ),
          ),
        );
      },
    );
  }
}
