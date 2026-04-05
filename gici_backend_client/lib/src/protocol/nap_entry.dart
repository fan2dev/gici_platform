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

abstract class NapEntry implements _i1.SerializableModel {
  NapEntry._({
    this.id,
    required this.organizationId,
    required this.childId,
    required this.recordedByUserId,
    required this.startedAt,
    this.endedAt,
    this.durationMinutes,
    this.sleepQuality,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NapEntry({
    int? id,
    required int organizationId,
    required int childId,
    required int recordedByUserId,
    required DateTime startedAt,
    DateTime? endedAt,
    int? durationMinutes,
    String? sleepQuality,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _NapEntryImpl;

  factory NapEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return NapEntry(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      childId: jsonSerialization['childId'] as int,
      recordedByUserId: jsonSerialization['recordedByUserId'] as int,
      startedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
      endedAt: jsonSerialization['endedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endedAt']),
      durationMinutes: jsonSerialization['durationMinutes'] as int?,
      sleepQuality: jsonSerialization['sleepQuality'] as String?,
      notes: jsonSerialization['notes'] as String?,
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

  int childId;

  int recordedByUserId;

  DateTime startedAt;

  DateTime? endedAt;

  int? durationMinutes;

  String? sleepQuality;

  String? notes;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [NapEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  NapEntry copyWith({
    int? id,
    int? organizationId,
    int? childId,
    int? recordedByUserId,
    DateTime? startedAt,
    DateTime? endedAt,
    int? durationMinutes,
    String? sleepQuality,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'organizationId': organizationId,
      'childId': childId,
      'recordedByUserId': recordedByUserId,
      'startedAt': startedAt.toJson(),
      if (endedAt != null) 'endedAt': endedAt?.toJson(),
      if (durationMinutes != null) 'durationMinutes': durationMinutes,
      if (sleepQuality != null) 'sleepQuality': sleepQuality,
      if (notes != null) 'notes': notes,
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

class _NapEntryImpl extends NapEntry {
  _NapEntryImpl({
    int? id,
    required int organizationId,
    required int childId,
    required int recordedByUserId,
    required DateTime startedAt,
    DateTime? endedAt,
    int? durationMinutes,
    String? sleepQuality,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          childId: childId,
          recordedByUserId: recordedByUserId,
          startedAt: startedAt,
          endedAt: endedAt,
          durationMinutes: durationMinutes,
          sleepQuality: sleepQuality,
          notes: notes,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [NapEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  NapEntry copyWith({
    Object? id = _Undefined,
    int? organizationId,
    int? childId,
    int? recordedByUserId,
    DateTime? startedAt,
    Object? endedAt = _Undefined,
    Object? durationMinutes = _Undefined,
    Object? sleepQuality = _Undefined,
    Object? notes = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return NapEntry(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      childId: childId ?? this.childId,
      recordedByUserId: recordedByUserId ?? this.recordedByUserId,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt is DateTime? ? endedAt : this.endedAt,
      durationMinutes:
          durationMinutes is int? ? durationMinutes : this.durationMinutes,
      sleepQuality: sleepQuality is String? ? sleepQuality : this.sleepQuality,
      notes: notes is String? ? notes : this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
