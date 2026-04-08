import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:go_router/go_router.dart';

import '../../../app/widgets/empty_state.dart';
import '../../../app/widgets/gici_card.dart';
import '../../../app/widgets/loading_state.dart';
import '../../../app/widgets/section_header.dart';
import '../../../app/widgets/status_pill.dart';
import '../../../core/di/injection.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../../time_tracking/cubit/time_tracking_cubit.dart';
import '../../time_tracking/data/time_tracking_repository.dart';

class AdminTimeTrackingPage extends StatelessWidget {
  const AdminTimeTrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TimeTrackingCubit(
        repository: sl<TimeTrackingRepository>(),
      ),
      child: const _AdminTimeTrackingView(),
    );
  }
}

class _AdminTimeTrackingView extends StatelessWidget {
  const _AdminTimeTrackingView();

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthCubit>().state;

    if (!auth.isAuthenticated || !auth.isAdmin) {
      return const Scaffold(
        body: Center(child: Text('Acceso restringido a administradores.')),
      );
    }

    return BlocBuilder<TimeTrackingCubit, TimeTrackingState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F7),
          appBar: AppBar(
            title: const Text(
              'Control horario - Empleados',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              onPressed: () => context.go('/direccion'),
              icon: const Icon(Icons.arrow_back),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.file_download_outlined),
                tooltip: 'Exportar (pr\u00F3ximamente)',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('Exportaci\u00F3n disponible pr\u00F3ximamente.'),
                    ),
                  );
                },
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _AdminSection(state: state),
              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Admin section (employee overview + date filter)
// ---------------------------------------------------------------------------

class _AdminSection extends StatefulWidget {
  const _AdminSection({required this.state});

  final TimeTrackingState state;

  @override
  State<_AdminSection> createState() => _AdminSectionState();
}

class _AdminSectionState extends State<_AdminSection> {
  DateTime? _from;
  DateTime? _to;
  bool _orgLoaded = false;

  void _loadOrg() {
    setState(() => _orgLoaded = true);
    context.read<TimeTrackingCubit>().loadOrgEntries(
          from: _from,
          to: _to,
        );
  }

  Future<void> _pickDateRange() async {
    final range = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 1)),
      initialDateRange: _from != null && _to != null
          ? DateTimeRange(start: _from!, end: _to!)
          : null,
    );
    if (range == null) return;
    setState(() {
      _from = range.start;
      _to = range.end;
    });
    _loadOrg();
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Vista empleados',
          icon: '\u{1F465}',
          action: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.date_range, size: 20),
                tooltip: 'Filtrar por fecha',
                onPressed: _pickDateRange,
              ),
              if (!_orgLoaded)
                FilledButton(
                  onPressed: _loadOrg,
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: const Text('Cargar', style: TextStyle(fontSize: 13)),
                ),
            ],
          ),
        ),

        if (_from != null && _to != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: StatusPill(
              label:
                  '${_formatShortDate(_from!)} - ${_formatShortDate(_to!)}',
              color: Theme.of(context).colorScheme.primary,
              icon: Icons.calendar_today,
              small: true,
            ),
          ),

        if (state.isLoadingOrg)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: LoadingState(message: 'Cargando...'),
          )
        else if (_orgLoaded && state.orgEntries.isEmpty)
          const EmptyState(
            message: 'Sin registros en el rango seleccionado.',
            icon: Icons.search_off,
          )
        else
          ...state.orgEntries.map(
            (entry) => _OrgEntryTile(entry: entry),
          ),
      ],
    );
  }

  static String _formatShortDate(DateTime d) {
    return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}';
  }
}

// ---------------------------------------------------------------------------
// Org entry tile (with correction)
// ---------------------------------------------------------------------------

class _OrgEntryTile extends StatelessWidget {
  const _OrgEntryTile({required this.entry});

  final TimeEntry entry;

  @override
  Widget build(BuildContext context) {
    final isCheckIn = entry.entryType == 'check_in';
    final local = entry.recordedAt.toLocal();
    final dateStr =
        '${local.day.toString().padLeft(2, '0')}/${local.month.toString().padLeft(2, '0')}/${local.year}';
    final timeStr =
        '${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';

    return GiciCard(
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isCheckIn
                  ? Colors.green.withValues(alpha: 0.1)
                  : Colors.red.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              isCheckIn ? Icons.login : Icons.logout,
              color: isCheckIn ? Colors.green : Colors.red.shade400,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${isCheckIn ? 'Entrada' : 'Salida'} - ${entry.userId.toString().substring(0, 8)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '$timeStr  \u00B7  $dateStr',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => _openCorrectionDialog(context, entry),
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: const Text('Corregir', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }

  void _openCorrectionDialog(BuildContext context, TimeEntry target) {
    final reasonController = TextEditingController();
    final cubit = context.read<TimeTrackingCubit>();

    showDialog<void>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Corregir registro',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'El tipo se cambiar\u00E1 de "${target.entryType == 'check_in' ? 'Entrada' : 'Salida'}" '
              'a "${target.entryType == 'check_in' ? 'Salida' : 'Entrada'}".',
              style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: reasonController,
              decoration: InputDecoration(
                labelText: 'Motivo de la correcci\u00F3n',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              minLines: 2,
              maxLines: 4,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogCtx).pop(),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () async {
              final reason = reasonController.text.trim();
              if (reason.isEmpty) return;

              final success = await cubit.correctEntry(
                targetEntryId: target.id!,
                correctedEntryType:
                    target.entryType == 'check_in' ? 'check_out' : 'check_in',
                correctionReason: reason,
                notes: 'Corregido desde la app',
              );

              if (dialogCtx.mounted) Navigator.of(dialogCtx).pop();
              if (success && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Correcci\u00F3n creada')),
                );
              }
            },
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: const Text('Crear correcci\u00F3n'),
          ),
        ],
      ),
    );
  }
}
