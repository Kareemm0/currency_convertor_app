import 'package:currency_convertor_app/data/repo.dart';
import 'package:currency_convertor_app/data/repo/currency_code_repo_impl.dart';
import 'package:currency_convertor_app/domian/domian.dart';
import 'package:currency_convertor_app/presentation/cubit/currency/currency_code_cubit.dart';
import 'package:currency_convertor_app/presentation/cubit/flags/flags_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
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

    getIt.registerSingleton<CurrencyLocalDataSource>(
      CurrencyLocalDataSourceImpl(),
    );
    getIt.registerSingleton<FlagsDataSource>(FlagsDataSourecImpl(dio: getIt()));
  }

  static void injectRepos() {
    getIt.registerSingleton<CurrencyCodeRepo>(
      CurrencyCodeRepoImpl(data: getIt(), localDataSource: getIt()),
    );
    getIt.registerSingleton<FlagsRepo>(FlagsRepoImpl(data: getIt()));
  }

  static void injectBlocs() {
    getIt.registerFactory<CurrencyCodeCubit>(
      () => CurrencyCodeCubit(repo: getIt()),
    );
    getIt.registerFactory<FlagsCubit>(() => FlagsCubit(repo: getIt()));
  }
}
