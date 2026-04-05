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

abstract class ChildGuardianRelation implements _i1.SerializableModel {
  ChildGuardianRelation._({
    this.id,
    required this.organizationId,
    required this.childId,
    required this.guardianUserId,
    required this.relation,
    required this.isPrimary,
    required this.canPickup,
    required this.canViewReports,
    required this.canViewPhotos,
    this.emergencyContactOrder,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChildGuardianRelation({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    required _i1.UuidValue childId,
    required _i1.UuidValue guardianUserId,
    required String relation,
    required bool isPrimary,
    required bool canPickup,
    required bool canViewReports,
    required bool canViewPhotos,
    int? emergencyContactOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ChildGuardianRelationImpl;

  factory ChildGuardianRelation.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return ChildGuardianRelation(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      organizationId: _i1.UuidValueJsonExtension.fromJson(
          jsonSerialization['organizationId']),
      childId:
          _i1.UuidValueJsonExtension.fromJson(jsonSerialization['childId']),
      guardianUserId: _i1.UuidValueJsonExtension.fromJson(
          jsonSerialization['guardianUserId']),
      relation: jsonSerialization['relation'] as String,
      isPrimary: jsonSerialization['isPrimary'] as bool,
      canPickup: jsonSerialization['canPickup'] as bool,
      canViewReports: jsonSerialization['canViewReports'] as bool,
      canViewPhotos: jsonSerialization['canViewPhotos'] as bool,
      emergencyContactOrder: jsonSerialization['emergencyContactOrder'] as int?,
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

  _i1.UuidValue guardianUserId;

  String relation;

  bool isPrimary;

  bool canPickup;

  bool canViewReports;

  bool canViewPhotos;

  int? emergencyContactOrder;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [ChildGuardianRelation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ChildGuardianRelation copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? organizationId,
    _i1.UuidValue? childId,
    _i1.UuidValue? guardianUserId,
    String? relation,
    bool? isPrimary,
    bool? canPickup,
    bool? canViewReports,
    bool? canViewPhotos,
    int? emergencyContactOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      'childId': childId.toJson(),
      'guardianUserId': guardianUserId.toJson(),
      'relation': relation,
      'isPrimary': isPrimary,
      'canPickup': canPickup,
      'canViewReports': canViewReports,
      'canViewPhotos': canViewPhotos,
      if (emergencyContactOrder != null)
        'emergencyContactOrder': emergencyContactOrder,
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

class _ChildGuardianRelationImpl extends ChildGuardianRelation {
  _ChildGuardianRelationImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    required _i1.UuidValue childId,
    required _i1.UuidValue guardianUserId,
    required String relation,
    required bool isPrimary,
    required bool canPickup,
    required bool canViewReports,
    required bool canViewPhotos,
    int? emergencyContactOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          childId: childId,
          guardianUserId: guardianUserId,
          relation: relation,
          isPrimary: isPrimary,
          canPickup: canPickup,
          canViewReports: canViewReports,
          canViewPhotos: canViewPhotos,
          emergencyContactOrder: emergencyContactOrder,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [ChildGuardianRelation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ChildGuardianRelation copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? organizationId,
    _i1.UuidValue? childId,
    _i1.UuidValue? guardianUserId,
    String? relation,
    bool? isPrimary,
    bool? canPickup,
    bool? canViewReports,
    bool? canViewPhotos,
    Object? emergencyContactOrder = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ChildGuardianRelation(
      id: id is _i1.UuidValue? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      childId: childId ?? this.childId,
      guardianUserId: guardianUserId ?? this.guardianUserId,
      relation: relation ?? this.relation,
      isPrimary: isPrimary ?? this.isPrimary,
      canPickup: canPickup ?? this.canPickup,
      canViewReports: canViewReports ?? this.canViewReports,
      canViewPhotos: canViewPhotos ?? this.canViewPhotos,
      emergencyContactOrder: emergencyContactOrder is int?
          ? emergencyContactOrder
          : this.emergencyContactOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
