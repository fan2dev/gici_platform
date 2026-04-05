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

abstract class BowelMovementEntry implements _i1.SerializableModel {
  BowelMovementEntry._({
    this.id,
    required this.organizationId,
    required this.childId,
    required this.recordedByUserId,
    required this.eventAt,
    required this.eventType,
    this.consistency,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BowelMovementEntry({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    required _i1.UuidValue childId,
    required _i1.UuidValue recordedByUserId,
    required DateTime eventAt,
    required String eventType,
    String? consistency,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _BowelMovementEntryImpl;

  factory BowelMovementEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return BowelMovementEntry(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      organizationId: _i1.UuidValueJsonExtension.fromJson(
          jsonSerialization['organizationId']),
      childId:
          _i1.UuidValueJsonExtension.fromJson(jsonSerialization['childId']),
      recordedByUserId: _i1.UuidValueJsonExtension.fromJson(
          jsonSerialization['recordedByUserId']),
      eventAt: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['eventAt']),
      eventType: jsonSerialization['eventType'] as String,
      consistency: jsonSerialization['consistency'] as String?,
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

  _i1.UuidValue recordedByUserId;

  DateTime eventAt;

  String eventType;

  String? consistency;

  String? notes;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [BowelMovementEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BowelMovementEntry copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? organizationId,
    _i1.UuidValue? childId,
    _i1.UuidValue? recordedByUserId,
    DateTime? eventAt,
    String? eventType,
    String? consistency,
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
      'recordedByUserId': recordedByUserId.toJson(),
      'eventAt': eventAt.toJson(),
      'eventType': eventType,
      if (consistency != null) 'consistency': consistency,
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

class _BowelMovementEntryImpl extends BowelMovementEntry {
  _BowelMovementEntryImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    required _i1.UuidValue childId,
    required _i1.UuidValue recordedByUserId,
    required DateTime eventAt,
    required String eventType,
    String? consistency,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          childId: childId,
          recordedByUserId: recordedByUserId,
          eventAt: eventAt,
          eventType: eventType,
          consistency: consistency,
          notes: notes,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [BowelMovementEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BowelMovementEntry copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? organizationId,
    _i1.UuidValue? childId,
    _i1.UuidValue? recordedByUserId,
    DateTime? eventAt,
    String? eventType,
    Object? consistency = _Undefined,
    Object? notes = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BowelMovementEntry(
      id: id is _i1.UuidValue? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      childId: childId ?? this.childId,
      recordedByUserId: recordedByUserId ?? this.recordedByUserId,
      eventAt: eventAt ?? this.eventAt,
      eventType: eventType ?? this.eventType,
      consistency: consistency is String? ? consistency : this.consistency,
      notes: notes is String? ? notes : this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
