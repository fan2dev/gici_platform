import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid_value.dart';

import '../../../core/di/injection.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../data/pedagogical_report_repository.dart';

class PedagogicalReportDetailPage extends StatefulWidget {
  const PedagogicalReportDetailPage({
    super.key,
    required this.childId,
    required this.reportId,
  });

  final UuidValue childId;
  final UuidValue reportId;

  @override
  State<PedagogicalReportDetailPage> createState() => _PedagogicalReportDetailPageState();
}

class _PedagogicalReportDetailPageState extends State<PedagogicalReportDetailPage> {
  final _summaryController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  void dispose() {
    _summaryController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

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
        title: const Text('Report Detail'),
        leading: IconButton(
          onPressed: () => context.go('/reports/${widget.childId}'),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: FutureBuilder(
        future: repo.getReport(
          reportId: widget.reportId,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || snapshot.data == null) {
            return Center(child: Text('Report load error: ${snapshot.error}'));
          }

          final report = snapshot.data!;
          _summaryController.text = report.summary;
          _bodyController.text = report.body;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(report.title, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Text('Date: ${report.reportDate.toIso8601String()}'),
                Text('Status: ${report.status} • Visibility: ${report.visibility}'),
                const SizedBox(height: 16),
                TextField(
                  controller: _summaryController,
                  readOnly: !canManage,
                  decoration: const InputDecoration(labelText: 'Summary'),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: TextField(
                    controller: _bodyController,
                    readOnly: !canManage,
                    maxLines: null,
                    expands: true,
                    decoration: const InputDecoration(labelText: 'Body'),
                  ),
                ),
                if (canManage)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: FilledButton(
                      onPressed: () async {
                        await repo.updateReport(
                          reportId: report.id!,
                          summary: _summaryController.text.trim(),
                          body: _bodyController.text.trim(),
                        );
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Report updated')),
                        );
                      },
                      child: const Text('Save changes'),
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
