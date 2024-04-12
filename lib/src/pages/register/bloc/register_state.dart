class RegisterStates {
  final String userName;
  final String email;
  final String password;
  final String repassword;

  const RegisterStates(
      {this.userName = "",
      this.email = "",
      this.password = "",
      this.repassword = ""});

  RegisterStates copyWith({
    String? userName,
    String? email,
    String? password,
    String? repassword,
  }) {
    return RegisterStates(
        userName: userName ?? this.userName,
        email: email ?? this.email,
        password: password ?? this.password,
        repassword: repassword ?? this.repassword);
  }
}

class RegisterSuccessState extends RegisterStates {
  final bool isRegisterSuccess;
  const RegisterSuccessState({this.isRegisterSuccess = false});
}

class RegisterLoadingState extends RegisterStates {
  final bool isRegisterLoading;
  const RegisterLoadingState({this.isRegisterLoading = false});
}

class RegisterFailurState extends RegisterStates {
  final String error;
  const RegisterFailurState(this.error);
  @override
  List<Object> get props => [error];
}
