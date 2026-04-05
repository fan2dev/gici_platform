import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../core/config/app_config.dart';
import '../core/di/injection.dart';
import '../core/routing/app_router.dart';
import '../core/theme/app_theme.dart';
import '../features/auth/cubit/auth_cubit.dart';
import '../features/auth/data/auth_repository.dart';

class GiciApp extends StatefulWidget {
  const GiciApp({super.key});

  @override
  State<GiciApp> createState() => _GiciAppState();
}

class _GiciAppState extends State<GiciApp> {
  late final AuthCubit _authCubit;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _authCubit = AuthCubit(sl<AuthRepository>())..bootstrap();
    _router = buildAppRouter(_authCubit);
  }

  @override
  void dispose() {
    _authCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final config = AppConfig.current;
    return BlocProvider.value(
      value: _authCubit,
      child: MaterialApp.router(
        title: config.appName,
        theme: AppTheme.light(config.seedColor),
        darkTheme: AppTheme.dark(config.seedColor),
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
