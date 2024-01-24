import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_rider/app/resouces/app_router.dart';
import 'package:go_rider/app/resouces/navigation_services.dart';
import 'package:go_rider/ui/features/authentication/login/presentation/bloc/login_bloc.dart';
import 'package:go_rider/ui/features/authentication/signup/prsentation/bloc/sign_up_bloc.dart';
import 'package:go_rider/utils/app_constant/app_theme.dart';
import 'package:go_rider/utils/app_wrapper/app_wrapper.dart';
import 'package:go_rider/ui/features/dashboard/presentation/bloc/home_bloc.dart';
import 'package:provider/provider.dart';

class GoRider extends StatefulWidget {
  const GoRider({super.key});

  @override
  State<GoRider> createState() => _GoRiderState();
}

class _GoRiderState extends State<GoRider> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (context, child) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<HomePageBloc>(create: (context) => HomePageBloc()),
          BlocProvider<SignUpBloc>(create: (context) => SignUpBloc()),
          BlocProvider<LoginBloc>(create: (context) => LoginBloc())
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
