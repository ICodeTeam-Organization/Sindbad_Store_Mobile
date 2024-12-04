import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/entities/change_status_offer_entity.dart';

class ChangeStatusOfferModel extends ChangeStatusOfferEntity {
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
