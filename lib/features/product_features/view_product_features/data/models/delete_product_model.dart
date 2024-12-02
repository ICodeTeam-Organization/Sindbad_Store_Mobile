import '../../domain/entities/delete_entity_product.dart';

class DeleteProductModel extends DeleteProductEntity {
  bool? success;
  String? kmessage;

  DeleteProductModel({this.success, this.kmessage})
      : super(isSuuccess: success!, message: kmessage!);

  factory DeleteProductModel.fromJson(Map<String, dynamic> json) {
    return DeleteProductModel(
      success: json['success'] as bool?,
      kmessage: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
      };
}
