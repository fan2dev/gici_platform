import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/widgets/empty_state.dart';
import '../../../app/widgets/error_state.dart';
import '../../../app/widgets/loading_state.dart';
import '../../../core/di/injection.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../cubit/data_change_requests_cubit.dart';
import '../data/data_change_request_repository.dart';

class DataChangeRequestsPage extends StatelessWidget {
  const DataChangeRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthCubit>().state;
    final isStaff = auth.isStaffOrAbove;

    return BlocProvider(
      create: (_) {
        final cubit = DataChangeRequestsCubit(
          sl<DataChangeRequestRepository>(),
        );
        if (isStaff) {
          cubit.loadForReview();
        } else {
          cubit.loadMyRequests();
        }
        return cubit;
      },
      child: const _DataChangeRequestsView(),
    );
  }
}

class _DataChangeRequestsView extends StatelessWidget {
  const _DataChangeRequestsView();

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthCubit>().state;
    final isStaff = auth.isStaffOrAbove;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isStaff
              ? 'Solicitudes de cambio'
              : 'Mis solicitudes',
        ),
        leading: IconButton(
          onPressed: () => context.go('/dashboard'),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      floatingActionButton: !isStaff
          ? FloatingActionButton.extended(
              onPressed: () => _showCreateRequestForm(context),
              icon: const Icon(Icons.add),
              label: const Text('Nueva solicitud'),
            )
          : null,
      body: BlocBuilder<DataChangeRequestsCubit,
          DataChangeRequestsState>(
        builder: (context, state) {
          if (state.status == DataChangeRequestsStatus.loading) {
            return const LoadingState(
              message: 'Cargando solicitudes...',
            );
          }
          if (state.status == DataChangeRequestsStatus.error) {
            return ErrorState(
              message: state.errorMessage ??
                  'Error al cargar solicitudes',
              onRetry: () {
                if (isStaff) {
                  context
                      .read<DataChangeRequestsCubit>()
                      .loadForReview();
                } else {
                  context
                      .read<DataChangeRequestsCubit>()
                      .loadMyRequests();
                }
              },
            );
          }
          if (state.requests.isEmpty) {
            return EmptyState(
              icon: Icons.swap_horiz,
              message: isStaff
                  ? 'No hay solicitudes pendientes de revision'
                  : 'No has enviado ninguna solicitud',
              action: !isStaff
                  ? FilledButton.icon(
                      onPressed: () =>
                          _showCreateRequestForm(context),
                      icon: const Icon(Icons.add),
                      label: const Text('Nueva solicitud'),
                    )
                  : null,
            );
          }

          return RefreshIndicator(
            onRefresh: () {
              if (isStaff) {
                return context
                    .read<DataChangeRequestsCubit>()
                    .loadForReview();
              } else {
                return context
                    .read<DataChangeRequestsCubit>()
                    .loadMyRequests();
              }
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.requests.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final request = state.requests[index];
                if (isStaff) {
                  return _StaffRequestCard(request: request);
                } else {
                  return _GuardianRequestCard(request: request);
                }
              },
            ),
          );
        },
      ),
    );
  }

  void _showCreateRequestForm(BuildContext context) {
    final requestTypeController = TextEditingController(
      text: 'child_profile_change',
    );
    final payloadController = TextEditingController();

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            bottom:
                MediaQuery.of(sheetContext).viewInsets.bottom,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Text(
                  'Nueva solicitud de cambio',
                  style:
                      Theme.of(sheetContext).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: requestTypeController.text,
                  decoration: const InputDecoration(
                    labelText: 'Tipo de solicitud',
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'child_profile_change',
                      child: Text('Cambio en perfil del alumno'),
                    ),
                    DropdownMenuItem(
                      value: 'contact_update',
                      child: Text('Actualizacion de contacto'),
                    ),
                    DropdownMenuItem(
                      value: 'medical_update',
                      child: Text('Actualizacion medica'),
                    ),
                    DropdownMenuItem(
                      value: 'other',
                      child: Text('Otro'),
                    ),
                  ],
                  onChanged: (v) {
                    if (v != null) requestTypeController.text = v;
                  },
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: payloadController,
                  decoration: const InputDecoration(
                    labelText: 'Detalle del cambio solicitado *',
                    hintText:
                        'Describe el cambio que necesitas...',
                  ),
                  minLines: 3,
                  maxLines: 5,
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () {
                    final payload =
                        payloadController.text.trim();
                    if (payload.isEmpty) return;
                    context
                        .read<DataChangeRequestsCubit>()
                        .createRequest(
                          requestType:
                              requestTypeController.text,
                          requestPayload: payload,
                        );
                    Navigator.of(sheetContext).pop();
                  },
                  child: const Text('Enviar solicitud'),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _GuardianRequestCard extends StatelessWidget {
  const _GuardianRequestCard({required this.request});

  final dynamic request;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    _requestTypeLabel(request.requestType),
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                _StatusChip(status: request.status),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              request.requestPayload,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (request.resolutionNote != null &&
                request.resolutionNote!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Nota: ${request.resolutionNote}',
                  style:
                      Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _StaffRequestCard extends StatelessWidget {
  const _StaffRequestCard({required this.request});

  final dynamic request;

  @override
  Widget build(BuildContext context) {
    final isPending = request.status == 'pending';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    _requestTypeLabel(request.requestType),
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                _StatusChip(status: request.status),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              request.requestPayload,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (isPending) ...[
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton.icon(
                    onPressed: () =>
                        _showResolveDialog(context, 'rejected'),
                    icon: const Icon(Icons.close, size: 18),
                    label: const Text('Rechazar'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor:
                          Theme.of(context).colorScheme.error,
                    ),
                  ),
                  const SizedBox(width: 8),
                  FilledButton.icon(
                    onPressed: () =>
                        _showResolveDialog(context, 'approved'),
                    icon: const Icon(Icons.check, size: 18),
                    label: const Text('Aprobar'),
                  ),
                ],
              ),
            ],
            if (request.resolutionNote != null &&
                request.resolutionNote!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Nota: ${request.resolutionNote}',
                  style:
                      Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showResolveDialog(BuildContext context, String status) {
    final noteController = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            status == 'approved'
                ? 'Aprobar solicitud'
                : 'Rechazar solicitud',
          ),
          content: TextField(
            controller: noteController,
            decoration: const InputDecoration(
              labelText: 'Nota de resolucion (opcional)',
            ),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () {
                context
                    .read<DataChangeRequestsCubit>()
                    .updateStatus(
                      requestId: request.id!,
                      status: status,
                      resolutionNote:
                          noteController.text.trim().isEmpty
                              ? null
                              : noteController.text.trim(),
                    );
                Navigator.of(dialogContext).pop();
              },
              child: Text(
                status == 'approved' ? 'Aprobar' : 'Rechazar',
              ),
            ),
          ],
        );
      },
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      'pending' => ('Pendiente', Colors.orange),
      'approved' => ('Aprobada', Colors.green),
      'rejected' => ('Rechazada', Colors.red),
      _ => (status, Colors.grey),
    };

    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}

String _requestTypeLabel(String type) {
  switch (type) {
    case 'child_profile_change':
      return 'Cambio en perfil';
    case 'contact_update':
      return 'Actualizacion de contacto';
    case 'medical_update':
      return 'Actualizacion medica';
    default:
      return type;
  }
}
