import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/injection.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../data/data_change_request_repository.dart';

class DataChangeRequestsPage extends StatefulWidget {
  const DataChangeRequestsPage({super.key});

  @override
  State<DataChangeRequestsPage> createState() => _DataChangeRequestsPageState();
}

class _DataChangeRequestsPageState extends State<DataChangeRequestsPage> {
  final _payloadController = TextEditingController();
  final _requestTypeController = TextEditingController(
    text: 'child_profile_change',
  );

  @override
  void dispose() {
    _payloadController.dispose();
    _requestTypeController.dispose();
    super.dispose();
  }

  bool _canReview(AppRole? role) {
    return role == AppRole.organizationAdmin ||
        role == AppRole.platformSuperAdmin ||
        role == AppRole.staff;
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthCubit>().state;
    final repo = sl<DataChangeRequestRepository>();

    if (!auth.isAuthenticated ||
        auth.organizationId == null ||
        auth.actorId == null) {
      return const Scaffold(body: Center(child: Text('Unauthorized')));
    }

    final canReview = _canReview(auth.role);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Change Requests'),
        leading: IconButton(
          onPressed: () => context.go('/dashboard'),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: FutureBuilder<List<DataChangeRequest>>(
        future: canReview
            ? repo.listRequestsForReview(
                organizationId: auth.organizationId!,
                actorId: auth.actorId!,
                page: 0,
                pageSize: 100,
              )
            : repo.myRequests(
                organizationId: auth.organizationId!,
                actorId: auth.actorId!,
                page: 0,
                pageSize: 100,
              ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Request load error: ${snapshot.error}'));
          }

          final requests = snapshot.data ?? const <DataChangeRequest>[];
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (!canReview)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        TextField(
                          controller: _requestTypeController,
                          decoration: const InputDecoration(
                            labelText: 'Request type',
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _payloadController,
                          decoration: const InputDecoration(
                            labelText: 'Requested change details',
                          ),
                          minLines: 2,
                          maxLines: 4,
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: FilledButton(
                            onPressed: () async {
                              final payload = _payloadController.text.trim();
                              final type = _requestTypeController.text.trim();
                              if (payload.isEmpty || type.isEmpty) return;
                              await repo.createRequest(
                                organizationId: auth.organizationId!,
                                actorId: auth.actorId!,
                                requestType: type,
                                requestPayload: payload,
                              );
                              _payloadController.clear();
                              if (mounted) setState(() {});
                            },
                            child: const Text('Submit request'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              if (!canReview) const SizedBox(height: 12),
              if (requests.isEmpty)
                const Text('No requests found.')
              else
                ...requests.map(
                  (request) => ListTile(
                    title: Text(request.requestType),
                    subtitle: Text(request.requestPayload),
                    trailing: canReview
                        ? Wrap(
                            spacing: 6,
                            children: [
                              Text(request.status),
                              if (request.status == 'pending')
                                IconButton(
                                  icon: const Icon(Icons.check),
                                  onPressed: () async {
                                    await repo.updateRequestStatus(
                                      organizationId: auth.organizationId!,
                                      actorId: auth.actorId!,
                                      requestId: request.id!,
                                      status: 'approved',
                                      resolutionNote: 'Approved by staff',
                                    );
                                    if (mounted) setState(() {});
                                  },
                                ),
                              if (request.status == 'pending')
                                IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () async {
                                    await repo.updateRequestStatus(
                                      organizationId: auth.organizationId!,
                                      actorId: auth.actorId!,
                                      requestId: request.id!,
                                      status: 'rejected',
                                      resolutionNote: 'Rejected by staff',
                                    );
                                    if (mounted) setState(() {});
                                  },
                                ),
                            ],
                          )
                        : Text(request.status),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
