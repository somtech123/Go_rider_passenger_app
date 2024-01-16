import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_rider/app/resouces/app_logger.dart';
import 'package:go_rider/go_rider.dart';

var log = getLogger('main');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  ).then((value) => runApp(const GoRider()));
}
