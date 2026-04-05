import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/injection.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../data/gallery_repository.dart';

class GalleriesPage extends StatefulWidget {
  const GalleriesPage({super.key});

  @override
  State<GalleriesPage> createState() => _GalleriesPageState();
}

class _GalleriesPageState extends State<GalleriesPage> {
  final _titleController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthCubit>().state;
    final repo = sl<GalleryRepository>();

    if (!auth.isAuthenticated || auth.organizationId == null) {
      return const Scaffold(body: Center(child: Text('Unauthorized')));
    }

    final canManage = auth.isStaffOrAbove;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Galleries'),
        leading: IconButton(
          onPressed: () => context.go('/dashboard'),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: FutureBuilder<List<Gallery>>(
        future: repo.listGalleries(
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

          final galleries = snapshot.data ?? const <Gallery>[];
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
                          labelText: 'New gallery title',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    FilledButton(
                      onPressed: () async {
                        final title = _titleController.text.trim();
                        if (title.isEmpty) return;
                        await repo.createGallery(
                          title: title,
                          description: 'Created from app UI',
                        );
                        _titleController.clear();
                        if (mounted) setState(() {});
                      },
                      child: const Text('Create'),
                    ),
                  ],
                ),
              if (canManage) const SizedBox(height: 12),
              if (galleries.isEmpty)
                const Text('No galleries yet.')
              else
                ...galleries.map(
                  (gallery) => ExpansionTile(
                    title: Text(gallery.title),
                    subtitle: Text(
                      '${gallery.audienceType} • ${gallery.isPublished ? 'published' : 'draft'}',
                    ),
                    children: [
                      FutureBuilder<List<GalleryItem>>(
                        future: repo.listGalleryItems(
                          galleryId: gallery.id!,
                          page: 0,
                          pageSize: 50,
                        ),
                        builder: (context, itemSnapshot) {
                          final items =
                              itemSnapshot.data ?? const <GalleryItem>[];
                          if (itemSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Padding(
                              padding: EdgeInsets.all(12),
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (items.isEmpty) {
                            return const Padding(
                              padding: EdgeInsets.all(12),
                              child: Text('No gallery items yet.'),
                            );
                          }
                          return Column(
                            children: items
                                .map(
                                  (item) => ListTile(
                                    title: Text(
                                      item.caption ?? 'Item #${item.id}',
                                    ),
                                    subtitle: Text(
                                      'File asset: ${item.fileAssetId}',
                                    ),
                                  ),
                                )
                                .toList(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
