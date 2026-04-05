import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/injection.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../data/document_repository.dart';

class DocumentsPage extends StatefulWidget {
  const DocumentsPage({super.key});

  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage> {
  final _titleController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthCubit>().state;
    final repo = sl<DocumentRepository>();

    if (!auth.isAuthenticated || auth.organizationId == null) {
      return const Scaffold(body: Center(child: Text('Unauthorized')));
    }

    final canManage = auth.isStaffOrAbove;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Documents'),
        leading: IconButton(
          onPressed: () => context.go('/dashboard'),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: FutureBuilder<List<OrganizationDocument>>(
        future: repo.listOrganizationDocuments(
          page: 0,
          pageSize: 100,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Load error: ${snapshot.error}'));
          }

          final docs = snapshot.data ?? const <OrganizationDocument>[];
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (canManage)
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          labelText: 'New document title',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    FilledButton(
                      onPressed: () async {
                        final title = _titleController.text.trim();
                        if (title.isEmpty) return;
                        await repo.createOrganizationDocument(
                          title: title,
                          description: 'Created from app UI',
                          visibility: 'all',
                          originalName: '$title.txt',
                          sizeBytes: title.length,
                          mimeType: 'text/plain',
                        );
                        _titleController.clear();
                        if (mounted) setState(() {});
                      },
                      child: const Text('Create'),
                    ),
                  ],
                ),
              if (canManage) const SizedBox(height: 12),
              if (docs.isEmpty)
                const Text('No organization documents yet.')
              else
                ...docs.map(
                  (doc) => ListTile(
                    title: Text(doc.title),
                    subtitle: Text(
                      'Visibility: ${doc.visibility} • File: ${doc.fileAssetId}',
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.link),
                      onPressed: () async {
                        final messenger = ScaffoldMessenger.of(context);
                        final url = await repo.resolveFileDownloadUrl(
                          fileAssetId: doc.fileAssetId,
                        );
                        if (!mounted) return;
                        messenger.showSnackBar(
                          SnackBar(content: Text('Resolved URL: $url')),
                        );
                      },
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
