import 'package:sindbad_management_app/features/notifiction_featurs/domin/entity/get_unread_nutficon.dart';

class UnreadNotifictionModel extends GetUnreadNutficonEntity {
  int? all;
  int? orders;
  int? specials;

  UnreadNotifictionModel({this.all, this.orders, this.specials})
      : super(
            allNotfiction: all ?? 0,
            orderOnly: orders ?? 0,
            specialOrderOnly: specials ?? 0);

  factory UnreadNotifictionModel.fromJson(Map<String, dynamic> json) {
    return UnreadNotifictionModel(
      all: json['all'] as int?,
      orders: json['orders'] as int?,
      specials: json['specials'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'all': all,
        'orders': orders,
        'specials': specials,
      };
}
