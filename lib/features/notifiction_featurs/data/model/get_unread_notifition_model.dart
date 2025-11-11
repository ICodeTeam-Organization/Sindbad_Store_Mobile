import '../../domin/entity/get_unread_nutficon.dart';

class GetUnreadNotifitionModel extends GetUnreadNutficonEntity {
  int? count;
  int? action;

  GetUnreadNotifitionModel({this.count, this.action})
      : super(totalUnreadCount: count, actionNumber: count ?? 0);

  factory GetUnreadNotifitionModel.fromJson(Map<String, dynamic> json) {
    return GetUnreadNotifitionModel(
      count: json['count'] as int?,
      action: json['action'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'count': count,
        'action': action,
      };
}
