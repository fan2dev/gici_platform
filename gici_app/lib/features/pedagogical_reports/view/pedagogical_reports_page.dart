import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid_value.dart';

import '../../../app/widgets/empty_state.dart';
import '../../../app/widgets/gici_card.dart';
import '../../../app/widgets/loading_state.dart';
import '../../../app/widgets/status_pill.dart';
import '../../../core/di/injection.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../data/pedagogical_report_repository.dart';

class PedagogicalReportsPage extends StatefulWidget {
  const PedagogicalReportsPage({super.key, required this.childId});

  final UuidValue childId;

  @override
  State<PedagogicalReportsPage> createState() =>
      _PedagogicalReportsPageState();
}

class _PedagogicalReportsPageState extends State<PedagogicalReportsPage> {
  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthCubit>().state;
    final repo = sl<PedagogicalReportRepository>();

    if (!auth.isAuthenticated || auth.organizationId == null) {
      return const Scaffold(body: Center(child: Text('No autorizado')));
    }

    final canManage = auth.isStaffOrAbove;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        title: const Text(
          'Informes pedagógicos',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.go('/children/${widget.childId}'),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      floatingActionButton: canManage
          ? FloatingActionButton(
              onPressed: () async {
                await repo.createReport(
                  childId: widget.childId,
                  reportDate: DateTime.now().toUtc(),
                  title: 'Progreso diario',
                  summary: 'Resumen del progreso en aula',
                  body:
                      'El alumno participo en actividades grupales y sensoriales.',
                  status: 'published',
                  visibility: 'guardian',
                );
                if (mounted) setState(() {});
              },
              backgroundColor: Theme.of(context).colorScheme.primary,
              child:
                  const Icon(Icons.add_circle_outline, color: Colors.white),
            )
          : null,
      body: FutureBuilder<List<PedagogicalReport>>(
        future: repo.listReportsByChild(
          childId: widget.childId,
          page: 0,
          pageSize: 100,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingState(
                message: 'Cargando informes...');
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error al cargar: ${snapshot.error}'),
            );
          }

          final reports = snapshot.data ?? const <PedagogicalReport>[];
          if (reports.isEmpty) {
            return const EmptyState(
              icon: Icons.article_outlined,
              message: 'No hay informes pedagógicos todavía.',
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
            itemCount: reports.length,
            itemBuilder: (context, index) {
              final report = reports[index];
              return _ReportCard(
                report: report,
                onTap: () => context
                    .go('/reports/${widget.childId}/${report.id}'),
              );
            },
          );
        },
      ),
    );
  }
}

class _ReportCard extends StatelessWidget {
  const _ReportCard({required this.report, this.onTap});

  final PedagogicalReport report;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final dateStr =
        report.reportDate.toIso8601String().substring(0, 10);

    return GiciCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  report.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
              ),
              _statusPill(report.status),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            report.summary,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.calendar_today,
                  size: 13, color: Colors.grey.shade400),
              const SizedBox(width: 4),
              Text(
                dateStr,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade400,
                ),
              ),
              const SizedBox(width: 12),
              StatusPill(
                label: _visibilityLabel(report.visibility),
                color: Colors.blue,
                small: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statusPill(String status) {
    switch (status) {
      case 'published':
        return StatusPill.active();
      case 'draft':
        return StatusPill.pending();
      default:
        return StatusPill(label: status, small: true);
    }
  }

  String _visibilityLabel(String visibility) {
    switch (visibility) {
      case 'guardian':
        return 'Familias';
      case 'staff':
        return 'Personal';
      case 'all':
        return 'Todos';
      default:
        return visibility;
    }
  }
}
