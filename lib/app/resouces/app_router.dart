import 'package:go_rider/app/resouces/navigation_services.dart';
import 'package:go_rider/ui/features/authentication/login/presentation/view/login_screen.dart';
import 'package:go_rider/ui/features/authentication/signup/prsentation/view/sign_up_screen.dart';
import 'package:go_rider/ui/features/chat/presentation/view/chat_screen.dart';
import 'package:go_rider/ui/features/chat/presentation/view/view_layout.dart';
import 'package:go_rider/ui/features/dashboard/presentation/view/home_screen.dart';
import 'package:go_rider/ui/features/dashboard/presentation/view/ride_detail_screen.dart';
import 'package:go_rider/ui/features/history/presentation/view/history.dart';
import 'package:go_rider/ui/features/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    navigatorKey: NavigationService.navigatorKey,
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
          path: '/homePage', builder: (context, state) => const HomeScreen()),
      GoRoute(
          path: '/signUp', builder: (context, state) => const SignUpScreen()),
      GoRoute(
          path: '/rideDetail',
          builder: (context, state) => const RideDetailScreen()),
      GoRoute(
          path: '/historyPage',
          builder: (context, state) => const HistoryScreen()),
      GoRoute(
          path: '/chatPage', builder: (context, state) => const ChatScreen()),
      GoRoute(
          path: '/chatDetail', builder: (context, state) => const ViewLayout())
    ],
  );
}
