import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid_value.dart';

import '../../../app/widgets/empty_state.dart';
import '../../../app/widgets/loading_state.dart';
import '../../../app/widgets/status_pill.dart';
import '../../../core/di/injection.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../data/child_timeline_repository.dart';

class ChildTimelinePage extends StatelessWidget {
  const ChildTimelinePage({super.key, required this.childId});

  final UuidValue childId;

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthCubit>().state;
    final repo = sl<ChildTimelineRepository>();

    if (!auth.isAuthenticated || auth.organizationId == null) {
      return const Scaffold(body: Center(child: Text('No autorizado')));
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        title: const Text(
          'Línea temporal',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.go('/children/$childId'),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: FutureBuilder(
        future: repo.getChildTimeline(
          childId: childId,
          page: 0,
          pageSize: 80,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingState(
                message: 'Cargando línea temporal...');
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final items = snapshot.data ?? const [];
          if (items.isEmpty) {
            return const EmptyState(
              icon: Icons.timeline,
              message: 'No hay eventos en la línea temporal.',
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              final isLast = index == items.length - 1;
              return _TimelineEventItem(
                item: item,
                isLast: isLast,
              );
            },
          );
        },
      ),
    );
  }
}

class _TimelineEventItem extends StatelessWidget {
  const _TimelineEventItem({
    required this.item,
    required this.isLast,
  });

  final dynamic item;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final eventColor = _colorForType(item.eventType);
    final timeStr = DateFormat.Hm().format(item.eventAt);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline line + dot
          SizedBox(
            width: 32,
            child: Column(
              children: [
                // Dot
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: eventColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: eventColor.withValues(alpha: 0.3),
                      width: 3,
                    ),
                  ),
                ),
                // Line
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: Colors.grey.shade300,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Event card
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade100),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        StatusPill(
                          label: _labelForType(item.eventType),
                          color: eventColor,
                          small: true,
                        ),
                        const Spacer(),
                        Text(
                          timeStr,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade400,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                    if (item.description != null &&
                        item.description!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        item.description!,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _colorForType(String type) {
    switch (type) {
      case 'meal':
        return Colors.orange;
      case 'nap':
        return Colors.blue;
      case 'bowel':
        return Colors.purple;
      case 'report':
        return Colors.green;
      case 'document':
        return Colors.grey;
      default:
        return Colors.teal;
    }
  }

  String _labelForType(String type) {
    switch (type) {
      case 'meal':
        return 'Comida';
      case 'nap':
        return 'Siesta';
      case 'bowel':
        return 'Deposición';
      case 'report':
        return 'Informe';
      case 'document':
        return 'Documento';
      default:
        return type;
    }
  }
}
