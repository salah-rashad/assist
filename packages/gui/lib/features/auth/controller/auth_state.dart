part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class Unauthenticated extends AuthState {}

final class Authenticated extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthWaitingForUserVerification extends AuthState {}

// final class AuthCodeReceived extends AuthState {
//   final String userCode;
//   final String verificationUri;
//
//   AuthCodeReceived(this.userCode, this.verificationUri);
// }

final class AuthLoginFailure extends AuthState {
  final String message;

  AuthLoginFailure(this.message);
}
