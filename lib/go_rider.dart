import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_rider/app/resouces/app_logger.dart';
import 'package:go_rider/app/resouces/app_router.dart';
import 'package:go_rider/app/resouces/navigation_services.dart';
import 'package:go_rider/play.dart';
import 'package:go_rider/ui/features/account/presentation/bloc/account_bloc.dart';
import 'package:go_rider/ui/features/authentication/login/presentation/bloc/login_bloc.dart';
import 'package:go_rider/ui/features/authentication/signup/prsentation/bloc/sign_up_bloc.dart';
import 'package:go_rider/ui/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:go_rider/ui/features/history/presentation/bloc/history_bloc.dart';
import 'package:go_rider/utils/app_constant/app_theme.dart';
import 'package:go_rider/utils/app_wrapper/app_wrapper.dart';
import 'package:go_rider/ui/features/dashboard/presentation/bloc/home_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

var log = getLogger('go_rider');

class GoRider extends StatefulWidget {
  const GoRider({super.key});

  @override
  State<GoRider> createState() => _GoRiderState();
}

class _GoRiderState extends State<GoRider> {
  void initFirebase(BuildContext context) async {
    NotificationService().setUp();

    ///gives you the message on which user taps
    ///and it opened the app from terminated state
    ///
    
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final routeFromMessage = message.data["route"];

        context.goNamed(routeFromMessage);
      }
    });

    //forground work
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        log.w(message.notification!.body);
        log.w(message.notification!.title);
      }

      NotificationService().showNotification(
          body: message.notification!.body!,
          title: message.notification!.title!);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeFromMessage = message.data["route"];

      context.goNamed(routeFromMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    initFirebase(context);

    return ScreenUtilInit(builder: (context, child) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<HomePageBloc>(create: (context) => HomePageBloc()),
          BlocProvider<SignUpBloc>(create: (context) => SignUpBloc()),
          BlocProvider<LoginBloc>(create: (context) => LoginBloc()),
          BlocProvider<HistoryBloc>(create: (context) => HistoryBloc()),
          BlocProvider<ChatBloc>(create: (context) => ChatBloc()),
          BlocProvider<AccountBloc>(create: (context) => AccountBloc()),
        ],
        child: ChangeNotifierProvider(
          create: (_) {},
          child: AppMainWrapper(
            child: MaterialApp.router(
              title: 'Go Rider',
              scaffoldMessengerKey: NavigationService.scaffoldMessengerKey,
              debugShowCheckedModeBanner: false,
              theme: appThemeData,

              builder: EasyLoading.init(),

              /// GoRouter specific params
              routeInformationProvider: _router.routeInformationProvider,
              routeInformationParser: _router.routeInformationParser,
              routerDelegate: _router.routerDelegate,
            ),
          ),
        ),
      );
    });
  }

  final _router = AppRouter.router;
}
