import '../../domain/entities/delete_entity_product.dart';

class DeleteProductModel extends DeleteProductEntity {
  bool? success;
  String? message;

  DeleteProductModel({this.success, this.message})
      : super(isSuuccess: success!, errorMessage: message!);

  factory DeleteProductModel.fromJson(Map<String, dynamic> json) {
    return DeleteProductModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
      };
}
