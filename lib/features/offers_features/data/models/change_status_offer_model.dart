import 'package:sindbad_management_app/features/offers_features/domain/entities/post_response_entity.dart';

class ChangeStatusOfferModel extends PostResponseEntity {
  bool? success;
  String? message;

  ChangeStatusOfferModel({
    this.success,
    this.message,
  }) : super(
          isSuccess: success ?? false,
          serverMessage: message ?? '',
        );

  factory ChangeStatusOfferModel.fromJson(Map<String, dynamic> json) {
    return ChangeStatusOfferModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
      };
}
