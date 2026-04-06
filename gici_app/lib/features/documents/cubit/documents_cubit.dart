import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';

import '../data/document_repository.dart';

enum DocumentsStatus { initial, loading, loaded, error }

class DocumentsState extends Equatable {
  const DocumentsState({
    this.status = DocumentsStatus.initial,
    this.orgDocs = const [],
    this.childDocs = const [],
    this.selectedChildId,
    this.errorMessage,
  });

  final DocumentsStatus status;
  final List<OrganizationDocument> orgDocs;
  final List<ChildDocument> childDocs;
  final UuidValue? selectedChildId;
  final String? errorMessage;

  DocumentsState copyWith({
    DocumentsStatus? status,
    List<OrganizationDocument>? orgDocs,
    List<ChildDocument>? childDocs,
    UuidValue? selectedChildId,
    String? errorMessage,
  }) {
    return DocumentsState(
      status: status ?? this.status,
      orgDocs: orgDocs ?? this.orgDocs,
      childDocs: childDocs ?? this.childDocs,
      selectedChildId: selectedChildId ?? this.selectedChildId,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        orgDocs,
        childDocs,
        selectedChildId,
        errorMessage,
      ];
}

class DocumentsCubit extends Cubit<DocumentsState> {
  DocumentsCubit(this._repository) : super(const DocumentsState());

  final DocumentRepository _repository;

  Future<void> loadOrgDocs() async {
    emit(state.copyWith(status: DocumentsStatus.loading));

    try {
      final docs = await _repository.listOrganizationDocuments(
        page: 0,
        pageSize: 100,
      );
      emit(state.copyWith(
        status: DocumentsStatus.loaded,
        orgDocs: docs,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: DocumentsStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> loadChildDocs(UuidValue childId) async {
    emit(state.copyWith(status: DocumentsStatus.loading));

    try {
      final docs = await _repository.listChildDocuments(
        childId: childId,
        page: 0,
        pageSize: 100,
      );
      emit(state.copyWith(
        status: DocumentsStatus.loaded,
        childDocs: docs,
        selectedChildId: childId,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: DocumentsStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> createDoc({
    required String title,
    String? description,
    String visibility = 'all',
    required String originalName,
    String mimeType = 'application/octet-stream',
    required int sizeBytes,
    String? storagePath,
  }) async {
    try {
      await _repository.createOrganizationDocument(
        title: title,
        description: description,
        visibility: visibility,
        originalName: originalName,
        mimeType: mimeType,
        sizeBytes: sizeBytes,
        storagePath: storagePath,
      );
      await loadOrgDocs();
    } catch (e) {
      emit(state.copyWith(
        status: DocumentsStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<String> resolveDownloadUrl(UuidValue fileAssetId) {
    return _repository.resolveFileDownloadUrl(fileAssetId: fileAssetId);
  }
}
