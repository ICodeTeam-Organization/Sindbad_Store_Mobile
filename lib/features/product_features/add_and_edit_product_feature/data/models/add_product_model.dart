import '../../domain/entities/add_product_entity.dart';

class AddProductModel extends AddProductEntity {
  bool? successModel;
  String? messageModel;

  AddProductModel({this.successModel, this.messageModel})
      : super(
            success: successModel ?? false, message: messageModel ?? 'لا يوجد');

  factory AddProductModel.fromJson(Map<String, dynamic> json) {
    return AddProductModel(
      successModel: json['success'] as bool?,
      messageModel: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'success': successModel,
        'message': messageModel,
      };
}
