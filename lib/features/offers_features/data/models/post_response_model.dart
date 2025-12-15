import 'package:sindbad_management_app/features/offers_features/domain/entities/post_response_entity.dart';

class PostResponseModel extends PostResponseEntity {
  bool? success;
  String? message;

  PostResponseModel({
    this.success,
    this.message,
  }) : super(
          isSuccess: success ?? false,
          serverMessage: message ?? '',
        );

  factory PostResponseModel.fromJson(Map<String, dynamic> json) {
    return PostResponseModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
      };
}
