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

abstract class ConsentRecord implements _i1.SerializableModel {
  ConsentRecord._({
    this.id,
    required this.organizationId,
    required this.userId,
    this.childId,
    required this.consentType,
    required this.isAccepted,
    this.acceptedAt,
    this.ipAddress,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ConsentRecord({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    required _i1.UuidValue userId,
    _i1.UuidValue? childId,
    required String consentType,
    required bool isAccepted,
    DateTime? acceptedAt,
    String? ipAddress,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ConsentRecordImpl;

  factory ConsentRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return ConsentRecord(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      organizationId: _i1.UuidValueJsonExtension.fromJson(
          jsonSerialization['organizationId']),
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      childId: jsonSerialization['childId'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['childId']),
      consentType: jsonSerialization['consentType'] as String,
      isAccepted: jsonSerialization['isAccepted'] as bool,
      acceptedAt: jsonSerialization['acceptedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['acceptedAt']),
      ipAddress: jsonSerialization['ipAddress'] as String?,
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

  _i1.UuidValue userId;

  _i1.UuidValue? childId;

  String consentType;

  bool isAccepted;

  DateTime? acceptedAt;

  String? ipAddress;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [ConsentRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ConsentRecord copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? organizationId,
    _i1.UuidValue? userId,
    _i1.UuidValue? childId,
    String? consentType,
    bool? isAccepted,
    DateTime? acceptedAt,
    String? ipAddress,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      'userId': userId.toJson(),
      if (childId != null) 'childId': childId?.toJson(),
      'consentType': consentType,
      'isAccepted': isAccepted,
      if (acceptedAt != null) 'acceptedAt': acceptedAt?.toJson(),
      if (ipAddress != null) 'ipAddress': ipAddress,
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

class _ConsentRecordImpl extends ConsentRecord {
  _ConsentRecordImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    required _i1.UuidValue userId,
    _i1.UuidValue? childId,
    required String consentType,
    required bool isAccepted,
    DateTime? acceptedAt,
    String? ipAddress,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          userId: userId,
          childId: childId,
          consentType: consentType,
          isAccepted: isAccepted,
          acceptedAt: acceptedAt,
          ipAddress: ipAddress,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [ConsentRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ConsentRecord copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? organizationId,
    _i1.UuidValue? userId,
    Object? childId = _Undefined,
    String? consentType,
    bool? isAccepted,
    Object? acceptedAt = _Undefined,
    Object? ipAddress = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ConsentRecord(
      id: id is _i1.UuidValue? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      userId: userId ?? this.userId,
      childId: childId is _i1.UuidValue? ? childId : this.childId,
      consentType: consentType ?? this.consentType,
      isAccepted: isAccepted ?? this.isAccepted,
      acceptedAt: acceptedAt is DateTime? ? acceptedAt : this.acceptedAt,
      ipAddress: ipAddress is String? ? ipAddress : this.ipAddress,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
