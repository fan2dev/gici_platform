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

abstract class PedagogicalReport implements _i1.SerializableModel {
  PedagogicalReport._({
    this.id,
    required this.organizationId,
    required this.childId,
    required this.reportDate,
    required this.title,
    required this.summary,
    required this.body,
    required this.status,
    required this.visibility,
    required this.createdByUserId,
    this.updatedByUserId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory PedagogicalReport({
    int? id,
    required int organizationId,
    required int childId,
    required DateTime reportDate,
    required String title,
    required String summary,
    required String body,
    required String status,
    required String visibility,
    required int createdByUserId,
    int? updatedByUserId,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) = _PedagogicalReportImpl;

  factory PedagogicalReport.fromJson(Map<String, dynamic> jsonSerialization) {
    return PedagogicalReport(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      childId: jsonSerialization['childId'] as int,
      reportDate:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['reportDate']),
      title: jsonSerialization['title'] as String,
      summary: jsonSerialization['summary'] as String,
      body: jsonSerialization['body'] as String,
      status: jsonSerialization['status'] as String,
      visibility: jsonSerialization['visibility'] as String,
      createdByUserId: jsonSerialization['createdByUserId'] as int,
      updatedByUserId: jsonSerialization['updatedByUserId'] as int?,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      deletedAt: jsonSerialization['deletedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['deletedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int organizationId;

  int childId;

  DateTime reportDate;

  String title;

  String summary;

  String body;

  String status;

  String visibility;

  int createdByUserId;

  int? updatedByUserId;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime? deletedAt;

  /// Returns a shallow copy of this [PedagogicalReport]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PedagogicalReport copyWith({
    int? id,
    int? organizationId,
    int? childId,
    DateTime? reportDate,
    String? title,
    String? summary,
    String? body,
    String? status,
    String? visibility,
    int? createdByUserId,
    int? updatedByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'organizationId': organizationId,
      'childId': childId,
      'reportDate': reportDate.toJson(),
      'title': title,
      'summary': summary,
      'body': body,
      'status': status,
      'visibility': visibility,
      'createdByUserId': createdByUserId,
      if (updatedByUserId != null) 'updatedByUserId': updatedByUserId,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (deletedAt != null) 'deletedAt': deletedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PedagogicalReportImpl extends PedagogicalReport {
  _PedagogicalReportImpl({
    int? id,
    required int organizationId,
    required int childId,
    required DateTime reportDate,
    required String title,
    required String summary,
    required String body,
    required String status,
    required String visibility,
    required int createdByUserId,
    int? updatedByUserId,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          childId: childId,
          reportDate: reportDate,
          title: title,
          summary: summary,
          body: body,
          status: status,
          visibility: visibility,
          createdByUserId: createdByUserId,
          updatedByUserId: updatedByUserId,
          createdAt: createdAt,
          updatedAt: updatedAt,
          deletedAt: deletedAt,
        );

  /// Returns a shallow copy of this [PedagogicalReport]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PedagogicalReport copyWith({
    Object? id = _Undefined,
    int? organizationId,
    int? childId,
    DateTime? reportDate,
    String? title,
    String? summary,
    String? body,
    String? status,
    String? visibility,
    int? createdByUserId,
    Object? updatedByUserId = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? deletedAt = _Undefined,
  }) {
    return PedagogicalReport(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      childId: childId ?? this.childId,
      reportDate: reportDate ?? this.reportDate,
      title: title ?? this.title,
      summary: summary ?? this.summary,
      body: body ?? this.body,
      status: status ?? this.status,
      visibility: visibility ?? this.visibility,
      createdByUserId: createdByUserId ?? this.createdByUserId,
      updatedByUserId:
          updatedByUserId is int? ? updatedByUserId : this.updatedByUserId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt is DateTime? ? deletedAt : this.deletedAt,
    );
  }
}
