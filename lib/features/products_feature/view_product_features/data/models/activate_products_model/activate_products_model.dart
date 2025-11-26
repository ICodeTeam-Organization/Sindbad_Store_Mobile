import '../../../domain/entities/activate_products_entity.dart';

class ActivateProductsModel extends ActivateProductsEntity {
  final bool successModel;
  final String messageModel;

  ActivateProductsModel(
      {required this.successModel, required this.messageModel})
      : super(success: successModel, message: messageModel);

  factory ActivateProductsModel.fromJson(Map<String, dynamic> json) {
    return ActivateProductsModel(
      successModel: json['success'] as bool,
      messageModel: json['message'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'success': successModel,
        'message': messageModel,
      };
}
