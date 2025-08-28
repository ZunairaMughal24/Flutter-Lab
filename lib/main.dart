import 'package:api_integration/config/router.dart';
import 'package:api_integration/core/constants/app_theme.dart';
import 'package:api_integration/features/authentication/login/presentation/screens/login_screen.dart';
import 'package:api_integration/features/authentication/sign_up/presentation/screens/sign_up_screen.dart';
import 'package:api_integration/features/sliver_widget.dart';
import 'package:api_integration/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
         routerConfig: router,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      title: 'API integration',
  
    );
  }
}
