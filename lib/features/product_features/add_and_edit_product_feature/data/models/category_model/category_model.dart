import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/entities/add_product_entities/main_category_entity.dart';

import 'data.dart';

class CategoryModel extends CategoryEntity {
  bool? success;
  String? message;
  List<String>? errors;
  CategoryModels? data;

  CategoryModel({this.success, this.message, this.errors, this.data})
      : super(
            categoryId: data?.id ?? 0,
            categoryName: data?.name ?? '',
            categoryImage: data?.imageUrl ?? '',
            categoryLevel: data?.level ?? 0,
            categoryParentId: data?.parentId ?? 0,
            categoryType: data?.type ?? 1);

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        success: json['success'] as bool?,
        message: json['message'] as String?,
        errors: json['errors'] as List<String>?,
        data: json['data'] == null
            ? null
            : CategoryModels.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'errors': errors,
        'data': data?.toJson(),
      };
}
