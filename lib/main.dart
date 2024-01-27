import 'package:felix_it_solutions/bloc/ads_bloc/ads_bloc.dart';
import 'package:felix_it_solutions/bloc/auth_bloc/auth_bloc.dart';
import 'package:felix_it_solutions/cubit/address_cubit/address_cubit.dart';
import 'package:felix_it_solutions/data/local/storage_repo.dart';
import 'package:felix_it_solutions/data/network/address_api_service.dart';
import 'package:felix_it_solutions/data/network/api_service.dart';
import 'package:felix_it_solutions/data/repositories/address_api_repository.dart';
import 'package:felix_it_solutions/data/repositories/api_repository.dart';
import 'package:felix_it_solutions/presentation/entrance/entrance_screen.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageRepository.getInstance();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: const [
        Locale('ru', 'RU'),
        Locale('uz', 'UZ'),
        Locale('en', 'EN'),
      ],
      path: 'assets/lang',
      fallbackLocale: const Locale('ru', 'RU'),
      child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
            create: (context) => AddressApiRepository(apiService: AddressApiService())),
        RepositoryProvider(
            create: (context) => ApiRepository(
                    apiService: ApiService(Dio(
                  BaseOptions(
                    contentType: "application/json",
                    baseUrl: "https://qutb.uz/api",
                  ),
                ))))
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => AddressCubit(
                  addressApiRepository: context.read<AddressApiRepository>())),
          BlocProvider(create: (context)=>AdsBloc(context.read<ApiRepository>())),
          BlocProvider(create: (context)=>AuthBloc(context.read<ApiRepository>())),
        ],
        child: MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
            ),
            home: const EntranceScreen()),
      ),
    );
  }
}
