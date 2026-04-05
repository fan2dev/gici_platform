import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/injection.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../data/experience_repository.dart';

class ExperiencePage extends StatefulWidget {
  const ExperiencePage({super.key});

  @override
  State<ExperiencePage> createState() => _ExperiencePageState();
}

class _ExperiencePageState extends State<ExperiencePage> {
  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthCubit>().state;
    final repo = sl<ExperienceRepository>();

    if (!auth.isAuthenticated || auth.organizationId == null) {
      return const Scaffold(body: Center(child: Text('Unauthorized')));
    }

    final canManageMenu = auth.isStaffOrAbove;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Center & Onboarding'),
        leading: IconButton(
          onPressed: () => context.go('/dashboard'),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: FutureBuilder<(Organization, UserOnboardingState?, List<MenuEntry>)>(
        future: () async {
          final center = await repo.getCenterInfo();
          final onboarding = await repo.getOnboardingState();
          final menu = await repo.listMenuEntries(
            page: 0,
            pageSize: 30,
          );
          return (center, onboarding, menu);
        }(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Load error: ${snapshot.error}'));
          }

          final center = snapshot.data!.$1;
          final onboarding = snapshot.data!.$2;
          final menu = snapshot.data!.$3;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'Center info',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Card(
                child: ListTile(
                  title: Text(center.name),
                  subtitle: Text(
                    'Slug: ${center.slug}\nEmail: ${center.contactEmail}',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Onboarding',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Card(
                child: ListTile(
                  title: Text(
                    onboarding?.completedAt == null
                        ? 'Onboarding pending'
                        : 'Onboarding completed',
                  ),
                  subtitle: Text(
                    onboarding?.completedAt == null
                        ? 'Not completed yet'
                        : onboarding!.completedAt!.toIso8601String(),
                  ),
                  trailing: onboarding?.completedAt == null
                      ? FilledButton(
                          onPressed: () async {
                            await repo.completeOnboarding(
                              acceptTerms: true,
                            );
                            if (mounted) setState(() {});
                          },
                          child: const Text('Complete'),
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 16),
              Text('Menu', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              if (menu.isEmpty)
                const Text('No menu entries yet.')
              else
                ...menu.map(
                  (entry) => ListTile(
                    title: Text(entry.title),
                    subtitle: Text(
                      '${entry.mealType} • ${entry.menuDate.toIso8601String()}',
                    ),
                  ),
                ),
            ],
          );
        },
      ),
      floatingActionButton: canManageMenu
          ? FloatingActionButton.extended(
              onPressed: () async {
                await repo.createMenuEntry(
                  menuDate: DateTime.now().toUtc(),
                  mealType: 'lunch',
                  title: 'Daily menu',
                  description: 'Generated from app UI',
                );
                if (mounted) setState(() {});
              },
              label: const Text('Add menu'),
            )
          : null,
    );
  }
}
