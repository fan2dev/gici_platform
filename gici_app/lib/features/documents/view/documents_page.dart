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
import '../../children/cubit/children_list_cubit.dart';
import '../../children/data/child_repository.dart';
import '../cubit/documents_cubit.dart';
import '../data/document_repository.dart';

class DocumentsPage extends StatelessWidget {
  const DocumentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              DocumentsCubit(sl<DocumentRepository>())..loadOrgDocs(),
        ),
        BlocProvider(
          create: (_) =>
              ChildrenListCubit(sl<ChildRepository>())..loadChildren(),
        ),
      ],
      child: const _DocumentsView(),
    );
  }
}

class _DocumentsView extends StatefulWidget {
  const _DocumentsView();

  @override
  State<_DocumentsView> createState() => _DocumentsViewState();
}

class _DocumentsViewState extends State<_DocumentsView> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthCubit>().state;
    final canManage = auth.isStaffOrAbove;
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        title: const Text(
          'Documentos',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.go('/dashboard'),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      floatingActionButton: canManage
          ? FloatingActionButton(
              onPressed: () => _showUploadDialog(context),
              backgroundColor: primary,
              child: const Icon(Icons.upload_file, color: Colors.white),
            )
          : null,
      body: Column(
        children: [
          // Pill-style tabs
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Row(
              children: [
                _PillTab(
                  label: 'Centro',
                  isSelected: _selectedTab == 0,
                  onTap: () => setState(() => _selectedTab = 0),
                ),
                const SizedBox(width: 8),
                _PillTab(
                  label: 'Por alumno',
                  isSelected: _selectedTab == 1,
                  onTap: () => setState(() => _selectedTab = 1),
                ),
              ],
            ),
          ),
          Expanded(
            child: _selectedTab == 0
                ? _OrgDocsTab(canManage: canManage)
                : const _ChildDocsTab(),
          ),
        ],
      ),
    );
  }

  void _showUploadDialog(BuildContext context) {
    final titleController = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text(
            'Nuevo documento',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Titulo del documento',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'La subida de archivos se integrara con el selector de archivos del dispositivo.',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () {
                final title = titleController.text.trim();
                if (title.isEmpty) return;
                context.read<DocumentsCubit>().createDoc(
                      title: title,
                      description: 'Subido desde la app',
                      visibility: 'all',
                      originalName: '$title.pdf',
                      sizeBytes: 0,
                    );
                Navigator.of(dialogContext).pop();
              },
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: const Text('Crear'),
            ),
          ],
        );
      },
    );
  }
}

class _PillTab extends StatelessWidget {
  const _PillTab({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? primary : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: isSelected ? Colors.white : Colors.grey.shade600,
          ),
        ),
      ),
    );
  }
}

class _OrgDocsTab extends StatelessWidget {
  const _OrgDocsTab({required this.canManage});

  final bool canManage;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentsCubit, DocumentsState>(
      builder: (context, state) {
        if (state.status == DocumentsStatus.loading) {
          return const LoadingState(message: 'Cargando documentos...');
        }
        if (state.status == DocumentsStatus.error) {
          return ErrorState(
            message:
                state.errorMessage ?? 'Error al cargar documentos',
            onRetry: () => context.read<DocumentsCubit>().loadOrgDocs(),
          );
        }
        if (state.orgDocs.isEmpty) {
          return const EmptyState(
            icon: Icons.folder_open,
            message: 'No hay documentos del centro',
          );
        }

        return RefreshIndicator(
          onRefresh: () => context.read<DocumentsCubit>().loadOrgDocs(),
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
            itemCount: state.orgDocs.length,
            itemBuilder: (context, index) {
              final doc = state.orgDocs[index];
              return _DocumentCard(doc: doc);
            },
          ),
        );
      },
    );
  }
}

class _DocumentCard extends StatelessWidget {
  const _DocumentCard({required this.doc});

  final dynamic doc;

  @override
  Widget build(BuildContext context) {
    final isPublic = doc.visibility == 'all';

    return GiciCard(
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.picture_as_pdf,
              color: Colors.red.shade400,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doc.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    StatusPill(
                      label: isPublic ? 'Publico' : doc.visibility,
                      color: isPublic ? Colors.green : Colors.orange,
                      small: true,
                    ),
                    const SizedBox(width: 8),
                    if (doc.description != null)
                      Expanded(
                        child: Text(
                          doc.description!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.download, color: Colors.grey.shade400, size: 20),
            onPressed: () async {
              final messenger = ScaffoldMessenger.of(context);
              try {
                final url = await context
                    .read<DocumentsCubit>()
                    .resolveDownloadUrl(doc.fileAssetId);
                messenger.showSnackBar(
                  SnackBar(content: Text('URL: $url')),
                );
              } catch (e) {
                messenger.showSnackBar(
                  SnackBar(content: Text('Error: $e')),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class _ChildDocsTab extends StatelessWidget {
  const _ChildDocsTab();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChildrenListCubit, ChildrenListState>(
      builder: (context, childrenState) {
        if (childrenState.status == ChildrenListStatus.loading) {
          return const LoadingState(message: 'Cargando alumnos...');
        }
        if (childrenState.children.isEmpty) {
          return const EmptyState(
            icon: Icons.child_care,
            message: 'No hay alumnos registrados',
          );
        }

        return BlocBuilder<DocumentsCubit, DocumentsState>(
          builder: (context, docState) {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                GiciCard(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Seleccionar alumno',
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    value: docState.selectedChildId?.toString(),
                    items: childrenState.children
                        .map(
                          (c) => DropdownMenuItem(
                            value: c.id.toString(),
                            child: Text(
                              '${c.firstName} ${c.lastName}',
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (v) {
                      if (v != null) {
                        final child = childrenState.children
                            .firstWhere((c) => c.id.toString() == v);
                        context
                            .read<DocumentsCubit>()
                            .loadChildDocs(child.id!);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 8),
                if (docState.selectedChildId == null)
                  const EmptyState(
                    icon: Icons.person_search,
                    message:
                        'Selecciona un alumno para ver sus documentos',
                  )
                else if (docState.status == DocumentsStatus.loading)
                  const LoadingState()
                else if (docState.childDocs.isEmpty)
                  const EmptyState(
                    icon: Icons.folder_open,
                    message:
                        'No hay documentos para este alumno',
                  )
                else
                  ...docState.childDocs.map(
                    (doc) => _DocumentCard(doc: doc),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
