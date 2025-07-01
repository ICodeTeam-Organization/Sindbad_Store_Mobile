import '../../domin/entity/get_profile_data_entity.dart';

class ProfileModel extends GetProfileDataEntity {
  String? name;
  String? email;
  String? telePhone;
  String? phoneNumber;
  String? directorate;
  String? governorate;
  int? governorId;
  int? directorateId;

  ProfileModel({
    this.name,
    this.email,
    this.telePhone,
    this.phoneNumber,
    this.directorate,
    this.governorate,
    this.governorId,
    this.directorateId,
  }) : super(
            userEmail: email ?? '',
            userName: name ?? '',
            userPhoneNumber: phoneNumber ?? '',
            userTelphonNumber: telePhone ?? '');

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        name: json['name'] as String?,
        email: json['email'] as String?,
        telePhone: json['telePhone'] as String?,
        phoneNumber: json['phoneNumber'] as String?,
        directorate: json['directorate'] as String?,
        governorate: json['governorate'] as String?,
        governorId: json['governorId'] as int?,
        directorateId: json['directorateId'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'telePhone': telePhone,
        'phoneNumber': phoneNumber,
        'directorate': directorate,
        'governorate': governorate,
        'governorId': governorId,
        'directorateId': directorateId,
      };
}
