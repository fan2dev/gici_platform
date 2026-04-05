import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid_value.dart';

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
      return const Scaffold(body: Center(child: Text('Unauthorized')));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Child Timeline'),
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
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Timeline load error: ${snapshot.error}'),
            );
          }

          final items = snapshot.data ?? const [];
          if (items.isEmpty) {
            return const Center(child: Text('No timeline data yet.'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                tileColor: Theme.of(
                  context,
                ).colorScheme.surfaceContainerHighest,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                title: Text(item.title),
                subtitle: Text(item.description ?? item.eventType),
                trailing: Text(item.eventAt.toIso8601String()),
              );
            },
          );
        },
      ),
    );
  }
}
