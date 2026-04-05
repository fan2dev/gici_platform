import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/di/injection.dart';
import '../core/routing/app_router.dart';
import '../core/theme/app_theme.dart';
import '../features/auth/cubit/auth_cubit.dart';
import '../features/auth/data/auth_repository.dart';
import '../features/auth/data/auth_session_storage.dart';

class GiciApp extends StatelessWidget {
  const GiciApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          AuthCubit(sl<AuthRepository>(), sl<AuthSessionStorage>())
            ..bootstrap(),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          final router = buildAppRouter(context.read<AuthCubit>());
          return MaterialApp.router(
            title: 'GICI Platform',
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            routerConfig: router,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
