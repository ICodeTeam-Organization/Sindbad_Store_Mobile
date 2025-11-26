import '../../../domain/entities/edit_product_entities/product_attribute_entity.dart';

class AttributesWithValue extends ProductAttributeEntity {
  String? attributeName;
  String? values;

  AttributesWithValue({this.attributeName, this.values})
      : super(
            attributeNameProduct: attributeName ?? '',
            valueProduct: values ?? '');

  factory AttributesWithValue.fromJson(Map<String, dynamic> json) {
    return AttributesWithValue(
      attributeName: json['attributeName'] as String?,
      values: json['attributeValue'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'attributeName': attributeName,
        'attributeValue': values,
      };
}
