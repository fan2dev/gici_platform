import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid_value.dart';

import '../../../app/widgets/gici_card.dart';
import '../../../app/widgets/gradient_header.dart';
import '../../../app/widgets/loading_state.dart';
import '../../../app/widgets/status_pill.dart';
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
  State<PedagogicalReportDetailPage> createState() =>
      _PedagogicalReportDetailPageState();
}

class _PedagogicalReportDetailPageState
    extends State<PedagogicalReportDetailPage> {
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
      return const Scaffold(body: Center(child: Text('No autorizado')));
    }

    final canManage = auth.isStaffOrAbove;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      body: FutureBuilder(
        future: repo.getReport(
          reportId: widget.reportId,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingState(message: 'Cargando informe...');
          }
          if (snapshot.hasError || snapshot.data == null) {
            return Center(
              child: Text('Error al cargar: ${snapshot.error}'),
            );
          }

          final report = snapshot.data!;
          _summaryController.text = report.summary;
          _bodyController.text = report.body;

          final dateStr =
              report.reportDate.toIso8601String().substring(0, 10);

          return CustomScrollView(
            slivers: [
              // Gradient header
              SliverToBoxAdapter(
                child: GradientHeader(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top bar
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => context
                                  .go('/reports/${widget.childId}'),
                              icon: const Icon(Icons.arrow_back,
                                  color: Colors.white),
                            ),
                            const Spacer(),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          report.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today,
                                size: 14, color: Colors.white70),
                            const SizedBox(width: 6),
                            Text(
                              dateStr,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(width: 16),
                            StatusPill(
                              label: _statusLabel(report.status),
                              color: Colors.white,
                              small: true,
                            ),
                            const SizedBox(width: 8),
                            StatusPill(
                              label:
                                  _visibilityLabel(report.visibility),
                              color: Colors.white,
                              small: true,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Content
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // Summary section
                    GiciCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Resumen',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: _summaryController,
                            readOnly: !canManage,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              hintText: 'Resumen del informe...',
                            ),
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),

                    // Body section
                    GiciCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Contenido',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: _bodyController,
                            readOnly: !canManage,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              hintText: 'Contenido del informe...',
                              alignLabelWithHint: true,
                            ),
                            maxLines: 8,
                          ),
                        ],
                      ),
                    ),

                    // Save button (staff only)
                    if (canManage) ...[
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 52,
                        child: FilledButton.icon(
                          onPressed: () async {
                            await repo.updateReport(
                              reportId: report.id!,
                              summary:
                                  _summaryController.text.trim(),
                              body: _bodyController.text.trim(),
                            );
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Informe actualizado')),
                            );
                          },
                          icon: const Icon(Icons.save_outlined),
                          label: const Text(
                            'Guardar cambios',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                          style: FilledButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _statusLabel(String status) {
    switch (status) {
      case 'published':
        return 'Publicado';
      case 'draft':
        return 'Borrador';
      default:
        return status;
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
