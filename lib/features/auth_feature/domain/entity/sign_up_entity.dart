class SignUpEntity {
  final bool isSuccess;
  final String serverMessage;
  final String name;
  final String phoneNumber;
  final String email;
  final List<String> roleName;
  final String? password;
  final String? confirmPassword;
  final String token;

  SignUpEntity({
    required this.name,
    required this.isSuccess,
    required this.serverMessage,
    required this.phoneNumber,
    required this.email,
    required this.roleName,
    required this.token,
    this.password,
    this.confirmPassword,
  });
}
