import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../app/widgets/empty_state.dart';
import '../../../app/widgets/gici_card.dart';
import '../../../app/widgets/loading_state.dart';
import '../../../app/widgets/status_pill.dart';
import '../../../core/di/injection.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../cubit/time_tracking_cubit.dart';
import '../data/time_tracking_repository.dart';

class TimeTrackingPage extends StatelessWidget {
  const TimeTrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TimeTrackingCubit(
        repository: sl<TimeTrackingRepository>(),
      )..loadMyEntries(),
      child: const _TimeTrackingView(),
    );
  }
}

class _TimeTrackingView extends StatelessWidget {
  const _TimeTrackingView();

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;
    if (!authState.isAuthenticated) {
      return const Scaffold(body: Center(child: Text('No autorizado')));
    }

    return BlocBuilder<TimeTrackingCubit, TimeTrackingState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('⏱️ Control horario',
                style: TextStyle(fontWeight: FontWeight.w700)),
            leading: IconButton(
              onPressed: () => context.go('/dashboard'),
              icon: const Icon(Icons.arrow_back),
            ),
            actions: [
              IconButton(
                onPressed: () => _showAddRetroactiveDialog(context),
                icon: const Icon(Icons.add_circle_outline),
                tooltip: 'Añadir registro a posteriori',
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () => context.read<TimeTrackingCubit>().loadMyEntries(),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _CheckInOutCard(state: state),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.shade100),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.gavel, size: 14, color: Colors.blue.shade700),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'RD-ley 8/2019 · Registros inmutables. Las correcciones y registros posteriores quedan marcados.',
                          style: TextStyle(fontSize: 11, color: Colors.blue.shade700),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                if (state.errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: GiciCard(
                      accentColor: Colors.red,
                      child: Text(state.errorMessage!,
                          style: const TextStyle(color: Colors.red, fontSize: 13)),
                    ),
                  ),
                // -- Mismatch warning banner --
                if (!state.isLoading && state.myEntries.isNotEmpty)
                  ..._buildMismatchWarnings(state.myEntries),
                Row(
                  children: [
                    const Text('📋 Mis registros',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                    const Spacer(),
                    if (state.myEntries.isNotEmpty)
                      Text('${state.myEntries.length} registros',
                          style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
                  ],
                ),
                const SizedBox(height: 8),
                if (state.isLoading)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 32),
                    child: LoadingState(message: 'Cargando registros...'),
                  )
                else if (state.myEntries.isEmpty)
                  const EmptyState(message: 'No hay registros todavía.', icon: Icons.schedule)
                else
                  ..._buildGroupedEntries(context, state.myEntries),
                const SizedBox(height: 32),
              ],
            ),
          ),
        );
      },
    );
  }

  List<String> _findMismatches(List<TimeEntry> entries) {
    final issues = <String>[];
    for (var i = 0; i < entries.length - 1; i++) {
      if (entries[i].entryType == entries[i + 1].entryType) {
        final local = entries[i].recordedAt.toLocal();
        final type = entries[i].entryType == 'check_in' ? 'entradas' : 'salidas';
        issues.add('Dos $type seguidas el ${DateFormat('d/M HH:mm').format(local)}');
      }
    }
    return issues;
  }

  List<Widget> _buildMismatchWarnings(List<TimeEntry> entries) {
    final issues = _findMismatches(entries);
    if (issues.isEmpty) return [];
    return [
      Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.amber.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.amber.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.warning_amber_rounded, size: 18, color: Colors.amber.shade800),
                const SizedBox(width: 8),
                Text(
                  '\u26A0\uFE0F Fichaje descuadrado',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.amber.shade900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            for (final issue in issues)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  '$issue. Revisa y corrige.',
                  style: TextStyle(fontSize: 12, color: Colors.amber.shade800),
                ),
              ),
          ],
        ),
      ),
    ];
  }

  List<Widget> _buildGroupedEntries(BuildContext context, List<TimeEntry> entries) {
    final widgets = <Widget>[];
    String? currentDate;
    for (final entry in entries) {
      final local = entry.recordedAt.toLocal();
      final dateLabel = _fmtDate(local);
      if (dateLabel != currentDate) {
        currentDate = dateLabel;
        widgets.add(Padding(
          padding: EdgeInsets.only(top: widgets.isEmpty ? 0 : 16, bottom: 8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: Text(dateLabel,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.grey.shade700)),
          ),
        ));
      }
      widgets.add(_TimeEntryTile(entry: entry, onCorrect: () => _showCorrectionDialog(context, entry)));
    }
    return widgets;
  }

  static void showCheckOutSheet(BuildContext context) {
    final cubit = context.read<TimeTrackingCubit>();
    final reasons = [
      ('☕', 'Pausa'),
      ('🍽️', 'Comida'),
      ('🏁', 'Fin de jornada'),
      ('🏥', 'Médico'),
      ('👶', 'Asunto personal'),
    ];
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (sheetCtx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              const Text('Motivo de salida',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              const SizedBox(height: 16),
              ...reasons.map((r) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: SizedBox(
                  width: double.infinity,
                  child: Material(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(16),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        Navigator.pop(sheetCtx);
                        cubit.checkOut(notes: r.$2);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        child: Row(
                          children: [
                            Text(r.$1, style: const TextStyle(fontSize: 24)),
                            const SizedBox(width: 14),
                            Text(r.$2, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  void _showCorrectionDialog(BuildContext context, TimeEntry entry) {
    final isCheckIn = entry.entryType == 'check_in';
    final original = entry.recordedAt.toLocal();
    var correctedTime = TimeOfDay(hour: original.hour, minute: original.minute);
    var correctedDate = DateTime(original.year, original.month, original.day);
    final reasonCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogCtx) => StatefulBuilder(builder: (ctx, setState) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: Row(children: [
            Icon(Icons.edit_calendar, size: 22, color: Colors.orange.shade700),
            const SizedBox(width: 8),
            const Text('Corregir hora', style: TextStyle(fontWeight: FontWeight.w700)),
          ]),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50, borderRadius: BorderRadius.circular(12)),
                child: Row(children: [
                  Icon(isCheckIn ? Icons.login : Icons.logout,
                      color: isCheckIn ? Colors.green : Colors.red, size: 18),
                  const SizedBox(width: 8),
                  Text('${isCheckIn ? "Entrada" : "Salida"} · ${DateFormat('HH:mm · d/M/yyyy').format(original)}',
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                ]),
              ),
              const SizedBox(height: 14),
              const Text('Fecha corregida', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
              const SizedBox(height: 6),
              _DateTimePicker(
                icon: Icons.calendar_today,
                label: DateFormat('d/M/yyyy').format(correctedDate),
                onTap: () async {
                  final p = await showDatePicker(
                      context: ctx, initialDate: correctedDate,
                      firstDate: DateTime(2020), lastDate: DateTime.now());
                  if (p != null) setState(() => correctedDate = p);
                },
              ),
              const SizedBox(height: 10),
              const Text('Hora corregida', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
              const SizedBox(height: 6),
              _DateTimePicker(
                icon: Icons.access_time,
                label: '${correctedTime.hour.toString().padLeft(2, '0')}:${correctedTime.minute.toString().padLeft(2, '0')}',
                large: true,
                onTap: () async {
                  final p = await showTimePicker(context: ctx, initialTime: correctedTime);
                  if (p != null) setState(() => correctedTime = p);
                },
              ),
              const SizedBox(height: 10),
              TextField(
                controller: reasonCtrl,
                decoration: InputDecoration(
                  labelText: 'Motivo *', hintText: 'Ej: Olvidé fichar',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                maxLines: 2,
              ),
              const SizedBox(height: 6),
              Text('El registro original se conserva.',
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade500)),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(dialogCtx), child: const Text('Cancelar')),
            FilledButton(
              onPressed: () {
                if (reasonCtrl.text.trim().isEmpty) return;
                context.read<TimeTrackingCubit>().correctEntry(
                  targetEntryId: entry.id!,
                  correctedEntryType: entry.entryType,
                  correctionReason:
                      '${reasonCtrl.text.trim()} · Hora: ${correctedTime.hour.toString().padLeft(2, '0')}:${correctedTime.minute.toString().padLeft(2, '0')} ${DateFormat('d/M/yyyy').format(correctedDate)}',
                );
                Navigator.pop(dialogCtx);
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      }),
    );
  }

  void _showAddRetroactiveDialog(BuildContext context) {
    String selectedType = 'check_in';
    var selectedDate = DateTime.now();
    var selectedTime = TimeOfDay.now();
    final notesCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogCtx) => StatefulBuilder(builder: (ctx, setState) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: Row(children: [
            Icon(Icons.history, size: 22, color: Colors.orange.shade700),
            const SizedBox(width: 8),
            const Expanded(
              child: Text('Registro a posteriori', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17))),
          ]),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50, borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.orange.shade100)),
                child: Row(children: [
                  Icon(Icons.info_outline, size: 14, color: Colors.orange.shade700),
                  const SizedBox(width: 6),
                  Expanded(child: Text('Quedará marcado como creado a posteriori.',
                      style: TextStyle(fontSize: 11, color: Colors.orange.shade700))),
                ]),
              ),
              const SizedBox(height: 14),
              const Text('Tipo', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
              const SizedBox(height: 6),
              Row(children: [
                Expanded(child: _TypeBtn(label: 'Entrada', icon: Icons.login,
                    isSelected: selectedType == 'check_in', color: const Color(0xFF2E7D32),
                    onTap: () => setState(() => selectedType = 'check_in'))),
                const SizedBox(width: 8),
                Expanded(child: _TypeBtn(label: 'Salida', icon: Icons.logout,
                    isSelected: selectedType == 'check_out', color: const Color(0xFFD32F2F),
                    onTap: () => setState(() => selectedType = 'check_out'))),
              ]),
              const SizedBox(height: 12),
              const Text('Fecha', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
              const SizedBox(height: 6),
              _DateTimePicker(
                icon: Icons.calendar_today,
                label: DateFormat('d/M/yyyy').format(selectedDate),
                onTap: () async {
                  final p = await showDatePicker(context: ctx, initialDate: selectedDate,
                      firstDate: DateTime(2020), lastDate: DateTime.now());
                  if (p != null) setState(() => selectedDate = p);
                },
              ),
              const SizedBox(height: 10),
              const Text('Hora', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
              const SizedBox(height: 6),
              _DateTimePicker(
                icon: Icons.access_time, large: true,
                label: '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}',
                onTap: () async {
                  final p = await showTimePicker(context: ctx, initialTime: selectedTime);
                  if (p != null) setState(() => selectedTime = p);
                },
              ),
              const SizedBox(height: 10),
              TextField(
                controller: notesCtrl,
                decoration: InputDecoration(
                  labelText: 'Notas (opcional)', hintText: 'Ej: Se me olvidó fichar ayer',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(dialogCtx), child: const Text('Cancelar')),
            FilledButton(
              onPressed: () {
                final notes = 'Registro a posteriori${notesCtrl.text.trim().isNotEmpty ? ' · ${notesCtrl.text.trim()}' : ''}';
                if (selectedType == 'check_in') {
                  context.read<TimeTrackingCubit>().checkIn(notes: notes);
                } else {
                  context.read<TimeTrackingCubit>().checkOut(notes: notes);
                }
                Navigator.pop(dialogCtx);
              },
              child: const Text('Crear registro'),
            ),
          ],
        );
      }),
    );
  }

  static String _fmtDate(DateTime l) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final d = DateTime(l.year, l.month, l.day);
    if (d == today) return 'Hoy';
    if (d == today.subtract(const Duration(days: 1))) return 'Ayer';
    return DateFormat("EEEE d 'de' MMMM", 'es_ES').format(l);
  }
}

// =============================================================================
// HERO card
// =============================================================================
class _CheckInOutCard extends StatelessWidget {
  const _CheckInOutCard({required this.state});
  final TimeTrackingState state;

  @override
  Widget build(BuildContext context) {
    final isIn = state.lastAction == LastAction.checkIn;
    final cubit = context.read<TimeTrackingCubit>();
    final Color bg = isIn ? const Color(0xFFD32F2F) : const Color(0xFF2E7D32);
    final String label = isIn ? 'Registrar salida' : 'Registrar entrada';
    final String sub = isIn ? 'Trabajando desde ${_fmt(state.lastActionTime)}' : 'Pulsa para fichar';
    final IconData ic = isIn ? Icons.stop_rounded : Icons.play_arrow_rounded;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [bg, bg.withValues(alpha: 0.8)]),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: bg.withValues(alpha: 0.3), blurRadius: 16, offset: const Offset(0, 6))],
      ),
      child: Material(
        color: Colors.transparent, borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: state.isActing ? null : () {
            if (isIn) { _TimeTrackingView.showCheckOutSheet(context); }
            else { cubit.checkIn(notes: 'Fichaje desde app'); }
          },
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Row(children: [
              Container(width: 56, height: 56,
                decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), shape: BoxShape.circle),
                child: state.isActing
                    ? const Center(child: SizedBox(width: 24, height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)))
                    : Icon(ic, color: Colors.white, size: 32)),
              const SizedBox(width: 16),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
                const SizedBox(height: 4),
                Text(sub, style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 13)),
              ])),
            ]),
          ),
        ),
      ),
    );
  }

  String _fmt(DateTime? dt) {
    if (dt == null) return '--:--';
    final l = dt.toLocal();
    return '${l.hour.toString().padLeft(2, '0')}:${l.minute.toString().padLeft(2, '0')}';
  }
}

