import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sindbad_management_app/core/api_service.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/data/model/notifiction_model.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/data/model/read_notifiction_model.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/data/model/unread_notifiction_model.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/domin/entity/get_unread_nutficon.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/domin/entity/nottifction_entity.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/domin/entity/read_notificton.dart';

abstract class NotifictionRemoteDataSource {
  Future<GetUnreadNutficonEntity> getUnreadNotifiction(int type);
  Future<List<NotifctionEntity>> getNotifiction(
      {required int pageNumber, required int pageSize, required int type});
  Future<ReadNotifictonEntity> readNotifction(int id);
}

class NotifictionRemoteDataSourceImpl implements NotifictionRemoteDataSource {
  final ApiService apiService;
  NotifictionRemoteDataSourceImpl(this.apiService);
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  List<T> getNotifictionList<T>(
      Map<String, dynamic> data, T Function(Map<String, dynamic>) fromJson) {
    List<T> entities = [];

    if (data['data']["items"] is List) {
      for (var item in data['data']["items"]) {
        entities.add(fromJson(item));
      }
    } else if (data['message'] != null) {
      // If data['data'] is not a list, add the message to the list
      entities.add(fromJson(data));
    }

    return entities;
  }

  @override
  Future<List<NotifctionEntity>> getNotifiction(
      {required int pageNumber,
      required int pageSize,
      required int type}) async {
    String? token = await storage.read(key: 'token');
    var data = await apiService.get(
      endPoint:
          'Notifications?pageNumber=$pageNumber&pageSize=$pageSize&type=$type',
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    List<NotifctionEntity> notifiction =
        getNotifictionList(data, NotifictionModel.fromJson);
    return notifiction;
  }

  @override
  Future<GetUnreadNutficonEntity> getUnreadNotifiction(int type) async {
    String? token = await storage.read(key: 'token');
    var data = await apiService.get(
      endPoint: 'Notifications/Count',
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    GetUnreadNutficonEntity nutficonEntity =
        UnreadNotifictionModel.fromJson(data.values.last);
    return nutficonEntity;
  }

  @override
  Future<ReadNotifictonEntity> readNotifction(int id) async {
    String? token = await storage.read(key: 'token');
    var data = await apiService.post(
      endPoint: 'Notifications/MarkAsRead?NotificationId=$id',
      headers: {
        'Authorization': 'Bearer $token',
      },
      data: {},
    );
    ReadNotifictonEntity nutficonEntity = ReadNotifictionModel.fromJson(data);
    return nutficonEntity;
  }
}
