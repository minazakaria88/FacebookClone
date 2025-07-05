import 'package:app_factory/features/auth/data/repositories/auth_repo.dart';
import 'package:app_factory/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:get_it/get_it.dart';

import 'core/api/api_helper.dart';
import 'features/feeds/data/repositories/feeds_repo.dart';
import 'features/feeds/presentation/cubit/feeds_cubit.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton(() => AuthRepository());
  getIt.registerFactory(() => AuthCubit(authRepository: getIt()));

  getIt.registerLazySingleton(() => ApiHelper());
  getIt.registerLazySingleton(() => FeedsRepository(apiHelper: getIt()));
  getIt.registerFactory(() => FeedsCubit(feedsRepository: getIt()));
}
