class RegisterStates {
  final String userName;
  final String email;
  final String password;
  final String repassword;

  const RegisterStates(
      {this.userName = "", this.email  = "", this.password  = "", this.repassword  = ""});

  RegisterStates copyWith({
    String? userName,
    String? email,
    String? password,
    String? repassword,
  }) {
    return RegisterStates(userName: userName ?? this.userName, email: email ?? this.email,
        password:password??this.password,  repassword :repassword ?? this.repassword);
  }
}
