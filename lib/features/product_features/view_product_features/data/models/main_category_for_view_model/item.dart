import '../../../domain/entities/main_category_for_view_entity.dart';

class Item extends MainCategoryForViewEntity {
  final int id;
  final String name;

  Item({required this.id, required this.name})
      : super(mainCategoryId: id, mainCategoryName: name);

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json['id'] as int,
        name: json['name'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
