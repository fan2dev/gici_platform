import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/di/injection.dart';
import '../data/experience_repository.dart';

/// Admin page for managing monthly menus (normal and menu2/triturado tracks).
/// Shows a calendar grid for the selected month. Each day cell can be tapped
/// to edit the 3 meal slots (primer plato, segundo plato, postre).
class MenuEditorPage extends StatefulWidget {
  const MenuEditorPage({super.key});

  @override
  State<MenuEditorPage> createState() => _MenuEditorPageState();
}

class _MenuEditorPageState extends State<MenuEditorPage> {
  final _repo = sl<ExperienceRepository>();

  late int _year;
  late int _month;
  int _trackIndex = 0; // 0 = normal, 1 = menu2

  bool _loading = false;
  String? _error;

  // day (1-31) -> { mealType -> title }
  Map<int, Map<String, String>> _dayMeals = {};

  static const _tracks = ['normal', 'menu2'];
  static const _trackLabels = ['Men\u00fa Normal', 'Men\u00fa 2 (Triturado)'];

  static const _mealSlots = ['lunch_first', 'lunch_second', 'dessert'];
  static const _mealLabels = ['Primer plato', 'Segundo plato', 'Postre'];

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _year = now.year;
    _month = now.month;
    _loadMonth();
  }

  String get _currentTrack => _tracks[_trackIndex];

  Future<void> _loadMonth() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final from = DateTime.utc(_year, _month, 1);
      final to = DateTime.utc(_year, _month + 1, 0, 23, 59, 59);
      final entries = await _repo.listMenuEntries(
        from: from,
        to: to,
        menuTrack: _currentTrack,
        page: 0,
        pageSize: 100,
      );

      final map = <int, Map<String, String>>{};
      for (final e in entries) {
        final day = e.menuDate.day;
        map.putIfAbsent(day, () => {});
        map[day]![e.mealType] = e.title;
      }
      setState(() {
        _dayMeals = map;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  void _changeMonth(int delta) {
    setState(() {
      _month += delta;
      if (_month > 12) {
        _month = 1;
        _year++;
      } else if (_month < 1) {
        _month = 12;
        _year--;
      }
    });
    _loadMonth();
  }

  void _changeTrack(int index) {
    if (index == _trackIndex) return;
    setState(() => _trackIndex = index);
    _loadMonth();
  }

  int get _daysInMonth => DateTime.utc(_year, _month + 1, 0).day;

  int get _firstWeekday {
    // Monday = 1 ... Sunday = 7
    return DateTime.utc(_year, _month, 1).weekday;
  }

  String get _monthLabel {
    final dt = DateTime(_year, _month);
    final fmt = DateFormat('MMMM yyyy', 'es');
    final label = fmt.format(dt);
    return label[0].toUpperCase() + label.substring(1);
  }

  Future<void> _editDay(int day) async {
    final existing = _dayMeals[day] ?? {};
    final controllers = [
      TextEditingController(text: existing['lunch_first'] ?? ''),
      TextEditingController(text: existing['lunch_second'] ?? ''),
      TextEditingController(text: existing['dessert'] ?? ''),
    ];

    final weekday = DateTime.utc(_year, _month, day).weekday;
    final weekdayName = DateFormat('EEEE', 'es').format(DateTime.utc(_year, _month, day));

    final result = await showModalBottomSheet<Map<String, String>?>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            24,
            24,
            24,
            MediaQuery.of(ctx).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${weekdayName[0].toUpperCase()}${weekdayName.substring(1)}, $day',
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: _trackIndex == 0
                          ? const Color(0xFF4CAF50).withValues(alpha: 0.12)
                          : const Color(0xFFFFA726).withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _trackLabels[_trackIndex],
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: _trackIndex == 0
                            ? const Color(0xFF4CAF50)
                            : const Color(0xFFFFA726),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              for (var i = 0; i < 3; i++) ...[
                TextField(
                  controller: controllers[i],
                  decoration: InputDecoration(
                    labelText: _mealLabels[i],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 12),
                  ),
                  textCapitalization: TextCapitalization.sentences,
                ),
                if (i < 2) const SizedBox(height: 12),
              ],
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // Return empty to signal clearing
                        Navigator.of(ctx).pop(<String, String>{
                          'lunch_first': '',
                          'lunch_second': '',
                          'dessert': '',
                        });
                      },
                      icon: const Icon(Icons.delete_outline, size: 18),
                      label: const Text('Limpiar'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red.shade400,
                        side: BorderSide(color: Colors.red.shade200),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: FilledButton.icon(
                      onPressed: () {
                        Navigator.of(ctx).pop(<String, String>{
                          'lunch_first': controllers[0].text.trim(),
                          'lunch_second': controllers[1].text.trim(),
                          'dessert': controllers[2].text.trim(),
                        });
                      },
                      icon: const Icon(Icons.check, size: 18),
                      label: const Text('Guardar'),
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );

    for (final c in controllers) {
      c.dispose();
    }

    if (result == null) return;

    // Update local state immediately for responsiveness
    setState(() {
      final meals = <String, String>{};
      for (final slot in _mealSlots) {
        final val = result[slot]?.trim() ?? '';
        if (val.isNotEmpty) meals[slot] = val;
      }
      if (meals.isEmpty) {
        _dayMeals.remove(day);
      } else {
        _dayMeals[day] = meals;
      }
    });

    // Persist: bulk upload just this day (we re-upload the full month to keep it simple)
    await _saveMonth();
  }

  Future<void> _saveMonth() async {
    setState(() => _loading = true);
    try {
      final entries = <String>[];
      for (var d = 1; d <= _daysInMonth; d++) {
        final meals = _dayMeals[d];
        if (meals == null || meals.isEmpty) continue;
        final dateStr =
            DateTime.utc(_year, _month, d).toIso8601String().substring(0, 10);
        entries.add(jsonEncode({
          'date': dateStr,
          'lunch_first': meals['lunch_first'] ?? '',
          'lunch_second': meals['lunch_second'] ?? '',
          'dessert': meals['dessert'] ?? '',
        }));
      }
      await _repo.bulkUploadMonthlyMenu(
        year: _year,
        month: _month,
        menuTrack: _currentTrack,
        entries: entries,
      );
      setState(() => _loading = false);
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  Future<void> _copyPreviousWeek() async {
    // Find the current week (Mon-Fri) with the most empty days
    // and copy from the previous week
    final today = DateTime.now();
    // Determine which week to copy INTO: find the first weekday in the month
    // that has empty meals for the current track

    // Strategy: copy week N-1 into week N for every week that is mostly empty
    // Simpler: just let user pick, but for now copy last filled week into next empty week.

    // Find all filled days in order
    final filledDays = _dayMeals.keys.toList()..sort();
    if (filledDays.isEmpty) return;

    // Find the last filled day and determine its week
    final lastFilledDay = filledDays.last;
    final lastFilledDate = DateTime.utc(_year, _month, lastFilledDay);
    final lastFilledWeekday = lastFilledDate.weekday; // 1=Mon

    // Find the Monday of the last filled week
    final lastWeekMonday = lastFilledDay - (lastFilledWeekday - 1);

    // The next week starts on the following Monday
    final nextWeekMonday = lastWeekMonday + 7;

    if (nextWeekMonday > _daysInMonth) return; // No room for next week

    // Copy meals from lastWeek's Mon-Fri to nextWeek's Mon-Fri
    var copied = false;
    for (var offset = 0; offset < 5; offset++) {
      final srcDay = lastWeekMonday + offset;
      final dstDay = nextWeekMonday + offset;
      if (srcDay < 1 || srcDay > _daysInMonth) continue;
      if (dstDay < 1 || dstDay > _daysInMonth) continue;

      final srcMeals = _dayMeals[srcDay];
      if (srcMeals == null || srcMeals.isEmpty) continue;

      // Only copy if destination is empty
      if (_dayMeals[dstDay] != null && _dayMeals[dstDay]!.isNotEmpty) continue;

      _dayMeals[dstDay] = Map<String, String>.from(srcMeals);
      copied = true;
    }

    if (copied) {
      setState(() {});
      await _saveMonth();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        title: const Text(
          'Editor de men\u00fas',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        backgroundColor: const Color(0xFFF5F5F7),
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => context.go('/experience'),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        actions: [
          IconButton(
            onPressed: _copyPreviousWeek,
            icon: const Icon(Icons.content_copy_rounded),
            tooltip: 'Copiar semana anterior',
          ),
        ],
      ),
      body: Column(
        children: [
          // Month selector
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => _changeMonth(-1),
                  icon: const Icon(Icons.chevron_left_rounded),
                ),
                Text(
                  _monthLabel,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
                IconButton(
                  onPressed: () => _changeMonth(1),
                  icon: const Icon(Icons.chevron_right_rounded),
                ),
              ],
            ),
          ),

          // Track tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: List.generate(2, (i) {
                final selected = i == _trackIndex;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => _changeTrack(i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: EdgeInsets.only(
                        left: i == 0 ? 0 : 4,
                        right: i == 1 ? 0 : 4,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: selected
                            ? theme.colorScheme.primary
                            : Colors.white,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: selected
                              ? theme.colorScheme.primary
                              : Colors.grey.shade300,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        _trackLabels[i],
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          color: selected ? Colors.white : Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),

          const SizedBox(height: 8),

          if (_loading)
            const Expanded(
              child: Center(child: CircularProgressIndicator()),
            )
          else if (_error != null)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Error: $_error',
                        style: const TextStyle(color: Colors.red)),
                    const SizedBox(height: 12),
                    FilledButton(
                      onPressed: _loadMonth,
                      child: const Text('Reintentar'),
                    ),
                  ],
                ),
              ),
            )
          else
            Expanded(child: _buildCalendarGrid()),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid() {
    const dayHeaders = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          // Day-of-week headers
          Row(
            children: dayHeaders
                .map((d) => Expanded(
                      child: Center(
                        child: Text(
                          d,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 6),

          // Calendar cells
          Expanded(
            child: _buildCalendarCells(),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarCells() {
    final cells = <Widget>[];

    // Empty cells before first day (Monday=1, so offset = weekday-1)
    final blanks = _firstWeekday - 1;
    for (var i = 0; i < blanks; i++) {
      cells.add(const SizedBox.shrink());
    }

    for (var d = 1; d <= _daysInMonth; d++) {
      final meals = _dayMeals[d];
      final hasMeals = meals != null && meals.isNotEmpty;
      final date = DateTime.utc(_year, _month, d);
      final isWeekend = date.weekday == 6 || date.weekday == 7;

      cells.add(
        GestureDetector(
          onTap: isWeekend ? null : () => _editDay(d),
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: isWeekend
                  ? Colors.grey.shade100
                  : hasMeals
                      ? const Color(0xFFFB8C00).withValues(alpha: 0.08)
                      : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: hasMeals
                    ? const Color(0xFFFB8C00).withValues(alpha: 0.3)
                    : Colors.grey.shade200,
                width: hasMeals ? 1.5 : 1,
              ),
            ),
            padding: const EdgeInsets.all(4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$d',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                    color: isWeekend ? Colors.grey.shade400 : Colors.black87,
                  ),
                ),
                if (hasMeals) ...[
                  const SizedBox(height: 1),
                  for (final slot in _mealSlots)
                    if (meals.containsKey(slot))
                      Flexible(
                        child: Text(
                          meals[slot]!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 8,
                            color: Colors.grey.shade600,
                            height: 1.2,
                          ),
                        ),
                      ),
                ],
              ],
            ),
          ),
        ),
      );
    }

    // Calculate rows needed
    final totalCells = blanks + _daysInMonth;
    final rows = (totalCells / 7).ceil();

    return GridView.count(
      crossAxisCount: 7,
      childAspectRatio: 0.85,
      children: cells,
    );
  }
}
