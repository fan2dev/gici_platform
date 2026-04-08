import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/widgets/empty_state.dart';
import '../../../app/widgets/error_state.dart';
import '../../../app/widgets/gici_card.dart';
import '../../../app/widgets/loading_state.dart';
import '../../../app/widgets/status_pill.dart';
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
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        title: Text(
          isStaff ? 'Solicitudes de cambio' : 'Mis solicitudes',
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.go('/dashboard'),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      floatingActionButton: !isStaff
          ? FloatingActionButton(
              onPressed: () => _showCreateRequestForm(context),
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: const Icon(Icons.add, color: Colors.white),
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
                  ? 'No hay solicitudes pendientes de revisión'
                  : 'No has enviado ninguna solicitud',
              action: !isStaff
                  ? FilledButton.icon(
                      onPressed: () =>
                          _showCreateRequestForm(context),
                      icon: const Icon(Icons.add),
                      label: const Text('Nueva solicitud'),
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
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
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
              itemCount: state.requests.length,
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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            bottom:
                MediaQuery.of(sheetContext).viewInsets.bottom,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const Text(
                  'Nueva solicitud de cambio',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: requestTypeController.text,
                  decoration: InputDecoration(
                    labelText: 'Tipo de solicitud',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'child_profile_change',
                      child: Text('Cambio en perfil del alumno'),
                    ),
                    DropdownMenuItem(
                      value: 'contact_update',
                      child: Text('Actualización de contacto'),
                    ),
                    DropdownMenuItem(
                      value: 'medical_update',
                      child: Text('Actualización médica'),
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
                  decoration: InputDecoration(
                    labelText: 'Detalle del cambio solicitado *',
                    hintText:
                        'Describe el cambio que necesitas...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignLabelWithHint: true,
                  ),
                  minLines: 3,
                  maxLines: 5,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  child: FilledButton(
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
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: const Text(
                      'Enviar solicitud',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ),
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
    return GiciCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _RequestTypeBadge(type: request.requestType),
              const Spacer(),
              _statusPill(request.status),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            request.requestPayload,
            style: const TextStyle(fontSize: 14),
          ),
          if (request.resolutionNote != null &&
              request.resolutionNote!.isNotEmpty) ...[
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Nota: ${request.resolutionNote}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          ],
        ],
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

    return GiciCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _RequestTypeBadge(type: request.requestType),
              const Spacer(),
              _statusPill(request.status),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            request.requestPayload,
            style: const TextStyle(fontSize: 14),
          ),
          if (isPending) ...[
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton.icon(
                  onPressed: () =>
                      _showResolveDialog(context, 'rejected'),
                  icon: const Icon(Icons.close, size: 16),
                  label: const Text('Rechazar',
                      style: TextStyle(fontSize: 13)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton.icon(
                  onPressed: () =>
                      _showResolveDialog(context, 'approved'),
                  icon: const Icon(Icons.check, size: 16),
                  label: const Text('Aprobar',
                      style: TextStyle(fontSize: 13)),
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                  ),
                ),
              ],
            ),
          ],
          if (request.resolutionNote != null &&
              request.resolutionNote!.isNotEmpty) ...[
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Nota: ${request.resolutionNote}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _showResolveDialog(BuildContext context, String status) {
    final noteController = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          title: Text(
            status == 'approved'
                ? 'Aprobar solicitud'
                : 'Rechazar solicitud',
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          content: TextField(
            controller: noteController,
            decoration: InputDecoration(
              labelText: 'Nota de resolución (opcional)',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
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
              style: FilledButton.styleFrom(
                backgroundColor:
                    status == 'approved' ? Colors.green : Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
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

class _RequestTypeBadge extends StatelessWidget {
  const _RequestTypeBadge({required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    return StatusPill(
      label: _requestTypeLabel(type),
      color: Theme.of(context).colorScheme.primary,
      small: true,
    );
  }
}

Widget _statusPill(String status) {
  switch (status) {
    case 'pending':
      return StatusPill.pending();
    case 'approved':
      return StatusPill.approved();
    case 'rejected':
      return StatusPill.rejected();
    default:
      return StatusPill(label: status, color: Colors.grey, small: true);
  }
}

String _requestTypeLabel(String type) {
  switch (type) {
    case 'child_profile_change':
      return 'Cambio en perfil';
    case 'contact_update':
      return 'Actualización de contacto';
    case 'medical_update':
      return 'Actualización médica';
    case 'update_contact':
      return 'Actualizar contacto';
    case 'update_medical':
      return 'Info médica';
    case 'update_personal':
      return 'Datos personales';
    case 'delete_data':
      return 'Eliminar datos';
    default:
      return type;
  }
}
