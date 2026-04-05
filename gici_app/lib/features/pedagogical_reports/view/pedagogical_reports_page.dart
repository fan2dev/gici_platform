import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid_value.dart';

import '../../../core/di/injection.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../data/pedagogical_report_repository.dart';

class PedagogicalReportsPage extends StatefulWidget {
  const PedagogicalReportsPage({super.key, required this.childId});

  final UuidValue childId;

  @override
  State<PedagogicalReportsPage> createState() => _PedagogicalReportsPageState();
}

class _PedagogicalReportsPageState extends State<PedagogicalReportsPage> {
  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthCubit>().state;
    final repo = sl<PedagogicalReportRepository>();

    if (!auth.isAuthenticated || auth.organizationId == null) {
      return const Scaffold(body: Center(child: Text('Unauthorized')));
    }

    final canManage = auth.isStaffOrAbove;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedagogical Reports'),
        leading: IconButton(
          onPressed: () => context.go('/children/${widget.childId}'),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: FutureBuilder<List<PedagogicalReport>>(
        future: repo.listReportsByChild(
          childId: widget.childId,
          page: 0,
          pageSize: 100,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Report load error: ${snapshot.error}'));
          }

          final reports = snapshot.data ?? const <PedagogicalReport>[];
          if (reports.isEmpty) {
            return const Center(child: Text('No pedagogical reports yet.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: reports.length,
            itemBuilder: (context, index) {
              final report = reports[index];
              return ListTile(
                title: Text(report.title),
                subtitle: Text(report.summary),
                trailing: Text(report.reportDate.toIso8601String()),
                onTap: () =>
                    context.go('/reports/${widget.childId}/${report.id}'),
              );
            },
          );
        },
      ),
      floatingActionButton: canManage
          ? FloatingActionButton.extended(
              onPressed: () async {
                await repo.createReport(
                  childId: widget.childId,
                  reportDate: DateTime.now().toUtc(),
                  title: 'Daily progress',
                  summary: 'Classroom progress summary',
                  body: 'Child participated in group and sensory activities.',
                  status: 'published',
                  visibility: 'guardian',
                );
                if (mounted) setState(() {});
              },
              label: const Text('Create report'),
            )
          : null,
    );
  }
}
