class Data {
  String? message;
  bool? isAuthenticated;
  List<String>? userRoles;
  String? token;
  // String? refreshTokenExpiration;
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
        // message: json['message'] as String?,
        // isAuthenticated: json['isAuthenticated'] as bool?,
        // userRoles: json['userRoles'] as List<String>?,
        // token: json['token'] as String?,
        // refreshTokenExpiration: json['refreshTokenExpiration'] as String?,
        // fullName: json['fullName'] as String?,
        // phoneNumber: json['phoneNumber'] as String?,
        // email: json['email'] as String?,

        message: json['message'] as String? ?? "",
        isAuthenticated: json['isAuthenticated'] as bool? ?? false,

        // userRoles: json['userRoles'] as List<String>?,
        userRoles: (json['userRoles'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            [],

        token: json['token'] as String? ?? "",
        refreshTokenExpiration: json['refreshTokenExpiration'] == null
            ? null
            : DateTime.parse(json['refreshTokenExpiration'] as String),
        fullName: json['fullName'] as String? ?? "",
        phoneNumber: json['phoneNumber'] as String? ?? "",
        email: json['email'] as String? ?? "",
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'isAuthenticated': isAuthenticated,
        'userRoles': userRoles,
        'token': token,
        'refreshTokenExpiration': refreshTokenExpiration,
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        'email': email,
      };
}
