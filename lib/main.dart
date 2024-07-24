import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'presentation/pages/landing_page.dart';
import 'core/utils/colors.dart';
import 'core/utils/env.dart';
import 'core/utils/route.dart';
import 'services/initialize_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Force orientation portrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Initialize firebase service
  await Firebase.initializeApp();

  // Initialize supabase
  await Supabase.initialize(
    url: Env.sbUrl,
    anonKey: Env.sbAnonKey,
  );

  // Initialize else
  await InitializeApp.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ADMIN GL CashMan',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColor.background,
        primaryColor: AppColor.primary,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColor.primary,
          primary: AppColor.primary,
          brightness: Brightness.light,
        ),
      ),
      home: const LandingPage(),
      getPages: AppRoute.pageRoute,
    );
  }
}
