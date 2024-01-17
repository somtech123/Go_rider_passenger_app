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
      //systemNavigationBarColor: Colors.grey[50],
      systemNavigationBarContrastEnforced: true,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  ),
  // bottomSheetTheme: const BottomSheetThemeData(
  //     backgroundColor: Colors.transparent,
  //     shadowColor: Colors.transparent,
  //     modalBackgroundColor: Colors.transparent,
  //     surfaceTintColor: Colors.transparent,
  //     clipBehavior: Clip.hardEdge),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {},
  ),
);
