// import 'item.dart';

// class Data {
// 	List<Item>? items;
// 	int? totalCount;
// 	int? totalPages;
// 	int? currentPage;
// 	int? pageSize;

// 	Data({
// 		this.items,
// 		this.totalCount,
// 		this.totalPages,
// 		this.currentPage,
// 		this.pageSize,
// 	});

// 	factory Data.fromJson(Map<String, dynamic> json) => Data(
// 				items: (json['items'] as List<dynamic>?)
// 						?.map((e) => Item.fromJson(e as Map<String, dynamic>))
// 						.toList(),
// 				totalCount: json['totalCount'] as int?,
// 				totalPages: json['totalPages'] as int?,
// 				currentPage: json['currentPage'] as int?,
// 				pageSize: json['pageSize'] as int?,
// 			);

// 	Map<String, dynamic> toJson() => {
// 				'items': items?.map((e) => e.toJson()).toList(),
// 				'totalCount': totalCount,
// 				'totalPages': totalPages,
// 				'currentPage': currentPage,
// 				'pageSize': pageSize,
// 			};
// }
