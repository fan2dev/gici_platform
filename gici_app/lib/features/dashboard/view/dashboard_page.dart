import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../auth/cubit/auth_cubit.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({
    super.key,
    required this.isWebEntry,
    required this.role,
  });

  final bool isWebEntry;
  final AppRole? role;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthCubit>().signOut();
              context.go('/login');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Entry: ${isWebEntry ? 'Web' : 'Mobile'}'),
            Text('Role: ${role?.name ?? 'unknown'}'),
            const SizedBox(height: 4),
            Text('Email: ${context.watch<AuthCubit>().state.email ?? '-'}'),
            Text(
              'Organization: ${context.watch<AuthCubit>().state.organizationId ?? '-'}',
            ),
            Text('Actor: ${context.watch<AuthCubit>().state.actorId ?? '-'}'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                FilledButton(
                  onPressed: () => context.go('/time-tracking'),
                  child: const Text('Time tracking'),
                ),
                FilledButton(
                  onPressed: () => context.go('/chat'),
                  child: const Text('Chat'),
                ),
                FilledButton(
                  onPressed: () => context.go('/children'),
                  child: const Text('Children'),
                ),
                FilledButton(
                  onPressed: () => context.go('/habits'),
                  child: const Text('Habits'),
                ),
                FilledButton(
                  onPressed: () => context.go('/requests'),
                  child: Text(
                    role == AppRole.guardian
                        ? 'My Requests'
                        : 'Requests Review',
                  ),
                ),
                if (role != AppRole.guardian)
                  FilledButton(
                    onPressed: () => context.go('/classrooms'),
                    child: const Text('Classrooms'),
                  ),
                FilledButton(
                  onPressed: () => context.go('/experience'),
                  child: const Text('Center & menu'),
                ),
                FilledButton(
                  onPressed: () => context.go('/notifications'),
                  child: const Text('Notifications'),
                ),
                FilledButton(
                  onPressed: () => context.go('/documents'),
                  child: const Text('Documents'),
                ),
                FilledButton(
                  onPressed: () => context.go('/galleries'),
                  child: const Text('Galleries'),
                ),
                FilledButton(
                  onPressed: () => context.go('/settings'),
                  child: const Text('Settings'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
