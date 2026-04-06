import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';

import '../data/gallery_repository.dart';

enum GalleriesStatus { initial, loading, loaded, error }

class GalleriesState extends Equatable {
  const GalleriesState({
    this.status = GalleriesStatus.initial,
    this.galleries = const [],
    this.selectedGalleryItems = const [],
    this.selectedGalleryId,
    this.errorMessage,
  });

  final GalleriesStatus status;
  final List<Gallery> galleries;
  final List<GalleryItem> selectedGalleryItems;
  final UuidValue? selectedGalleryId;
  final String? errorMessage;

  GalleriesState copyWith({
    GalleriesStatus? status,
    List<Gallery>? galleries,
    List<GalleryItem>? selectedGalleryItems,
    UuidValue? selectedGalleryId,
    String? errorMessage,
  }) {
    return GalleriesState(
      status: status ?? this.status,
      galleries: galleries ?? this.galleries,
      selectedGalleryItems:
          selectedGalleryItems ?? this.selectedGalleryItems,
      selectedGalleryId: selectedGalleryId ?? this.selectedGalleryId,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        galleries,
        selectedGalleryItems,
        selectedGalleryId,
        errorMessage,
      ];
}

class GalleriesCubit extends Cubit<GalleriesState> {
  GalleriesCubit(this._repository) : super(const GalleriesState());

  final GalleryRepository _repository;

  Future<void> load() async {
    emit(state.copyWith(status: GalleriesStatus.loading));

    try {
      final galleries = await _repository.listGalleries(
        page: 0,
        pageSize: 100,
      );
      emit(state.copyWith(
        status: GalleriesStatus.loaded,
        galleries: galleries,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: GalleriesStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> selectGallery(UuidValue galleryId) async {
    emit(state.copyWith(status: GalleriesStatus.loading));

    try {
      final items = await _repository.listGalleryItems(
        galleryId: galleryId,
        page: 0,
        pageSize: 100,
      );
      emit(state.copyWith(
        status: GalleriesStatus.loaded,
        selectedGalleryItems: items,
        selectedGalleryId: galleryId,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: GalleriesStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> createGallery({
    required String title,
    String? description,
    String audienceType = 'organization',
    UuidValue? audienceClassroomId,
    UuidValue? audienceChildId,
  }) async {
    try {
      await _repository.createGallery(
        title: title,
        description: description,
        audienceType: audienceType,
        audienceClassroomId: audienceClassroomId,
        audienceChildId: audienceChildId,
      );
      await load();
    } catch (e) {
      emit(state.copyWith(
        status: GalleriesStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void clearSelection() {
    emit(state.copyWith(
      selectedGalleryItems: const [],
      selectedGalleryId: null,
    ));
  }
}
