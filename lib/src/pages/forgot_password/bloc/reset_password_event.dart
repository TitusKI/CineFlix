part of 'reset_password_bloc.dart';

sealed class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object> get props => [];
}

class EmailEvent extends ResetPasswordEvent {
  final String? email;
  const EmailEvent({this.email});
}
