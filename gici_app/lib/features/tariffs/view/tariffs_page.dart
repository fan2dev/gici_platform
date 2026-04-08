import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/widgets/empty_state.dart';
import '../../../app/widgets/error_state.dart';
import '../../../app/widgets/gici_card.dart';
import '../../../app/widgets/loading_state.dart';
import '../../../app/widgets/status_pill.dart';
import '../../../core/di/injection.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../cubit/tariff_cubit.dart';
import '../data/tariff_repository.dart';
import 'tariff_form_page.dart';

class TariffsPage extends StatelessWidget {
  const TariffsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TariffCubit(
        repository: sl<TariffRepository>(),
      )..load(),
      child: const _TariffsView(),
    );
  }
}

class _TariffsView extends StatelessWidget {
  const _TariffsView();

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;
    final isAdmin = authState.isAdmin;

    return BlocBuilder<TariffCubit, TariffState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F7),
          appBar: AppBar(
            title: const Text(
              'Tarifas',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              onPressed: () => context.go('/direccion'),
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          floatingActionButton: isAdmin
              ? FloatingActionButton(
                  onPressed: () => _openForm(context),
                  child: const Icon(Icons.add),
                )
              : null,
          body: RefreshIndicator(
            onRefresh: () => context.read<TariffCubit>().load(),
            child: _buildBody(context, state),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, TariffState state) {
    if (state.isLoading) {
      return const LoadingState(message: 'Cargando tarifas...');
    }

    if (state.errorMessage != null) {
      return ErrorState(
        message: state.errorMessage!,
        onRetry: () => context.read<TariffCubit>().load(),
      );
    }

    if (state.tariffs.isEmpty) {
      return ListView(
        children: const [
          EmptyState(
            message: 'No hay tarifas configuradas.',
            icon: Icons.sell_outlined,
          ),
        ],
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: state.tariffs.length,
      itemBuilder: (context, index) {
        final tariff = state.tariffs[index];
        return _TariffCard(
          tariff: tariff,
          onTap: context.read<AuthCubit>().state.isAdmin
              ? () => _openForm(context, tariff: tariff)
              : null,
        );
      },
    );
  }

  void _openForm(BuildContext context, {dynamic tariff}) {
    final cubit = context.read<TariffCubit>();
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BlocProvider.value(
          value: cubit,
          child: TariffFormPage(tariff: tariff),
        ),
      ),
    );
  }
}

class _TariffCard extends StatelessWidget {
  const _TariffCard({required this.tariff, this.onTap});

  final dynamic tariff;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GiciCard(
      accentColor: Colors.indigo,
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.indigo.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.sell_outlined, color: Colors.indigo, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tariff.name as String? ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    StatusPill(
                      label: tariff.schedule as String? ?? '',
                      color: Colors.blue,
                      small: true,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${(tariff.price as double?)?.toStringAsFixed(2) ?? '0.00'} \u20AC',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
                if (tariff.includesTransport == true) ...[
                  const SizedBox(height: 4),
                  const StatusPill(
                    label: 'Transporte incluido',
                    color: Colors.green,
                    icon: Icons.directions_bus,
                    small: true,
                  ),
                ],
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
}
