part of 'signup_cubit.dart';

@immutable
sealed class SignupState {}

final class SignupInitial extends SignupState {}

final class SignupLoading extends SignupState {}

final class SignupSucess extends SignupState {
  final UserEntity userentity;

  SignupSucess({required this.userentity});
}

final class SignupFailure extends SignupState {
  final String message;

  SignupFailure({required this.message});
}
