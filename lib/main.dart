import 'package:api_integration/core/const/app_theme.dart';
import 'package:api_integration/features/sliver_widget.dart';
import 'package:api_integration/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async{
  
  WidgetsFlutterBinding.ensureInitialized();


await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
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
    return MaterialApp(
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      title: 'API integration',
      home: SliverDemo(),
    );
  }
}
