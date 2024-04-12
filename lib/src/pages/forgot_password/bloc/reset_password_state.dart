part of 'reset_password_bloc.dart';

class ResetPasswordState {
  final String email;
  const ResetPasswordState({this.email = ""});
  ResetPasswordState copyWith({String? email}) {
    return ResetPasswordState(email: email ?? this.email);
  }
}
