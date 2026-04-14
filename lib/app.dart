import 'package:currency_convertor_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'apps/apps.dart';
import 'presentation/presentation.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      // home: MultiBlocProvider(
      //   providers: [
      //     BlocProvider(
      //       create: (context) => CurrencyCodeCubit(repo: getIt())..getRates(),
      //     ),
      //     BlocProvider(create: (context) => FlagsCubit(repo: getIt())),
      //   ],
      //   child: HomeScreen(),
      // ),
    );
  }
}
