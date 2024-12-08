import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/entities/delete_offer_entity.dart';

class DeleteOfferModel extends DeleteOfferEntity {
  bool? success;
  String? message;

  DeleteOfferModel({
    this.success,
    this.message,
  }) : super(
          isSuccess: success ?? false,
          serverMessage: message ?? '',
        );

  factory DeleteOfferModel.fromJson(Map<String, dynamic> json) {
    return DeleteOfferModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
      };
}
