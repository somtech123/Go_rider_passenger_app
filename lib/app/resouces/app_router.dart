import 'package:go_rider/app/resouces/navigation_services.dart';
import 'package:go_rider/ui/features/authentication/login/presentation/view/login_screen.dart';
import 'package:go_rider/ui/features/dashboard/presentation/view/home_screen.dart';
import 'package:go_rider/ui/features/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    navigatorKey: NavigationService.navigatorKey,
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/homePage', builder: (context, state) => HomeScreen()),
    ],
  );
}
