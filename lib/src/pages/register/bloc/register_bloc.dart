import 'package:cineflix/src/pages/register/bloc/register_event.dart';
import 'package:cineflix/src/pages/register/bloc/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvents, RegisterStates> {
  RegisterBloc() : super(const RegisterStates()) {
    on<UserNameEvent>(_userNameEvent);
        on<EmailEvent>(_emailEvent);
    on<PasswordEvent>(_passwordEvent);
    on<RepasswordEvent>(_repasswordEvent);

  }
  void _userNameEvent(UserNameEvent event, Emitter<RegisterStates> emit) {
   print("${event.userName}");
    emit(
      state.copyWith(
        userName: event.userName
      ),
    );
  }
  void _emailEvent(EmailEvent event, Emitter<RegisterStates> emit) {
       print("${event.email}");

    emit(
      state.copyWith(
        email: event.email
      ),
    );
  }
  void _passwordEvent(PasswordEvent event, Emitter<RegisterStates> emit) {
       print("${event.password}");

    emit(
      state.copyWith(
        password: event.password
      ),
    );
  }
  void _repasswordEvent(RepasswordEvent event, Emitter<RegisterStates> emit) {
       print("${event.repassword}");

    emit(
      state.copyWith(
        repassword: event.repassword
      ),
    );
  }
}
