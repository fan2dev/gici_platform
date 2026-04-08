import 'package:flutter/material.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:intl/intl.dart';

import '../../../app/widgets/empty_state.dart';
import '../../../app/widgets/gici_avatar.dart';
import '../../../app/widgets/gici_card.dart';
import '../../../app/widgets/loading_state.dart';
import '../../../app/widgets/status_pill.dart';
import '../../../core/config/app_config.dart';
import '../../../core/di/injection.dart';
import '../../chat/data/chat_repository.dart';
import '../../children/data/child_repository.dart';
import '../../habits/data/habit_repository.dart';

// =============================================================================
// STEP 1: Child selector — admin picks which child to preview
// =============================================================================

class ParentPreviewSelectorPage extends StatefulWidget {
  const ParentPreviewSelectorPage({super.key});

  @override
  State<ParentPreviewSelectorPage> createState() =>
      _ParentPreviewSelectorPageState();
}

class _ParentPreviewSelectorPageState extends State<ParentPreviewSelectorPage> {
  List<Child>? _children;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final children =
          await sl<ChildRepository>().listChildren(page: 0, pageSize: 200);
      setState(() {
        _children = children;
        _loading = false;
      });
    } catch (_) {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vista de padres',
            style: TextStyle(fontWeight: FontWeight.w700)),
      ),
      body: _loading
          ? const LoadingState(message: 'Cargando alumnos...')
          : _children == null || _children!.isEmpty
              ? const EmptyState(
                  message: 'No hay alumnos',
                  icon: Icons.child_care,
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
                      child: Text(
                        'Selecciona un alumno para ver lo que ven sus familias',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _children!.length,
                        itemBuilder: (context, index) {
                          final child = _children![index];
                          final name =
                              '${child.firstName} ${child.lastName}';
                          return GiciCard(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) =>
                                    _ParentPreviewShell(child: child),
                              ));
                            },
                            child: Row(
                              children: [
                                GiciAvatar(name: name, radius: 24),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Text(
                                    name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                Icon(Icons.visibility_rounded,
                                    color: theme.colorScheme.primary,
                                    size: 22),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}

// =============================================================================
// STEP 2: Parent preview shell — full experience with bottom nav
// =============================================================================

class _ParentPreviewShell extends StatefulWidget {
  const _ParentPreviewShell({required this.child});
  final Child child;

  @override
  State<_ParentPreviewShell> createState() => _ParentPreviewShellState();
}

class _ParentPreviewShellState extends State<_ParentPreviewShell> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final name = '${widget.child.firstName} ${widget.child.lastName}';
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    final tabs = [
      _ParentHomePage(child: widget.child),
      _ParentChatPage(child: widget.child),
      _ParentHabitsPage(child: widget.child),
      _ParentProfilePage(child: widget.child),
      _ParentSettingsPage(child: widget.child),
    ];

    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: tabs,
          ),

          // Preview mode banner at top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.visibility, color: Colors.white, size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Vista familiar: $name',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Text(
                          'Salir',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _BottomNavItem(
                  icon: Icons.home_rounded,
                  label: 'Inicio',
                  selected: _currentIndex == 0,
                  color: primary,
                  onTap: () => setState(() => _currentIndex = 0),
                ),
                _BottomNavItem(
                  icon: Icons.chat_bubble_rounded,
                  label: 'Chat',
                  selected: _currentIndex == 1,
                  color: primary,
                  onTap: () => setState(() => _currentIndex = 1),
                ),
                _BottomNavItem(
                  icon: Icons.restaurant_rounded,
                  label: 'Hábitos',
                  selected: _currentIndex == 2,
                  color: primary,
                  onTap: () => setState(() => _currentIndex = 2),
                ),
                _BottomNavItem(
                  icon: Icons.person_rounded,
                  label: 'Perfil',
                  selected: _currentIndex == 3,
                  color: primary,
                  onTap: () => setState(() => _currentIndex = 3),
                ),
                _BottomNavItem(
                  icon: Icons.settings_rounded,
                  label: 'Ajustes',
                  selected: _currentIndex == 4,
                  color: primary,
                  onTap: () => setState(() => _currentIndex = 4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: selected ? 48 : 40,
              height: selected ? 48 : 40,
              decoration: BoxDecoration(
                color: selected ? color : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: selected ? Colors.white : Colors.grey.shade400,
                size: selected ? 24 : 22,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: selected ? color : Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// TAB 1: Home — Welcome + today summary (mockup-inspired)
// =============================================================================

class _ParentHomePage extends StatefulWidget {
  const _ParentHomePage({required this.child});
  final Child child;

  @override
  State<_ParentHomePage> createState() => _ParentHomePageState();
}

class _ParentHomePageState extends State<_ParentHomePage> {
  ChildDailyHabits? _habits;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final now = DateTime.now();
      final today = DateTime.utc(now.year, now.month, now.day);
      final habits = await sl<HabitRepository>().getChildDailyHabits(
        childId: widget.child.id!,
        day: today,
      );
      if (mounted) setState(() { _habits = habits; _loading = false; });
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  String _calculateAge(DateTime dob) {
    final now = DateTime.now();
    int years = now.year - dob.year;
    int months = now.month - dob.month;
    if (now.day < dob.day) months--;
    if (months < 0) {
      years--;
      months += 12;
    }
    if (years > 0) return '$years año${years > 1 ? 's' : ''}';
    return '$months meses';
  }

  @override
  Widget build(BuildContext context) {
    final childName = widget.child.firstName;
    final fullName = '${widget.child.firstName} ${widget.child.lastName}';
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final age = _calculateAge(widget.child.dateOfBirth);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 64, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting
            Text(
              'Hola Laura!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Así va el día de $childName',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade500,
              ),
            ),
            const SizedBox(height: 20),

            // Child card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  GiciAvatar(name: fullName, radius: 32),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fullName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            StatusPill(label: age, color: primary, small: true),
                            const SizedBox(width: 8),
                            if (widget.child.status == 'active')
                              StatusPill.active(),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 14, color: Colors.grey.shade400),
                            const SizedBox(width: 4),
                            Text(
                              AppConfig.current.appName,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Today summary
            if (_loading)
              const Center(child: Padding(
                padding: EdgeInsets.all(32),
                child: CircularProgressIndicator(),
              ))
            else ...[
              Text(
                'Resumen de hoy',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 12),

              // Natural text summaries
              if (_habits != null) ...[
                if (_habits!.meals.isNotEmpty)
                  _NaturalSummaryCard(
                    emoji: '🍽',
                    text: _buildMealSummary(childName),
                    color: const Color(0xFFFF8A65),
                  ),
                if (_habits!.naps.isNotEmpty)
                  _NaturalSummaryCard(
                    emoji: '😴',
                    text: _buildNapSummary(childName),
                    color: const Color(0xFF7986CB),
                  ),
                if (_habits!.bowelMovements.isNotEmpty)
                  _NaturalSummaryCard(
                    emoji: '🧷',
                    text: _buildBowelSummary(childName),
                    color: const Color(0xFF4DB6AC),
                  ),
                if (_habits!.meals.isEmpty &&
                    _habits!.naps.isEmpty &&
                    _habits!.bowelMovements.isEmpty)
                  _NaturalSummaryCard(
                    emoji: '📋',
                    text: 'Todavía no hay registros para hoy.',
                    color: Colors.grey,
                  ),
              ],
              if (_habits == null)
                _NaturalSummaryCard(
                  emoji: '📋',
                  text: 'No se pudieron cargar los datos de hoy.',
                  color: Colors.grey,
                ),

              // Allergies alert
              if (widget.child.allergies != null &&
                  widget.child.allergies!.isNotEmpty) ...[
                const SizedBox(height: 8),
                GiciCard(
                  accentColor: const Color(0xFFE53935),
                  child: Row(
                    children: [
                      const Icon(Icons.warning_amber_rounded,
                          color: Color(0xFFE53935), size: 22),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Alergias',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13)),
                            Text(widget.child.allergies!,
                                style: const TextStyle(fontSize: 13)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              // Timeline preview
              if (_habits != null) ...[
                const SizedBox(height: 24),
                Row(
                  children: [
                    Text(
                      '\u00daltimas actividades',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Ver todo'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ..._buildTimelinePreview(),
              ],

              // Compact links: Informes + Galerias
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _CompactLinkCard(
                      emoji: '\u{1F4DD}',
                      label: 'Informes',
                      color: const Color(0xFF5C6BC0),
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _CompactLinkCard(
                      emoji: '\u{1F4F8}',
                      label: 'Galer\u00edas',
                      color: const Color(0xFFFFA726),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _buildMealSummary(String name) {
    final meals = _habits!.meals;
    final types = meals.map((m) => _mealLabel(m.mealType).toLowerCase()).toList();
    if (types.length == 1) {
      return 'Hoy $name ha tomado ${types.first}.';
    }
    final last = types.removeLast();
    return 'Hoy $name ha tomado ${types.join(', ')} y $last.';
  }

  String _buildNapSummary(String name) {
    final naps = _habits!.naps;
    if (naps.length == 1) {
      final dur = naps.first.durationMinutes;
      if (dur != null) {
        final h = dur ~/ 60;
        final m = dur % 60;
        final durStr = h > 0
            ? '$h h${m > 0 ? ' ${m}m' : ''}'
            : '$m min';
        return '$name ha dormido una siesta de $durStr.';
      }
      return '$name ha dormido una siesta.';
    }
    return '$name ha dormido ${naps.length} siestas hoy.';
  }

  String _buildBowelSummary(String name) {
    final count = _habits!.bowelMovements.length;
    if (count == 1) {
      return '$name ha tenido un cambio de pañal.';
    }
    return '$name ha tenido $count cambios de pañal.';
  }

  List<Widget> _buildTimelinePreview() {
    final items = <_TimelineEntry>[];

    for (final m in _habits?.meals ?? <MealEntry>[]) {
      items.add(_TimelineEntry(
        time: m.recordedAt,
        emoji: '🍽',
        title: _mealLabel(m.mealType),
        detail: _consumptionLabel(m.consumptionLevel),
        notes: m.notes,
        color: const Color(0xFFFF8A65),
      ));
    }
    for (final n in _habits?.naps ?? <NapEntry>[]) {
      final dur = n.durationMinutes != null ? '${n.durationMinutes} min' : '';
      items.add(_TimelineEntry(
        time: n.startedAt,
        emoji: '😴',
        title: 'Siesta',
        detail: dur.isNotEmpty ? dur : (n.endedAt != null ? 'Finalizada' : 'En curso'),
        notes: n.notes,
        color: const Color(0xFF7986CB),
      ));
    }
    for (final b in _habits?.bowelMovements ?? <BowelMovementEntry>[]) {
      items.add(_TimelineEntry(
        time: b.eventAt,
        emoji: '🧷',
        title: _bowelLabel(b.eventType),
        detail: b.consistency != null ? _consistencyLabel(b.consistency!) : '',
        notes: b.notes,
        color: const Color(0xFF4DB6AC),
      ));
    }

    items.sort((a, b) => b.time.compareTo(a.time));

    // Show at most 4
    final preview = items.take(4).toList();
    return preview.map((entry) {
      final timeStr =
          '${entry.time.hour.toString().padLeft(2, '0')}:${entry.time.minute.toString().padLeft(2, '0')}';
      return _TimelineCard(entry: entry, timeStr: timeStr);
    }).toList();
  }

  String _mealLabel(String t) {
    switch (t) {
      case 'bottle': return 'Biberón';
      case 'breakfast': return 'Desayuno';
      case 'lunch': return 'Comida';
      case 'snack': return 'Merienda';
      default: return t;
    }
  }

  String _consumptionLabel(String l) {
    switch (l) {
      case 'little': return 'Poco';
      case 'most': return 'Bastante';
      case 'all': return 'Todo';
      default: return l;
    }
  }

  String _bowelLabel(String t) {
    switch (t) {
      case 'toilet': return 'WC';
      case 'diaper': return 'Pañal';
      case 'diaper_change': return 'Cambio de pañal';
      case 'accident': return 'Accidente';
      default: return t;
    }
  }

  String _consistencyLabel(String c) {
    switch (c) {
      case 'liquid': return 'Líquido';
      case 'normal': return 'Normal';
      case 'hard': return 'Dura';
      default: return c;
    }
  }
}

class _CompactLinkCard extends StatelessWidget {
  const _CompactLinkCard({
    required this.emoji,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final String emoji;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _NaturalSummaryCard extends StatelessWidget {
  const _NaturalSummaryCard({
    required this.emoji,
    required this.text,
    required this.color,
  });

  final String emoji;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.15)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 22)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// TAB 2: Chat placeholder
// =============================================================================

class _ParentChatPage extends StatefulWidget {
  const _ParentChatPage({required this.child});
  final Child child;

  @override
  State<_ParentChatPage> createState() => _ParentChatPageState();
}

class _ParentChatPageState extends State<_ParentChatPage> {
  bool _loading = true;
  ChatConversation? _conversation;
  List<ChatMessage>? _messages;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final repo = sl<ChatRepository>();
      final conversations = await repo.listConversations(pageSize: 100);

      // Find conversation related to this child
      ChatConversation? found;
      for (final conv in conversations) {
        if (conv.relatedChildId == widget.child.id) {
          found = conv;
          break;
        }
      }

      if (found != null) {
        final messages = await repo.listMessages(
          conversationId: found.id!,
          pageSize: 50,
        );
        if (mounted) {
          setState(() {
            _conversation = found;
            _messages = messages;
            _loading = false;
          });
        }
      } else {
        if (mounted) setState(() => _loading = false);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'No se pudieron cargar los mensajes.';
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 64, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Chat',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 4),
                Text(
                  'Mensajes del grupo de ${widget.child.firstName}',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _loading
                ? const LoadingState(message: 'Cargando mensajes...')
                : _error != null
                    ? Center(
                        child: Text(
                          _error!,
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                      )
                    : _conversation == null || _messages == null
                        ? const EmptyState(
                            message:
                                'No hay conversaciones para este alumno.',
                            icon: Icons.chat_bubble_outline_rounded,
                          )
                        : _messages!.isEmpty
                            ? const EmptyState(
                                message: 'No hay mensajes todavía.',
                                icon: Icons.chat_bubble_outline_rounded,
                              )
                            : ListView.builder(
                                padding: const EdgeInsets.fromLTRB(
                                    16, 0, 16, 24),
                                itemCount: _messages!.length,
                                itemBuilder: (context, index) {
                                  // Messages are newest-first from API;
                                  // show oldest at top
                                  final msg = _messages![
                                      _messages!.length - 1 - index];
                                  // In preview mode, we don't know who
                                  // the current guardian user is, so we
                                  // treat first sender as "family" side
                                  // and alternate. A simple heuristic:
                                  // use the first message's sender as
                                  // the guardian, others are staff.
                                  final firstSender =
                                      _messages!.last.senderUserId;
                                  final isStaff =
                                      msg.senderUserId != firstSender;
                                  return _ChatBubble(
                                    message: msg,
                                    isStaff: isStaff,
                                    primary: primary,
                                  );
                                },
                              ),
          ),
          // Read-only indicator
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border(
                top: BorderSide(color: Colors.grey.shade200),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.visibility_rounded,
                    size: 16, color: Colors.grey.shade400),
                const SizedBox(width: 8),
                Text(
                  'Vista previa (solo lectura)',
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  const _ChatBubble({
    required this.message,
    required this.isStaff,
    required this.primary,
  });

  final ChatMessage message;
  final bool isStaff;
  final Color primary;

  @override
  Widget build(BuildContext context) {
    final time =
        '${message.sentAt.hour.toString().padLeft(2, '0')}:${message.sentAt.minute.toString().padLeft(2, '0')}';
    final senderLabel = isStaff ? 'Centro' : 'Familia';

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment:
            isStaff ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isStaff) ...[
            GiciAvatar(
              name: senderLabel,
              radius: 14,
              color: primary,
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: isStaff
                    ? Colors.white
                    : primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isStaff ? 4 : 16),
                  bottomRight: Radius.circular(isStaff ? 16 : 4),
                ),
                border: Border.all(
                  color: isStaff
                      ? Colors.grey.shade200
                      : primary.withValues(alpha: 0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isStaff)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        senderLabel,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: primary,
                        ),
                      ),
                    ),
                  Text(
                    message.body,
                    style: const TextStyle(fontSize: 14, height: 1.4),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!isStaff) const SizedBox(width: 8),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 3: Habits timeline (mockup-inspired)
// =============================================================================

class _ParentHabitsPage extends StatefulWidget {
  const _ParentHabitsPage({required this.child});
  final Child child;

  @override
  State<_ParentHabitsPage> createState() => _ParentHabitsPageState();
}

class _ParentHabitsPageState extends State<_ParentHabitsPage> {
  ChildDailyHabits? _habits;
  bool _loading = true;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedDate = DateTime.utc(now.year, now.month, now.day);
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final habits = await sl<HabitRepository>().getChildDailyHabits(
        childId: widget.child.id!,
        day: _selectedDate,
      );
      if (mounted) setState(() { _habits = habits; _loading = false; });
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _changeDate(int delta) {
    setState(() {
      _selectedDate = _selectedDate.add(Duration(days: delta));
    });
    _load();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final today = DateTime.now();
    final isToday = _selectedDate.year == today.year &&
        _selectedDate.month == today.month &&
        _selectedDate.day == today.day;

    final dateFormatted = DateFormat("EEEE, d 'de' MMMM", 'es_ES').format(_selectedDate);
    final dateCapitalized = '${dateFormatted[0].toUpperCase()}${dateFormatted.substring(1)}';

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header area
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 64, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date display
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('📅', style: const TextStyle(fontSize: 16)),
                      const SizedBox(width: 8),
                      Text(
                        isToday ? 'Hoy, $dateCapitalized' : dateCapitalized,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: primary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Greeting
                Text(
                  'Hola Laura',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Actividades de ${widget.child.firstName}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade500,
                  ),
                ),
                const SizedBox(height: 16),

                // Date navigation
                Row(
                  children: [
                    _DateNavButton(
                      icon: Icons.chevron_left_rounded,
                      onTap: () => _changeDate(-1),
                    ),
                    const SizedBox(width: 8),
                    _DateNavButton(
                      icon: Icons.chevron_right_rounded,
                      onTap: isToday ? null : () => _changeDate(1),
                    ),
                    const Spacer(),
                    if (!isToday)
                      TextButton.icon(
                        onPressed: () {
                          final now = DateTime.now();
                          setState(() {
                            _selectedDate = DateTime.utc(now.year, now.month, now.day);
                          });
                          _load();
                        },
                        icon: const Icon(Icons.today, size: 18),
                        label: const Text('Hoy'),
                      ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Timeline
          Expanded(
            child: _loading
                ? const LoadingState()
                : _buildTimeline(theme),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline(ThemeData theme) {
    final items = <_TimelineEntry>[];

    for (final m in _habits?.meals ?? <MealEntry>[]) {
      items.add(_TimelineEntry(
        time: m.recordedAt,
        emoji: '🍽',
        title: _mealLabel(m.mealType),
        detail: _consumptionLabel(m.consumptionLevel),
        notes: m.notes,
        color: const Color(0xFFFF8A65),
      ));
    }
    for (final n in _habits?.naps ?? <NapEntry>[]) {
      final dur = n.durationMinutes != null ? '${n.durationMinutes} min' : '';
      items.add(_TimelineEntry(
        time: n.startedAt,
        emoji: '😴',
        title: 'Siesta',
        detail: dur.isNotEmpty ? dur : (n.endedAt != null ? 'Finalizada' : 'En curso'),
        notes: n.notes,
        color: const Color(0xFF7986CB),
      ));
    }
    for (final b in _habits?.bowelMovements ?? <BowelMovementEntry>[]) {
      items.add(_TimelineEntry(
        time: b.eventAt,
        emoji: '🧷',
        title: _bowelLabel(b.eventType),
        detail: b.consistency != null ? _consistencyLabel(b.consistency!) : '',
        notes: b.notes,
        color: const Color(0xFF4DB6AC),
      ));
    }

    items.sort((a, b) => b.time.compareTo(a.time));

    if (items.isEmpty) {
      return const EmptyState(
        message: 'Sin registros para este día',
        icon: Icons.event_note_outlined,
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      itemCount: items.length,
      itemBuilder: (context, i) {
        final entry = items[i];
        final timeStr =
            '${entry.time.hour.toString().padLeft(2, '0')}:${entry.time.minute.toString().padLeft(2, '0')}';
        return _TimelineCard(entry: entry, timeStr: timeStr);
      },
    );
  }

  String _mealLabel(String t) {
    switch (t) {
      case 'bottle': return 'Biberón';
      case 'breakfast': return 'Desayuno';
      case 'lunch': return 'Comida';
      case 'snack': return 'Merienda';
      default: return t;
    }
  }

  String _consumptionLabel(String l) {
    switch (l) {
      case 'little': return 'Poco';
      case 'most': return 'Bastante';
      case 'all': return 'Todo';
      default: return l;
    }
  }

  String _bowelLabel(String t) {
    switch (t) {
      case 'toilet': return 'WC';
      case 'diaper': return 'Pañal';
      case 'diaper_change': return 'Cambio de pañal';
      case 'accident': return 'Accidente';
      default: return t;
    }
  }

  String _consistencyLabel(String c) {
    switch (c) {
      case 'liquid': return 'Líquido';
      case 'normal': return 'Normal';
      case 'hard': return 'Dura';
      default: return c;
    }
  }
}

class _DateNavButton extends StatelessWidget {
  const _DateNavButton({required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: onTap != null ? Colors.grey.shade700 : Colors.grey.shade300,
        ),
      ),
    );
  }
}

// =============================================================================
// Timeline card widget (shared between Home and Habits)
// =============================================================================

class _TimelineCard extends StatelessWidget {
  const _TimelineCard({required this.entry, required this.timeStr});

  final _TimelineEntry entry;
  final String timeStr;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Time column
            SizedBox(
              width: 50,
              child: Column(
                children: [
                  Text(
                    timeStr,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                      color: entry.color,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  if (entry.detail.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      entry.detail,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                  if (entry.notes != null && entry.notes!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      entry.notes!,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade500,
                        fontStyle: FontStyle.italic,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),

            // Emoji illustration on right
            const SizedBox(width: 12),
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: entry.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(entry.emoji, style: const TextStyle(fontSize: 22)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// TAB 4: Profile (mockup-inspired)
// =============================================================================

class _ParentProfilePage extends StatelessWidget {
  const _ParentProfilePage({required this.child});
  final Child child;

  @override
  Widget build(BuildContext context) {
    final name = '${child.firstName} ${child.lastName}';
    final age = _calculateAge(child.dateOfBirth);
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 64, 20, 24),
        child: Column(
          children: [
            // Profile header card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  GiciAvatar(name: name, radius: 40),
                  const SizedBox(height: 14),
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StatusPill(label: age, color: primary),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on, size: 14, color: Colors.grey.shade400),
                      const SizedBox(width: 4),
                      Text(
                        AppConfig.current.appName,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Info section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Información',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                  ),
                  const SizedBox(height: 16),
                  _InfoRow(emoji: '🎂', label: 'Nacimiento',
                      value: DateFormat('d/M/yyyy').format(child.dateOfBirth)),
                  if (child.gender != null)
                    _InfoRow(
                        emoji: '👤',
                        label: 'Género',
                        value: child.gender == 'male' ? 'Masculino' : 'Femenino'),
                  _InfoRow(emoji: '\u{1F3EB}', label: 'Aula',
                      value: 'Sin asignar'),
                  _InfoRow(emoji: '\u{1F37D}\u{FE0F}', label: 'Men\u00fa',
                      value: _translateMenuType(child.menuType)),
                  _InfoRow(emoji: '\u{1F3EB}', label: 'Centro',
                      value: AppConfig.current.appName),
                  if (child.status == 'active')
                    _InfoRow(emoji: '\u{2705}', label: 'Estado', value: 'Matriculado'),
                  if (child.enrollmentDate != null)
                    _InfoRow(emoji: '\u{1F4C5}', label: 'Desde',
                        value: DateFormat('d/M/yyyy').format(child.enrollmentDate!)),
                  if (child.allergies != null && child.allergies!.isNotEmpty)
                    _InfoRow(emoji: '\u{26A0}\u{FE0F}', label: 'Alergias', value: child.allergies!),
                  if (child.medicalNotes != null && child.medicalNotes!.isNotEmpty)
                    _InfoRow(emoji: '\u{1F3E5}', label: 'Notas m\u00e9dicas', value: child.medicalNotes!),
                  if (child.dietaryNotes != null && child.dietaryNotes!.isNotEmpty)
                    _InfoRow(emoji: '\u{1F957}', label: 'Dieta', value: child.dietaryNotes!),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 3 compact link cards: Informes, Galerias, Documentos
            Row(
              children: [
                Expanded(
                  child: _CompactLinkCard(
                    emoji: '\u{1F4DD}',
                    label: 'Informes',
                    color: const Color(0xFF5C6BC0),
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _CompactLinkCard(
                    emoji: '\u{1F4F8}',
                    label: 'Galer\u00edas',
                    color: const Color(0xFFFFA726),
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _CompactLinkCard(
                    emoji: '\u{1F4C4}',
                    label: 'Documentos',
                    color: const Color(0xFF26A69A),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _calculateAge(DateTime dob) {
    final now = DateTime.now();
    int years = now.year - dob.year;
    int months = now.month - dob.month;
    if (now.day < dob.day) months--;
    if (months < 0) {
      years--;
      months += 12;
    }
    if (years > 0) return '$years a\u00f1o${years > 1 ? 's' : ''} y $months meses';
    return '$months meses';
  }

  static String _translateMenuType(String? menuType) {
    switch (menuType) {
      case 'bottle':
        return '\u{1F37C} Biber\u00f3n';
      case 'puree':
        return '\u{1F963} Pur\u00e9/Triturado';
      case 'normal':
        return '\u{1F37D}\u{FE0F} Men\u00fa normal';
      default:
        return 'Sin asignar';
    }
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.emoji,
    required this.label,
    required this.value,
  });

  final String emoji;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 10),
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 5: Settings placeholder
// =============================================================================

class _ParentSettingsPage extends StatelessWidget {
  const _ParentSettingsPage({required this.child});
  final Child child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 64, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ajustes',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 4),
            Text(
              'Configuración de la cuenta familiar',
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 24),

            // RGPD / Consent section
            _SettingsSection(
              title: 'Consentimientos RGPD',
              icon: Icons.shield_rounded,
              iconColor: const Color(0xFF43A047),
              children: [
                _SettingsToggleRow(
                  label: 'Fotos y vídeos',
                  subtitle: 'Uso de imágenes en la plataforma',
                  value: true,
                  color: primary,
                ),
                _SettingsToggleRow(
                  label: 'Datos médicos',
                  subtitle: 'Registro de alergias e incidencias',
                  value: true,
                  color: primary,
                ),
                _SettingsToggleRow(
                  label: 'Comunicaciones',
                  subtitle: 'Envío de notificaciones y circulares',
                  value: true,
                  color: primary,
                ),
                _SettingsToggleRow(
                  label: 'Excursiones',
                  subtitle: 'Participación en salidas escolares',
                  value: false,
                  color: primary,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Notification preferences
            _SettingsSection(
              title: 'Notificaciones',
              icon: Icons.notifications_rounded,
              iconColor: const Color(0xFFFB8C00),
              children: [
                _SettingsToggleRow(
                  label: 'Hábitos diarios',
                  subtitle: 'Comidas, siestas y cambios',
                  value: true,
                  color: primary,
                ),
                _SettingsToggleRow(
                  label: 'Mensajes del centro',
                  subtitle: 'Circulares y avisos',
                  value: true,
                  color: primary,
                ),
                _SettingsToggleRow(
                  label: 'Galerías nuevas',
                  subtitle: 'Cuando se publican fotos',
                  value: true,
                  color: primary,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Center contact info
            _SettingsSection(
              title: 'Contacto del centro',
              icon: Icons.location_on_rounded,
              iconColor: const Color(0xFF1E88E5),
              children: [
                _SettingsInfoRow(
                  icon: Icons.business_rounded,
                  label: AppConfig.current.appName,
                ),
                _SettingsInfoRow(
                  icon: Icons.phone_rounded,
                  label: '912 345 678',
                ),
                _SettingsInfoRow(
                  icon: Icons.email_rounded,
                  label: 'info@escuelainfantil.es',
                ),
                _SettingsInfoRow(
                  icon: Icons.access_time_rounded,
                  label: 'Lun-Vie 7:30 - 17:00',
                ),
              ],
            ),
            const SizedBox(height: 20),

            // App version
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  children: [
                    Text(
                      'GICI App',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Versión 1.0.0',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.children,
  });

  final String title;
  final IconData icon;
  final Color iconColor;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 18, color: iconColor),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}

class _SettingsToggleRow extends StatelessWidget {
  const _SettingsToggleRow({
    required this.label,
    required this.subtitle,
    required this.value,
    required this.color,
  });

  final String label;
  final String subtitle;
  final bool value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
          IgnorePointer(
            child: Switch.adaptive(
              value: value,
              onChanged: (_) {},
              activeTrackColor: color.withValues(alpha: 0.5),
              thumbColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) return color;
                return null;
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsInfoRow extends StatelessWidget {
  const _SettingsInfoRow({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey.shade400),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Shared model
// =============================================================================

class _TimelineEntry {
  const _TimelineEntry({
    required this.time,
    required this.emoji,
    required this.title,
    required this.detail,
    required this.color,
    this.notes,
  });

  final DateTime time;
  final String emoji;
  final String title;
  final String detail;
  final Color color;
  final String? notes;
}
