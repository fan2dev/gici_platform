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
import '../cubit/calendar_cubit.dart';
import '../data/calendar_repository.dart';
import 'calendar_event_form_page.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CalendarCubit(
        repository: sl<CalendarRepository>(),
      )..loadMonth(),
      child: const _CalendarView(),
    );
  }
}

class _CalendarView extends StatefulWidget {
  const _CalendarView();

  @override
  State<_CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<_CalendarView> {
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;
    final isAdmin = authState.isAdmin;

    return BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, state) {
        final month = state.selectedMonth ?? DateTime.now();

        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F7),
          appBar: AppBar(
            title: const Text(
              'Calendario',
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
          floatingActionButton: isAdmin
              ? FloatingActionButton(
                  onPressed: () => _openForm(context),
                  child: const Icon(Icons.add),
                )
              : null,
          body: RefreshIndicator(
            onRefresh: () => context.read<CalendarCubit>().loadMonth(),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // -- Month navigation --
                _MonthNavigator(
                  month: month,
                  onPrevious: () => context.read<CalendarCubit>().loadMonth(
                        DateTime(month.year, month.month - 1, 1),
                      ),
                  onNext: () => context.read<CalendarCubit>().loadMonth(
                        DateTime(month.year, month.month + 1, 1),
                      ),
                ),
                const SizedBox(height: 12),

                // -- Days grid --
                if (state.isLoading)
                  const LoadingState(message: 'Cargando calendario...')
                else if (state.errorMessage != null)
                  ErrorState(
                    message: state.errorMessage!,
                    onRetry: () =>
                        context.read<CalendarCubit>().loadMonth(),
                  )
                else ...[
                  _DaysGrid(
                    month: month,
                    events: state.events,
                    selectedDay: _selectedDay,
                    onDayTap: (day) => setState(() => _selectedDay = day),
                  ),
                  const SizedBox(height: 20),

                  // -- Events for selected day --
                  if (_selectedDay != null) ...[
                    SectionHeader(
                      title:
                          'Eventos del ${_selectedDay!.day.toString().padLeft(2, '0')}/${_selectedDay!.month.toString().padLeft(2, '0')}',
                      icon: '\u{1F4C5}',
                    ),
                    ..._eventsForDay(state.events, _selectedDay!).map(
                      (event) => _EventCard(
                        event: event,
                        isAdmin: isAdmin,
                        onTap: isAdmin
                            ? () => _openForm(context, event: event)
                            : null,
                      ),
                    ),
                    if (_eventsForDay(state.events, _selectedDay!).isEmpty)
                      const EmptyState(
                        message: 'Sin eventos este día.',
                        icon: Icons.event_available,
                      ),
                  ],
                ],

                const SizedBox(height: 32),
              ],
            ),
          ),
        );
      },
    );
  }

  List<dynamic> _eventsForDay(List<dynamic> events, DateTime day) {
    return events.where((e) {
      final eventDate = e.eventDate as DateTime?;
      if (eventDate == null) return false;
      return eventDate.year == day.year &&
          eventDate.month == day.month &&
          eventDate.day == day.day;
    }).toList();
  }

  void _openForm(BuildContext context, {dynamic event}) {
    final cubit = context.read<CalendarCubit>();
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BlocProvider.value(
          value: cubit,
          child: CalendarEventFormPage(event: event),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Month navigator
// ---------------------------------------------------------------------------

class _MonthNavigator extends StatelessWidget {
  const _MonthNavigator({
    required this.month,
    required this.onPrevious,
    required this.onNext,
  });

  final DateTime month;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  static const _monthNames = [
    'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
    'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre',
  ];

  @override
  Widget build(BuildContext context) {
    return GiciCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: onPrevious,
            icon: const Icon(Icons.chevron_left),
          ),
          Text(
            '${_monthNames[month.month - 1]} ${month.year}',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          IconButton(
            onPressed: onNext,
            icon: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Days grid
// ---------------------------------------------------------------------------

class _DaysGrid extends StatelessWidget {
  const _DaysGrid({
    required this.month,
    required this.events,
    required this.selectedDay,
    required this.onDayTap,
  });

  final DateTime month;
  final List<dynamic> events;
  final DateTime? selectedDay;
  final ValueChanged<DateTime> onDayTap;

  @override
  Widget build(BuildContext context) {
    final firstDay = DateTime(month.year, month.month, 1);
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    // Monday = 1 in Dart's weekday
    final startWeekday = firstDay.weekday; // 1=Mon, 7=Sun

    final dayLabels = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];

    // Build set of days with events for fast lookup
    final eventDays = <int>{};
    for (final e in events) {
      final d = e.eventDate as DateTime?;
      if (d != null &&
          d.year == month.year &&
          d.month == month.month) {
        eventDays.add(d.day);
      }
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        children: [
          // Day labels
          Row(
            children: dayLabels
                .map((l) => Expanded(
                      child: Center(
                        child: Text(
                          l,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 8),
          // Grid
          ...List.generate(6, (week) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                children: List.generate(7, (weekday) {
                  final dayIndex =
                      week * 7 + weekday + 1 - (startWeekday - 1);
                  if (dayIndex < 1 || dayIndex > daysInMonth) {
                    return const Expanded(child: SizedBox(height: 40));
                  }

                  final hasEvent = eventDays.contains(dayIndex);
                  final isSelected = selectedDay != null &&
                      selectedDay!.year == month.year &&
                      selectedDay!.month == month.month &&
                      selectedDay!.day == dayIndex;
                  final isToday = DateTime.now().year == month.year &&
                      DateTime.now().month == month.month &&
                      DateTime.now().day == dayIndex;

                  return Expanded(
                    child: GestureDetector(
                      onTap: () => onDayTap(
                        DateTime(month.year, month.month, dayIndex),
                      ),
                      child: Container(
                        height: 40,
                        margin: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : isToday
                                  ? Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withValues(alpha: 0.1)
                                  : null,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$dayIndex',
                              style: TextStyle(
                                fontWeight:
                                    isToday ? FontWeight.w700 : FontWeight.w500,
                                fontSize: 14,
                                color: isSelected
                                    ? Colors.white
                                    : isToday
                                        ? Theme.of(context).colorScheme.primary
                                        : Colors.grey.shade800,
                              ),
                            ),
                            if (hasEvent)
                              Container(
                                width: 5,
                                height: 5,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isSelected
                                      ? Colors.white
                                      : Theme.of(context).colorScheme.primary,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Event card
// ---------------------------------------------------------------------------

class _EventCard extends StatelessWidget {
  const _EventCard({
    required this.event,
    required this.isAdmin,
    this.onTap,
  });

  final dynamic event;
  final bool isAdmin;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final type = event.eventType as String? ?? '';
    final title = event.title as String? ?? '';
    final description = event.description as String? ?? '';

    Color typeColor;
    String typeLabel;
    IconData typeIcon;
    switch (type) {
      case 'festivo':
        typeColor = Colors.red;
        typeLabel = 'Festivo';
        typeIcon = Icons.celebration;
      case 'reunion':
        typeColor = Colors.blue;
        typeLabel = 'Reunion';
        typeIcon = Icons.groups;
      case 'excursion':
        typeColor = Colors.green;
        typeLabel = 'Excursion';
        typeIcon = Icons.directions_bus;
      case 'celebracion':
        typeColor = Colors.purple;
        typeLabel = 'Celebracion';
        typeIcon = Icons.cake;
      case 'cierre':
        typeColor = Colors.orange;
        typeLabel = 'Cierre';
        typeIcon = Icons.lock;
      default:
        typeColor = Colors.grey;
        typeLabel = type.isNotEmpty ? type : 'Evento';
        typeIcon = Icons.event;
    }

    return GiciCard(
      accentColor: typeColor,
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: typeColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(typeIcon, color: typeColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    StatusPill(
                      label: typeLabel,
                      color: typeColor,
                      small: true,
                    ),
                    if (event.isRecurring == true) ...[
                      const SizedBox(width: 6),
                      const StatusPill(
                        label: 'Recurrente',
                        color: Colors.teal,
                        icon: Icons.repeat,
                        small: true,
                      ),
                    ],
                  ],
                ),
                if (description.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          if (isAdmin)
            const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
}
