class User {
  String? id;
  String? name;
  String? phoneNumber;
  String? email;
  String? role;
  bool? isActive;
  int? country;

  User({
    this.id,
    this.name,
    this.phoneNumber,
    this.email,
    this.role,
    this.isActive,
    this.country,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as String?,
        name: json['name'] as String?,
        phoneNumber: json['phoneNumber'] as String?,
        email: json['email'] as String?,
        role: json['role'] as String?,
        isActive: json['isActive'] as bool?,
        country: json['country'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phoneNumber': phoneNumber,
        'email': email,
        'role': role,
        'isActive': isActive,
        'country': country,
      };
}
