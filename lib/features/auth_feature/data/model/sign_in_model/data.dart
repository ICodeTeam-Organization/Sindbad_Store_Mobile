class Data {
  String? message;
  bool? isAuthenticated;
  List<dynamic>? userRoles;
  String? token;
  DateTime? refreshTokenExpiration;
  String? fullName;
  String? phoneNumber;
  String? email;

  Data({
    this.message,
    this.isAuthenticated,
    this.userRoles,
    this.token,
    this.refreshTokenExpiration,
    this.fullName,
    this.phoneNumber,
    this.email,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json['message'] as String?,
        isAuthenticated: json['isAuthenticated'] as bool?,
        userRoles: json['userRoles'] as List<dynamic>?,
        token: json['token'] as String?,
        refreshTokenExpiration: json['refreshTokenExpiration'] == null
            ? null
            : DateTime.parse(json['refreshTokenExpiration'] as String),
        fullName: json['fullName'] as String?,
        phoneNumber: json['phoneNumber'] as String?,
        email: json['email'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'isAuthenticated': isAuthenticated,
        'userRoles': userRoles,
        'token': token,
        'refreshTokenExpiration': refreshTokenExpiration?.toIso8601String(),
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        'email': email,
      };
}
