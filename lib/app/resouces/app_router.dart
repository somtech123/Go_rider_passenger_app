import 'package:go_rider/app/resouces/app_transition.dart';
import 'package:go_rider/app/resouces/navigation_services.dart';
import 'package:go_rider/ui/features/account/presentation/view/account.dart';
import 'package:go_rider/ui/features/authentication/login/presentation/view/login_screen.dart';
import 'package:go_rider/ui/features/authentication/reset_password/presntation/view/forgotten_password_screen.dart';
import 'package:go_rider/ui/features/authentication/signup/prsentation/view/sign_up_screen.dart';
import 'package:go_rider/ui/features/chat/presentation/view/chat_screen.dart';
import 'package:go_rider/ui/features/dashboard/data/rider_model.dart';
import 'package:go_rider/ui/features/dashboard/presentation/view/home_screen.dart';
import 'package:go_rider/ui/features/dashboard/presentation/view/widget/ride_detail_screen.dart';
import 'package:go_rider/ui/features/dashboard/presentation/view/widget/route_screen.dart';
import 'package:go_rider/ui/features/history/presentation/view/history.dart';
import 'package:go_rider/ui/features/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    navigatorKey: NavigationService.navigatorKey,
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(
          path: '/login',
          pageBuilder: (context, state) => CustomNormalPageTransition(
              child: const LoginScreen(), key: state.pageKey)),
      GoRoute(
          path: '/homePage',
          pageBuilder: (context, state) => CustomNormalPageTransition(
              child: const HomeScreen(), key: state.pageKey)),
      GoRoute(
        path: '/signUp',
        pageBuilder: (context, state) => CustomNormalPageTransition(
            child: const SignUpScreen(), key: state.pageKey),
      ),
      GoRoute(
          path: '/passwordReset',
          builder: (context, state) => const ForgottenPasswordScreen()),
      GoRoute(
        path: '/account',
        pageBuilder: (context, state) => CustomSlideTransition(
            key: state.pageKey, child: const AccountScreen()),
      ),
      GoRoute(
        path: '/route',
        pageBuilder: (context, state) => CustomFadeTransition(
            child: const RouteScreen(), key: state.pageKey),
      ),
      GoRoute(
          path: '/rideDetail',
          pageBuilder: (context, state) {
            RiderModel riderModel = state.extra as RiderModel;
            return CustomSlideTransition(
                child: RideDetailScreen(riderModel: riderModel),
                key: state.pageKey);
          }),
      GoRoute(
          path: '/historyPage',
          pageBuilder: (context, state) => CustomSizeTransition(
              key: state.pageKey, child: const HistoryScreen())),
      GoRoute(
          path: '/chatPage', builder: (context, state) => const ChatScreen()),
    ],
  );
}
