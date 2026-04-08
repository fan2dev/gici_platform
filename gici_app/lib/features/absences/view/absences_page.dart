import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/widgets/empty_state.dart';
import '../../../app/widgets/error_state.dart';
import '../../../app/widgets/gici_card.dart';
import '../../../app/widgets/loading_state.dart';
import '../../../app/widgets/section_header.dart';
import '../../../app/widgets/status_pill.dart';
import '../../../core/di/injection.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../cubit/absence_cubit.dart';
import '../data/absence_repository.dart';
import 'report_absence_page.dart';

class AbsencesPage extends StatelessWidget {
  const AbsencesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AbsenceCubit(
        repository: sl<AbsenceRepository>(),
      )..loadByDate(),
      child: const _AbsencesView(),
    );
  }
}

class _AbsencesView extends StatelessWidget {
  const _AbsencesView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AbsenceCubit, AbsenceState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F7),
          appBar: AppBar(
            title: const Text(
              'Ausencias',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              onPressed: () => context.go('/dashboard'),
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () => context.read<AbsenceCubit>().loadByDate(),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // -- Date selector --
                _DateSelector(
                  selectedDate: state.selectedDate ?? DateTime.now(),
                  onChanged: (date) =>
                      context.read<AbsenceCubit>().loadByDate(date),
                ),
                const SizedBox(height: 16),

                // -- Report button --
                FilledButton.icon(
                  onPressed: () => _openReportForm(context),
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Registrar ausencia'),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // -- List header --
                SectionHeader(
                  title: 'Ausencias del día',
                  icon: '\u{1F4CB}',
                  action: Text(
                    '${state.absences.length}',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),

                // -- Content --
                if (state.isLoading)
                  const LoadingState(message: 'Cargando ausencias...')
                else if (state.errorMessage != null)
                  ErrorState(
                    message: state.errorMessage!,
                    onRetry: () =>
                        context.read<AbsenceCubit>().loadByDate(),
                  )
                else if (state.absences.isEmpty)
                  const EmptyState(
                    message: 'No hay ausencias registradas para este día.',
                    icon: Icons.check_circle_outline,
                  )
                else
                  ...state.absences.map(
                    (absence) => _AbsenceCard(absence: absence),
                  ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openReportForm(BuildContext context) {
    final cubit = context.read<AbsenceCubit>();
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BlocProvider.value(
          value: cubit,
          child: const ReportAbsencePage(),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Date selector
// ---------------------------------------------------------------------------

class _DateSelector extends StatelessWidget {
  const _DateSelector({
    required this.selectedDate,
    required this.onChanged,
  });

  final DateTime selectedDate;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    final dateStr =
        '${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year}';

    return GiciCard(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2020),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );
        if (picked != null) onChanged(picked);
      },
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.orange.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.calendar_today, color: Colors.orange, size: 22),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Fecha seleccionada',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 2),
              Text(
                dateStr,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const Spacer(),
          const Icon(Icons.edit_calendar, color: Colors.grey),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Absence card
// ---------------------------------------------------------------------------

class _AbsenceCard extends StatelessWidget {
  const _AbsenceCard({required this.absence});

  final dynamic absence;

  @override
  Widget build(BuildContext context) {
    final reason = absence.reason as String? ?? '';
    final justified = absence.justified as bool? ?? false;
    final notes = absence.notes as String? ?? '';

    Color reasonColor;
    String reasonLabel;
    switch (reason) {
      case 'enfermedad':
        reasonColor = Colors.red;
        reasonLabel = 'Enfermedad';
      case 'vacaciones':
        reasonColor = Colors.blue;
        reasonLabel = 'Vacaciones';
      case 'personal':
        reasonColor = Colors.orange;
        reasonLabel = 'Personal';
      default:
        reasonColor = Colors.grey;
        reasonLabel = reason.isNotEmpty ? reason : 'Otro';
    }

    return GiciCard(
      accentColor: reasonColor,
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: reasonColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.person_off_outlined,
              color: reasonColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    StatusPill(
                      label: reasonLabel,
                      color: reasonColor,
                      small: true,
                    ),
                    const SizedBox(width: 8),
                    if (justified)
                      const StatusPill(
                        label: 'Justificada',
                        color: Colors.green,
                        small: true,
                      ),
                  ],
                ),
                if (notes.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    notes,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
