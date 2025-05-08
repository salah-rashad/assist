import 'dart:developer';

import 'package:assist_core/assist_core.dart';
import 'package:assist_core/constants/strings.dart';
import 'package:assist_core/services/service.github_login.dart';
import 'package:assist_core/services/service.secure_storage.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(Unauthenticated()) {
    fetchUser();
  }

  final loginSession = GithubLoginSession(clientId: Strings.githubClientId);

  CurrentUser user = CurrentUser();

  Future<void> loginWithGitHub({OnAuthCodeReceived? onAuthCodeReceived}) async {
    emit(AuthLoading());

    // register on auth code received
    loginSession.onAuthCodeReceived = (userCode, verificationUri) {
      onAuthCodeReceived?.call(userCode, verificationUri);
      emit(AuthWaitingForUserVerification());
    };

    // register on session timeout callback
    loginSession.onSessionCompleted = (accessToken) async {
      log('Access token: $accessToken');
      SecureStorageManager.saveToken(accessToken);
      emit(Authenticated());

      fetchUser();
    };

    // register on session timeout callback
    loginSession.onSessionError = (error) {
      log('Error', error: error);
      emit(AuthLoginFailure(error));
    };

    // start login session
    await loginSession.start();
  }

  Future<void> fetchUser() async {
    final token = SecureStorageManager.getToken();

    if (token == null) {
      emit(Unauthenticated());
      return;
    }

    emit(AuthLoading());
    try {
      user = await github.users.getCurrentUser();
      emit(Authenticated());
    } catch (e) {
      log('Error', error: e);
      emit(Unauthenticated());
    }
  }
}
