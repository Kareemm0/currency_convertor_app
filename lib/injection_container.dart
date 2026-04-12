import 'package:currency_convertor_app/data/repo/currency_code_repo_impl.dart';
import 'package:currency_convertor_app/domian/domian.dart';
import 'package:currency_convertor_app/presentation/cubit/currency_code_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/core.dart';
import 'data/data.dart';

final getIt = GetIt.instance;

Future initDependencies() async {
  await InjectionHelper.injectExternal();
  InjectionHelper.injectDatasources();
  InjectionHelper.injectRepos();
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

  static void injectDatasources() {
    getIt.registerSingleton<CurrencyCodeDataSource>(
      CurrencyCodeDataSourceImpl(dio: getIt()),
    );
  }

  static void injectRepos() {
    getIt.registerSingleton<CurrencyCodeRepo>(
      CurrencyCodeRepoImpl(data: getIt()),
    );
  }

  static void injectBlocs() {
    getIt.registerFactory<CurrencyCodeCubit>(
      () => CurrencyCodeCubit(repo: getIt()),
    );
  }
}
