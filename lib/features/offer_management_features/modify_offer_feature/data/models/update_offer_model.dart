import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/domain/entities/update_offer_entity.dart';

class UpdateOfferModel extends UpdateOfferEntity {
  bool? success;
  String? message;

  UpdateOfferModel({
    this.success,
    this.message,
  }) : super(
          isSuccess: success ?? false,
          serverMessage: message ?? '',
        );

  factory UpdateOfferModel.fromJson(Map<String, dynamic> json) {
    return UpdateOfferModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
      };
}
