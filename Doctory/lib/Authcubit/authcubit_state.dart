part of 'authcubit_cubit.dart';


sealed class AuthcubitState {
  const AuthcubitState();
}

final class AuthInitial extends AuthcubitState {}

final class AuthLoading extends AuthcubitState {}

final class AuthDone extends AuthcubitState {
  const AuthDone();
}

final class AuthError extends AuthcubitState {
  final String message;
  const AuthError(this.message);
}


