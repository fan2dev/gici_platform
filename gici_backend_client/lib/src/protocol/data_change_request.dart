/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class DataChangeRequest implements _i1.SerializableModel {
  DataChangeRequest._({
    this.id,
    required this.organizationId,
    required this.requesterUserId,
    this.targetChildId,
    required this.requestType,
    required this.requestPayload,
    required this.status,
    this.resolutionNote,
    this.reviewedByUserId,
    this.reviewedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DataChangeRequest({
    int? id,
    required int organizationId,
    required int requesterUserId,
    int? targetChildId,
    required String requestType,
    required String requestPayload,
    required String status,
    String? resolutionNote,
    int? reviewedByUserId,
    DateTime? reviewedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _DataChangeRequestImpl;

  factory DataChangeRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return DataChangeRequest(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      requesterUserId: jsonSerialization['requesterUserId'] as int,
      targetChildId: jsonSerialization['targetChildId'] as int?,
      requestType: jsonSerialization['requestType'] as String,
      requestPayload: jsonSerialization['requestPayload'] as String,
      status: jsonSerialization['status'] as String,
      resolutionNote: jsonSerialization['resolutionNote'] as String?,
      reviewedByUserId: jsonSerialization['reviewedByUserId'] as int?,
      reviewedAt: jsonSerialization['reviewedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['reviewedAt']),
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int organizationId;

  int requesterUserId;

  int? targetChildId;

  String requestType;

  String requestPayload;

  String status;

  String? resolutionNote;

  int? reviewedByUserId;

  DateTime? reviewedAt;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [DataChangeRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DataChangeRequest copyWith({
    int? id,
    int? organizationId,
    int? requesterUserId,
    int? targetChildId,
    String? requestType,
    String? requestPayload,
    String? status,
    String? resolutionNote,
    int? reviewedByUserId,
    DateTime? reviewedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'organizationId': organizationId,
      'requesterUserId': requesterUserId,
      if (targetChildId != null) 'targetChildId': targetChildId,
      'requestType': requestType,
      'requestPayload': requestPayload,
      'status': status,
      if (resolutionNote != null) 'resolutionNote': resolutionNote,
      if (reviewedByUserId != null) 'reviewedByUserId': reviewedByUserId,
      if (reviewedAt != null) 'reviewedAt': reviewedAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DataChangeRequestImpl extends DataChangeRequest {
  _DataChangeRequestImpl({
    int? id,
    required int organizationId,
    required int requesterUserId,
    int? targetChildId,
    required String requestType,
    required String requestPayload,
    required String status,
    String? resolutionNote,
    int? reviewedByUserId,
    DateTime? reviewedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          requesterUserId: requesterUserId,
          targetChildId: targetChildId,
          requestType: requestType,
          requestPayload: requestPayload,
          status: status,
          resolutionNote: resolutionNote,
          reviewedByUserId: reviewedByUserId,
          reviewedAt: reviewedAt,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [DataChangeRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DataChangeRequest copyWith({
    Object? id = _Undefined,
    int? organizationId,
    int? requesterUserId,
    Object? targetChildId = _Undefined,
    String? requestType,
    String? requestPayload,
    String? status,
    Object? resolutionNote = _Undefined,
    Object? reviewedByUserId = _Undefined,
    Object? reviewedAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DataChangeRequest(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      requesterUserId: requesterUserId ?? this.requesterUserId,
      targetChildId: targetChildId is int? ? targetChildId : this.targetChildId,
      requestType: requestType ?? this.requestType,
      requestPayload: requestPayload ?? this.requestPayload,
      status: status ?? this.status,
      resolutionNote:
          resolutionNote is String? ? resolutionNote : this.resolutionNote,
      reviewedByUserId:
          reviewedByUserId is int? ? reviewedByUserId : this.reviewedByUserId,
      reviewedAt: reviewedAt is DateTime? ? reviewedAt : this.reviewedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
