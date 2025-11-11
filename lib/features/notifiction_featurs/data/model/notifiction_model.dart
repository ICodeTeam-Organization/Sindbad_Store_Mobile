import 'package:sindbad_management_app/features/notifiction_featurs/domin/entity/nottifction_entity.dart';

class NotifictionModel extends NotifctionEntity {
  int? id;
  int? target;
  String? title;
  String? body;
  String? imageUrl;
  DateTime? createdAt;
  int? action;
  bool? isRead;

  NotifictionModel({
    this.id,
    this.target,
    this.title,
    this.body,
    this.imageUrl,
    this.createdAt,
    this.action,
    this.isRead,
  }) : super(
            notficationDate: createdAt ?? DateTime.now(),
            notficationTitle: title ?? '',
            notficationstatus: isRead ?? false,
            orderNumber: '',
            notficationAction: action ?? 0,
            notficationBody: body ?? '',
            notifictionId: id ?? 0,
            orderId: target ?? 0);

  factory NotifictionModel.fromJson(Map<String, dynamic> json) {
    return NotifictionModel(
      id: json['id'] as int?,
      target: json['target'] as int?,
      title: json['title'] as String?,
      body: json['body'] as String?,
      imageUrl: json['imageUrl'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      action: json['action'] as int?,
      isRead: json['isRead'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'target': target,
        'title': title,
        'body': body,
        'imageUrl': imageUrl,
        'createdAt': createdAt?.toIso8601String(),
        'action': action,
        'isRead': isRead,
      };
}
