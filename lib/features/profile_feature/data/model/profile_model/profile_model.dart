import 'package:sindbad_management_app/features/profile_feature/domin/entity/get_profile_data_entity.dart';

import 'user.dart';

class ProfileModel extends GetProfileDataEntity {
  String? id;
  List<int>? categoriesId;
  User? user;

  ProfileModel({this.id, this.categoriesId, this.user})
      : super(
            userEmail: user?.email ?? '',
            userName: user?.name ?? '',
            userPhoneNumber: user?.phoneNumber ?? '',
            userCuntry: user?.country ?? 0,
            userCategory: categoriesId?.cast<int>() ?? []);

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json['id'] as String?,
        categoriesId: json['categoriesId'] != null
            ? List<int>.from(json['categoriesId'])
            : null,
        user: json['user'] == null
            ? null
            : User.fromJson(json['user'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'categoriesId': categoriesId,
        'user': user?.toJson(),
      };
}
