class SignInEntity {
  final bool isSuccess;
  final String serverMessage;

  final String dataMessage;
  final bool isAuthenticated;
  final List<dynamic> userRoles;

  final String token;
  final String fullName;
  final String phoneNumber;
  final String email;
  final String userCuntry;

  SignInEntity(
      {required this.isSuccess,
      required this.serverMessage,
      required this.dataMessage,
      required this.isAuthenticated,
      required this.userRoles,
      required this.token,
      required this.fullName,
      required this.phoneNumber,
      required this.email,
      required this.userCuntry});
}
