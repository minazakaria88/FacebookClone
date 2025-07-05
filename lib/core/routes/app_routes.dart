import 'package:app_factory/core/routes/routes.dart';
import 'package:app_factory/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:app_factory/features/auth/presentation/pages/login_screen.dart';
import 'package:app_factory/features/auth/presentation/pages/register_screen.dart';
import 'package:app_factory/features/feeds/presentation/pages/add_post_screen.dart';
import 'package:app_factory/features/feeds/presentation/pages/feeds_screen.dart';
import 'package:app_factory/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/feeds/presentation/cubit/feeds_cubit.dart';

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<AuthCubit>(),
            child: const LoginScreen(),
          ),
        );
      case Routes.register:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<AuthCubit>(),
            child: const RegisterScreen(),
          ),
        );

      case Routes.feeds:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<FeedsCubit>()..getPosts()..getSuggestions()..loadBannerAd(),
            child: const FeedsScreen(),
          ),
        );

      case Routes.addPost:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<FeedsCubit>(),
            child: const AddPostScreen(),
          ),
        );

      default:
        return null;
    }
  }
}
