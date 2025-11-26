import '../../../domain/entities/disable_products_entity.dart';

class DisableProductsModel extends DisableProductsEntity {
  final bool successModel;
  final String messageModel;

  DisableProductsModel({required this.successModel, required this.messageModel})
      : super(success: successModel, message: messageModel);

  factory DisableProductsModel.fromJson(Map<String, dynamic> json) {
    return DisableProductsModel(
      successModel: json['success'] as bool,
      messageModel: json['message'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'success': successModel,
        'message': messageModel,
      };
}
