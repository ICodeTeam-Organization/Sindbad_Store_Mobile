class ResetPasswordEntity {
  // complete after the backend is ready
  final bool isSuccess;
  final String serverMessage;
  final List<String> errorsList;
  final bool dataContent;

  ResetPasswordEntity({
    required this.isSuccess,
    required this.serverMessage,
    required this.errorsList,
    required this.dataContent,
  });
}
