import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/domain/entities/add_offer_entity.dart';

class AddOfferModel extends AddOfferEntity {
  bool? success;
  String? message;

  AddOfferModel({
    this.success,
    this.message,
  }) : super(
          isSuccess: success ?? false,
          serverMessage: message ?? '',
        );

  factory AddOfferModel.fromJson(Map<String, dynamic> json) {
    return AddOfferModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
      };
}
