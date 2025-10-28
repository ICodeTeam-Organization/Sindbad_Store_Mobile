class GetProfileDataEntity {
  final String userPhoneNumber;
  final String userName;
  final String userEmail;
  final int userCuntry;
  List<int> userCategory;
  GetProfileDataEntity({
    required this.userEmail,
    required this.userName,
    required this.userPhoneNumber,
    required this.userCuntry,
    required this.userCategory,
  });
}
