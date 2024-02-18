// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';
import 'package:go_rider/app/api/api.dart';
import 'package:go_rider/app/api/endpoint.dart';
import 'package:go_rider/app/services/notification/notification_repo.dart';

class NotificationRepoImplementation extends NotificationRepo {
  final Api _api = Api(Dio());

  @override
  sendPushNotification(Map<String, dynamic> payload) async {
    try {
      return await _api.dio.post(Endpoint.sendPushNotification, data: payload);
    } on DioError catch (e) {
      return _api.handleError(e);
    }
  }
}
