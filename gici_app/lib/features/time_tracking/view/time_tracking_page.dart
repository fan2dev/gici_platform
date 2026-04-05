import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/injection.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../data/time_tracking_repository.dart';

class TimeTrackingPage extends StatelessWidget {
  const TimeTrackingPage({super.key});

  Future<void> _openCorrectionDialog(
    BuildContext context,
    TimeTrackingRepository repo,
    AuthState auth,
    TimeEntry target,
  ) async {
    final reasonController = TextEditingController();

    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Correct entry'),
        content: TextField(
          controller: reasonController,
          decoration: const InputDecoration(labelText: 'Correction reason'),
          minLines: 2,
          maxLines: 4,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              final reason = reasonController.text.trim();
              if (reason.isEmpty ||
                  auth.organizationId == null ||
                  auth.actorId == null) {
                return;
              }

              await repo.correctEntry(
                organizationId: auth.organizationId!,
                actorId: auth.actorId!,
                targetEntryId: target.id!,
                correctedEntryType: target.entryType == 'check_in'
                    ? 'check_out'
                    : 'check_in',
                correctionReason: reason,
                notes: 'Corrected from app UI',
              );

              if (dialogContext.mounted) {
                Navigator.of(dialogContext).pop();
              }
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Correction created')),
                );
              }
            },
            child: const Text('Create correction'),
          ),
        ],
      ),
    );

    reasonController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;
    final repo = sl<TimeTrackingRepository>();
    final canViewOrganization =
        authState.role == AppRole.organizationAdmin ||
        authState.role == AppRole.platformSuperAdmin;

    if (!authState.isAuthenticated ||
        authState.organizationId == null ||
        authState.actorId == null) {
      return const Scaffold(body: Center(child: Text('Unauthorized')));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Tracking'),
        leading: IconButton(
          onPressed: () => context.go('/dashboard'),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: FutureBuilder<List<TimeEntry>>(
        future: repo.myEntries(
          organizationId: authState.organizationId!,
          actorId: authState.actorId!,
          page: 0,
          pageSize: 20,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final entries = snapshot.data ?? const <TimeEntry>[];

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  children: [
                    FilledButton(
                      onPressed: () async {
                        await repo.checkIn(
                          organizationId: authState.organizationId!,
                          actorId: authState.actorId!,
                          notes: 'Mobile check-in',
                        );
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Check-in registered'),
                            ),
                          );
                        }
                      },
                      child: const Text('Check-in'),
                    ),
                    OutlinedButton(
                      onPressed: () async {
                        await repo.checkOut(
                          organizationId: authState.organizationId!,
                          actorId: authState.actorId!,
                          notes: 'Mobile check-out',
                        );
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Check-out registered'),
                            ),
                          );
                        }
                      },
                      child: const Text('Check-out'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Recent entries',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView(
                    children: [
                      ...entries.map(
                        (entry) => ListTile(
                          title: Text(entry.entryType),
                          subtitle: Text(entry.recordedAt.toIso8601String()),
                          trailing: Text(entry.notes ?? '-'),
                        ),
                      ),
                      if (canViewOrganization) ...[
                        const Divider(height: 24),
                        Text(
                          'Organization overview',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        FutureBuilder<List<TimeEntry>>(
                          future: repo.listEntries(
                            organizationId: authState.organizationId!,
                            actorId: authState.actorId!,
                            page: 0,
                            pageSize: 50,
                          ),
                          builder: (context, orgSnapshot) {
                            if (orgSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }

                            final orgEntries =
                                orgSnapshot.data ?? const <TimeEntry>[];
                            if (orgEntries.isEmpty) {
                              return const Text('No organization entries.');
                            }

                            return Column(
                              children: orgEntries.map((entry) {
                                return ListTile(
                                  title: Text(
                                    'User ${entry.userId} • ${entry.entryType}',
                                  ),
                                  subtitle: Text(
                                    entry.recordedAt.toIso8601String(),
                                  ),
                                  trailing: TextButton(
                                    onPressed: () => _openCorrectionDialog(
                                      context,
                                      repo,
                                      authState,
                                      entry,
                                    ),
                                    child: const Text('Correct'),
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
