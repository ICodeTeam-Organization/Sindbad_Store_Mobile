import '../../../domain/entities/edit_product_entities/product_attribute_entity.dart';

class AttributesWithValue extends ProductAttributeEntity {
  String? attributeName;
  List<String>? values;

  AttributesWithValue({this.attributeName, this.values})
      : super(
          attributeNameProduct: attributeName ?? '',
          valueProduct: values ?? [],
        );

  factory AttributesWithValue.fromJson(Map<String, dynamic> json) {
    return AttributesWithValue(
      attributeName: json['attributeName'] as String?,
      values: json['values'] as List<String>?,
    );
  }

  Map<String, dynamic> toJson() => {
        'attributeName': attributeName,
        'values': values,
      };
}
