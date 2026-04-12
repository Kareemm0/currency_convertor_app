import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/core.dart';
import 'data/data.dart';

final getIt = GetIt.instance;

Future initDependencies() async {
  await InjectionHelper.injectExternal();
  InjectionHelper.injectCore();
  InjectionHelper.injectDatasources();
  InjectionHelper.injectRepos();
  InjectionHelper.injectCommands();
  InjectionHelper.injectBlocs();
}

abstract class InjectionHelper {
  static Future<void> injectExternal() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    getIt.registerFactory<BaseLocalStorage>(
      () => SharedPrefsLocalStorageImpl(preferences: sharedPreferences),
    );
    getIt.registerSingleton<Dio>(Dio());
    getIt.registerSingleton<AppInterceptors>(AppInterceptors());

    getIt.registerSingleton<ApiConsumer>(
      DioConsumer(
        baseUrl: Endpoints.baseUrl,
        client: getIt(),
        interceptors: [getIt<AppInterceptors>()],
      ),
    );
  }

  static void injectCore() {}

  static void injectDatasources() {}

  static void injectRepos() {}

  static void injectCommands() {}

  static void injectBlocs() {}
}