// =============================================================================
// Entry tile — big time, badges
// =============================================================================
class _TimeEntryTile extends StatelessWidget {
  const _TimeEntryTile({required this.entry, this.onCorrect});
  final TimeEntry entry;
  final VoidCallback? onCorrect;

  @override
  Widget build(BuildContext context) {
    final isIn = entry.entryType == 'check_in';
    final isCorrected = entry.correctionReason != null;
    final isRetro = entry.notes?.contains('posteriori') == true;
    final local = entry.recordedAt.toLocal();
    final time = '${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
    final Color tc = isIn ? const Color(0xFF2E7D32) : const Color(0xFFD32F2F);

    return GiciCard(
      accentColor: isCorrected || isRetro ? Colors.orange : tc,
      child: Row(children: [
        Container(
          width: 72, padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(color: tc.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(14)),
          child: Column(children: [
            Text(time, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: tc, letterSpacing: -0.5)),
            const SizedBox(height: 2),
            Icon(isIn ? Icons.login : Icons.logout, size: 16, color: tc.withValues(alpha: 0.5)),
          ]),
        ),
        const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Wrap(spacing: 6, runSpacing: 4, children: [
            StatusPill(label: isIn ? 'Entrada' : 'Salida', color: tc, small: true),
            if (_exitReason != null) StatusPill(label: _exitReason!, color: Colors.grey, small: true),
            if (isCorrected) StatusPill(label: 'Modificado', color: Colors.orange, icon: Icons.edit, small: true),
            if (isRetro && !isCorrected) StatusPill(label: 'A posteriori', color: Colors.orange, icon: Icons.history, small: true),
          ]),
          if (isCorrected && entry.correctionReason != null) ...[
            const SizedBox(height: 4),
            Text(entry.correctionReason!, style: TextStyle(fontSize: 11, color: Colors.orange.shade700, fontStyle: FontStyle.italic),
                maxLines: 2, overflow: TextOverflow.ellipsis),
          ],
        ])),
        if (onCorrect != null && !isCorrected)
          IconButton(onPressed: onCorrect, icon: Icon(Icons.edit_calendar_rounded, size: 20, color: Colors.grey.shade400),
              tooltip: 'Corregir hora'),
      ]),
    );
  }

  String? get _exitReason {
    if (entry.entryType == 'check_in' || entry.notes == null) return null;
    final n = entry.notes!;
    if (n == 'Pausa' || n == 'Comida' || n == 'Fin de jornada' || n == 'Médico' || n == 'Asunto personal') return n;
    return null;
  }
}

// =============================================================================
// Shared helpers
// =============================================================================
class _DateTimePicker extends StatelessWidget {
  const _DateTimePicker({required this.icon, required this.label, required this.onTap, this.large = false});
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool large;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300)),
        child: Row(children: [
          Icon(icon, size: 16),
          const SizedBox(width: 8),
          Text(label, style: TextStyle(fontWeight: FontWeight.w700, fontSize: large ? 18 : 14)),
        ]),
      ),
    );
  }
}

class _TypeBtn extends StatelessWidget {
  const _TypeBtn({required this.label, required this.icon, required this.isSelected, required this.color, required this.onTap});
  final String label; final IconData icon; final bool isSelected; final Color color; final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.1) : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? color : Colors.grey.shade200, width: isSelected ? 2 : 1)),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, size: 18, color: isSelected ? color : Colors.grey),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: isSelected ? color : Colors.grey)),
        ]),
      ),
    );
  }
}
