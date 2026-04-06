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
import '../cubit/galleries_cubit.dart';
import '../data/gallery_repository.dart';

class GalleriesPage extends StatelessWidget {
  const GalleriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GalleriesCubit(sl<GalleryRepository>())..load(),
      child: const _GalleriesView(),
    );
  }
}

class _GalleriesView extends StatelessWidget {
  const _GalleriesView();

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthCubit>().state;
    final canManage = auth.isStaffOrAbove;

    return BlocBuilder<GalleriesCubit, GalleriesState>(
      builder: (context, state) {
        // If a gallery is selected, show the detail view
        if (state.selectedGalleryId != null) {
          final gallery = state.galleries
              .where((g) => g.id == state.selectedGalleryId)
              .firstOrNull;

          return _GalleryDetailView(
            gallery: gallery,
            items: state.selectedGalleryItems,
            isLoading: state.status == GalleriesStatus.loading,
          );
        }

        // Gallery list view
        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F7),
          appBar: AppBar(
            title: const Text(
              'Galerias',
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
                  onPressed: () => _showCreateDialog(context),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: const Icon(Icons.add_photo_alternate,
                      color: Colors.white),
                )
              : null,
          body: () {
            if (state.status == GalleriesStatus.loading) {
              return const LoadingState(
                message: 'Cargando galerias...',
              );
            }
            if (state.status == GalleriesStatus.error) {
              return ErrorState(
                message: state.errorMessage ??
                    'Error al cargar galerias',
                onRetry: () =>
                    context.read<GalleriesCubit>().load(),
              );
            }
            if (state.galleries.isEmpty) {
              return EmptyState(
                icon: Icons.photo_library_outlined,
                message: 'No hay galerias',
                action: canManage
                    ? FilledButton.icon(
                        onPressed: () =>
                            _showCreateDialog(context),
                        icon: const Icon(Icons.add),
                        label: const Text('Crear galeria'),
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
              onRefresh: () =>
                  context.read<GalleriesCubit>().load(),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount =
                      constraints.maxWidth > 600 ? 3 : 2;
                  return GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.78,
                    ),
                    itemCount: state.galleries.length,
                    itemBuilder: (context, index) {
                      final gallery = state.galleries[index];
                      return _GalleryCard(gallery: gallery);
                    },
                  );
                },
              ),
            );
          }(),
        );
      },
    );
  }

  void _showCreateDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    String audienceType = 'organization';

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (dialogContext, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: const Text(
                'Nueva galeria',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: 'Titulo *',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Descripcion',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: audienceType,
                    decoration: InputDecoration(
                      labelText: 'Audiencia',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'organization',
                        child: Text('Organizacion'),
                      ),
                      DropdownMenuItem(
                        value: 'classroom',
                        child: Text('Aula'),
                      ),
                      DropdownMenuItem(
                        value: 'child',
                        child: Text('Alumno'),
                      ),
                    ],
                    onChanged: (v) {
                      if (v != null) {
                        setDialogState(() => audienceType = v);
                      }
                    },
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
                    context.read<GalleriesCubit>().createGallery(
                          title: title,
                          description:
                              descriptionController.text.trim().isEmpty
                                  ? null
                                  : descriptionController.text.trim(),
                          audienceType: audienceType,
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
      },
    );
  }
}

class _GalleryCard extends StatelessWidget {
  const _GalleryCard({required this.gallery});

  final dynamic gallery;

  @override
  Widget build(BuildContext context) {
    final (audienceLabel, audienceColor) = switch (gallery.audienceType as String) {
      'organization' => ('Todos', Colors.blue),
      'classroom' => ('Aula', Colors.orange),
      'child' => ('Alumno', Colors.purple),
      _ => (gallery.audienceType as String, Colors.grey),
    };

    // Generate a color from title hash
    final colors = [
      const Color(0xFFE3F2FD),
      const Color(0xFFFCE4EC),
      const Color(0xFFF3E5F5),
      const Color(0xFFE8F5E9),
      const Color(0xFFFFF3E0),
      const Color(0xFFE0F7FA),
    ];
    final colorIndex =
        (gallery.title as String).codeUnits.fold(0, (int a, int b) => a + b) %
            colors.length;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          context.read<GalleriesCubit>().selectGallery(gallery.id!);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade100),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Colored placeholder area
              Container(
                height: 64,
                decoration: BoxDecoration(
                  color: colors[colorIndex],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Icon(
                  Icons.photo_library_outlined,
                  size: 28,
                  color: colors[colorIndex]
                      .withValues(alpha: 1.0)
                      .withRed(
                          (colors[colorIndex].r * 0.6 * 255).toInt()),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        gallery.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          StatusPill(
                            label: audienceLabel,
                            color: audienceColor,
                            small: true,
                          ),
                          const Spacer(),
                          Icon(
                            gallery.isPublished
                                ? Icons.public
                                : Icons.drafts_outlined,
                            size: 14,
                            color: gallery.isPublished
                                ? Colors.green
                                : Colors.grey.shade400,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GalleryDetailView extends StatelessWidget {
  const _GalleryDetailView({
    required this.gallery,
    required this.items,
    required this.isLoading,
  });

  final dynamic gallery;
  final List<dynamic> items;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        title: Text(
          gallery?.title ?? 'Galeria',
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () =>
              context.read<GalleriesCubit>().clearSelection(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: isLoading
          ? const LoadingState(message: 'Cargando fotos...')
          : items.isEmpty
              ? const EmptyState(
                  icon: Icons.photo_outlined,
                  message: 'Esta galeria no tiene fotos',
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Icon(
                            Icons.image_outlined,
                            color: Colors.grey.shade400,
                            size: 32,
                          ),
                          if (item.caption != null &&
                              item.caption!.isNotEmpty)
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.black.withValues(alpha: 0.6),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                                child: Text(
                                  item.caption!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
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
