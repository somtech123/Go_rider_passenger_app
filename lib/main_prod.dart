import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_rider/app/resouces/app_logger.dart';
import 'package:go_rider/global.dart';
import 'package:go_rider/go_rider.dart';

var log = getLogger('main');

Future<void> main() async {
  Global.baseUrl = "https//go_rider/prod/";

  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    sound: true,
  );

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  ).then((value) => runApp(const GoRider()));
}

Future<void> backgroundHandler(RemoteMessage message) async {
  log.wtf(message.data.toString());
  log.wtf(message.notification!.title);
}
