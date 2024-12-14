// import 'sub_category.dart';

// class Item {
// 	int? id;
// 	String? categoryName;
// 	String? categoryImageUrl;
// 	List<SubCategory>? subCategories;

// 	Item({
// 		this.id, 
// 		this.categoryName, 
// 		this.categoryImageUrl, 
// 		this.subCategories, 
// 	});

// 	factory Item.fromJson(Map<String, dynamic> json) => Item(
// 				id: json['id'] as int?,
// 				categoryName: json['categoryName'] as String?,
// 				categoryImageUrl: json['categoryImageUrl'] as String?,
// 				subCategories: (json['subCategories'] as List<dynamic>?)
// 						?.map((e) => SubCategory.fromJson(e as Map<String, dynamic>))
// 						.toList(),
// 			);

// 	Map<String, dynamic> toJson() => {
// 				'id': id,
// 				'categoryName': categoryName,
// 				'categoryImageUrl': categoryImageUrl,
// 				'subCategories': subCategories?.map((e) => e.toJson()).toList(),
// 			};
// }
