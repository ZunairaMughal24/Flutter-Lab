import 'package:api_integration/features/authentication/presentation/screens/home_screen.dart';
import 'package:api_integration/features/authentication/presentation/screens/login_screen.dart';
import 'package:api_integration/features/authentication/presentation/screens/sign_up_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

CustomTransitionPage buildSlideTransition({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(position: animation.drive(tween), child: child);
    },
  );
}

abstract class AppRoutes {
  static const String splashScreenRoute = '/splash_screen';

  static const String signUpScreenRoute = '/signUp';
  static const String loginScreenRoute = '/login';
  static const String homeScreenRoute = '/home';
  static const String profile = '/profile';
}

final router = GoRouter(
  initialLocation: AppRoutes.signUpScreenRoute,
  routes: [
    // GoRoute(
    //   path: AppRoutes.splashScreenRoute,
    //   pageBuilder: (context, state) => buildSlideTransition(
    //     context: context,
    //     state: state,
    //     child: const SplashScreen(),
    //   ),
    // ),
    GoRoute(
      path: AppRoutes.loginScreenRoute,
      pageBuilder: (context, state) => buildSlideTransition(
        context: context,
        state: state,
        child: const SignInScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.signUpScreenRoute,
      pageBuilder: (context, state) => buildSlideTransition(
        context: context,
        state: state,
        child: const SignUpScreen(),
      ),
    ),
      GoRoute(
      path: AppRoutes.homeScreenRoute,
      pageBuilder: (context, state) => buildSlideTransition(
        context: context,
        state: state,
        child: const HomeScreen(),
      ),
    ),
  ],
);
