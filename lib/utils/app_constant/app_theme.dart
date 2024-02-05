import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final appThemeData = ThemeData(
  primarySwatch: Colors.purple,

  useMaterial3: true,

  visualDensity: VisualDensity.adaptivePlatformDensity,
  // canvasColor: Colors.red,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.blue,
    systemOverlayStyle: const SystemUiOverlayStyle().copyWith(
      statusBarColor: Colors.grey[50],
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarContrastEnforced: true,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  ),

  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {},
  ),
);
