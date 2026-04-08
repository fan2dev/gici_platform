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

abstract class Absence implements _i1.SerializableModel {
  Absence._({
    this.id,
    required this.organizationId,
    required this.childId,
    required this.date,
    this.reason,
    required this.isJustified,
    required this.reportedByUserId,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Absence({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    required _i1.UuidValue childId,
    required DateTime date,
    String? reason,
    required bool isJustified,
    required _i1.UuidValue reportedByUserId,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _AbsenceImpl;

  factory Absence.fromJson(Map<String, dynamic> jsonSerialization) {
    return Absence(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      organizationId: _i1.UuidValueJsonExtension.fromJson(
          jsonSerialization['organizationId']),
      childId:
          _i1.UuidValueJsonExtension.fromJson(jsonSerialization['childId']),
      date: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
      reason: jsonSerialization['reason'] as String?,
      isJustified: jsonSerialization['isJustified'] as bool,
      reportedByUserId: _i1.UuidValueJsonExtension.fromJson(
          jsonSerialization['reportedByUserId']),
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
  _i1.UuidValue? id;

  _i1.UuidValue organizationId;

  _i1.UuidValue childId;

  DateTime date;

  String? reason;

  bool isJustified;

  _i1.UuidValue reportedByUserId;

  String? notes;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Absence]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Absence copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? organizationId,
    _i1.UuidValue? childId,
    DateTime? date,
    String? reason,
    bool? isJustified,
    _i1.UuidValue? reportedByUserId,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      'childId': childId.toJson(),
      'date': date.toJson(),
      if (reason != null) 'reason': reason,
      'isJustified': isJustified,
      'reportedByUserId': reportedByUserId.toJson(),
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

class _AbsenceImpl extends Absence {
  _AbsenceImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    required _i1.UuidValue childId,
    required DateTime date,
    String? reason,
    required bool isJustified,
    required _i1.UuidValue reportedByUserId,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          childId: childId,
          date: date,
          reason: reason,
          isJustified: isJustified,
          reportedByUserId: reportedByUserId,
          notes: notes,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [Absence]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Absence copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? organizationId,
    _i1.UuidValue? childId,
    DateTime? date,
    Object? reason = _Undefined,
    bool? isJustified,
    _i1.UuidValue? reportedByUserId,
    Object? notes = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Absence(
      id: id is _i1.UuidValue? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      childId: childId ?? this.childId,
      date: date ?? this.date,
      reason: reason is String? ? reason : this.reason,
      isJustified: isJustified ?? this.isJustified,
      reportedByUserId: reportedByUserId ?? this.reportedByUserId,
      notes: notes is String? ? notes : this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
