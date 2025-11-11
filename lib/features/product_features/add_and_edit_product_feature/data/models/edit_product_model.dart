import '../../domain/entities/edit_product_entities/edit_product_entity.dart';

class EditProductModel extends EditProductEntity {
  final bool successM;
  final String messageM;
  List<String>? errors;
  String? data;

  EditProductModel(
      {required this.successM, required this.messageM, this.errors, this.data})
      : super(success: successM, message: messageM);

  factory EditProductModel.fromJson(Map<String, dynamic> json) {
    return EditProductModel(
      successM: json['success'] as bool,
      messageM: json['message'] as String,
      errors: json['errors'] as List<String>?,
      data: json['data'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'errors': errors,
        'data': data,
      };
}
