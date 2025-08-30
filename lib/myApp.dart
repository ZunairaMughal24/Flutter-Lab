import 'package:api_integration/config/router.dart';
import 'package:api_integration/core/constants/app_theme.dart';
import 'package:api_integration/core/utils/app_colors.dart';
import 'package:api_integration/core/utils/app_text_theme.dart';
import 'package:api_integration/core/utils/extentions.dart';
import 'package:api_integration/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:api_integration/features/authentication/presentation/bloc/events.dart';
import 'package:api_integration/features/authentication/presentation/bloc/stats.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(FirebaseAuth.instance),
      child: MaterialApp.router(
        routerConfig: router,
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        title: 'API integration',
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocProvider(
          create: (context) =>
              AuthBloc(FirebaseAuth.instance)
                ..add(AuthStatusChanged(FirebaseAuth.instance.currentUser)),
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is Authenticated) {
                Future.delayed(const Duration(seconds: 5), () {
                  context.push(AppRoutes.homeScreenRoute);
                });
              } else if (state is Unauthenticated) {
                Future.delayed(const Duration(seconds: 5), () {
                  context.push(AppRoutes.loginScreenRoute);
                });
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    Icons.spa_rounded,
                    size: 50,
                    color: AppColors.white,
                  ),
                ),
                10.heightBox,
                Text(
                  "Flutter Lab",
                  style: AppTextTheme.h2(color: AppColors.primaryColor),
                ),
                30.heightBox,
                CircularProgressIndicator(
                  color: AppColors.primaryColor,
                  strokeWidth: 2.5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
