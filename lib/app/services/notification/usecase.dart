import 'package:dio/dio.dart';
import 'package:go_rider/app/api/api_response_model.dart';
import 'package:go_rider/app/resouces/app_logger.dart';
import 'package:go_rider/app/services/notification/notification_repo_implementation.dart';

var log = getLogger('notification_services');

class NotificationServices {
  NotificationRepoImplementation notificationRepoImplementation;
  NotificationServices(this.notificationRepoImplementation);

  Future<ResponseModel> sendPushNotification(
      Map<String, dynamic> payload) async {
    Response response =
        await notificationRepoImplementation.sendPushNotification(payload);
    int statusCode = response.statusCode ?? 000;
    log.w('DDDDDDDDDDDDDDDDDDDDDDDDDDDDDstatus: [INFO] ${response.statusCode}');
    log.w('DDDDDDDDDDDDDDDDDDDDDDDDDDDDDdata: [INFO] ${response.data}');

    if (statusCode >= 200 && statusCode <= 300) {
      return ResponseModel(
        status: true,
        message: response.statusMessage,
        data: response.data,
      );
    }
    return ResponseModel(
      status: false,
      message: response.data["failure"],
    );
  }
}
