class ResponseModel {
  final bool success;
  final String message;
  final AuthData? data;

  ResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? AuthData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class AuthData {
  final String? message;
  final bool isAuthenticated;
  final List<String> userRoles;
  final String token;
  final String refreshTokenExpiration;
  final String fullName;
  final String phoneNumber;
  final String email;
  final String country;

  AuthData({
    this.message,
    required this.isAuthenticated,
    required this.userRoles,
    required this.token,
    required this.refreshTokenExpiration,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.country,
  });

  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData(
      message: json['message'],
      isAuthenticated: json['isAuthenticated'] ?? false,
      userRoles: List<String>.from(json['userRoles'] ?? []),
      token: json['token'] ?? '',
      refreshTokenExpiration: json['refreshTokenExpiration'] ?? '',
      fullName: json['fullName'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      email: json['email'] ?? '',
      country: json['country'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'isAuthenticated': isAuthenticated,
      'userRoles': userRoles,
      'token': token,
      'refreshTokenExpiration': refreshTokenExpiration,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
      'country': country,
    };
  }
}
