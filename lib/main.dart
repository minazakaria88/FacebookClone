import 'package:app_factory/core/api/api_helper.dart';
import 'package:app_factory/core/routes/app_routes.dart';
import 'package:app_factory/core/routes/routes.dart';
import 'package:app_factory/firebase_options.dart';
import 'package:app_factory/injection.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logger/logger.dart';

import 'bloc_observer.dart';

bool isLoggedIn = false;
var logger = Logger();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  setup();
  ApiHelper.init();
   MobileAds.instance.initialize();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await checkIfTheUserLoggedIn();
  runApp(const FeedApp());
}

class FeedApp extends StatelessWidget {
  const FeedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      initialRoute: isLoggedIn ? Routes.feeds : Routes.register,
    );
  }
}

Future<void> checkIfTheUserLoggedIn() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    isLoggedIn = true;
  }
}
