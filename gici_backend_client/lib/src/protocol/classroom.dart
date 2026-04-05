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

abstract class Classroom implements _i1.SerializableModel {
  Classroom._({
    this.id,
    required this.organizationId,
    required this.name,
    this.description,
    this.ageGroupMin,
    this.ageGroupMax,
    required this.capacity,
    this.color,
    this.photoUrl,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Classroom({
    int? id,
    required int organizationId,
    required String name,
    String? description,
    int? ageGroupMin,
    int? ageGroupMax,
    required int capacity,
    String? color,
    String? photoUrl,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) = _ClassroomImpl;

  factory Classroom.fromJson(Map<String, dynamic> jsonSerialization) {
    return Classroom(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      ageGroupMin: jsonSerialization['ageGroupMin'] as int?,
      ageGroupMax: jsonSerialization['ageGroupMax'] as int?,
      capacity: jsonSerialization['capacity'] as int,
      color: jsonSerialization['color'] as String?,
      photoUrl: jsonSerialization['photoUrl'] as String?,
      status: jsonSerialization['status'] as String,
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

  String name;

  String? description;

  int? ageGroupMin;

  int? ageGroupMax;

  int capacity;

  String? color;

  String? photoUrl;

  String status;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime? deletedAt;

  /// Returns a shallow copy of this [Classroom]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Classroom copyWith({
    int? id,
    int? organizationId,
    String? name,
    String? description,
    int? ageGroupMin,
    int? ageGroupMax,
    int? capacity,
    String? color,
    String? photoUrl,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'organizationId': organizationId,
      'name': name,
      if (description != null) 'description': description,
      if (ageGroupMin != null) 'ageGroupMin': ageGroupMin,
      if (ageGroupMax != null) 'ageGroupMax': ageGroupMax,
      'capacity': capacity,
      if (color != null) 'color': color,
      if (photoUrl != null) 'photoUrl': photoUrl,
      'status': status,
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

class _ClassroomImpl extends Classroom {
  _ClassroomImpl({
    int? id,
    required int organizationId,
    required String name,
    String? description,
    int? ageGroupMin,
    int? ageGroupMax,
    required int capacity,
    String? color,
    String? photoUrl,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          name: name,
          description: description,
          ageGroupMin: ageGroupMin,
          ageGroupMax: ageGroupMax,
          capacity: capacity,
          color: color,
          photoUrl: photoUrl,
          status: status,
          createdAt: createdAt,
          updatedAt: updatedAt,
          deletedAt: deletedAt,
        );

  /// Returns a shallow copy of this [Classroom]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Classroom copyWith({
    Object? id = _Undefined,
    int? organizationId,
    String? name,
    Object? description = _Undefined,
    Object? ageGroupMin = _Undefined,
    Object? ageGroupMax = _Undefined,
    int? capacity,
    Object? color = _Undefined,
    Object? photoUrl = _Undefined,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? deletedAt = _Undefined,
  }) {
    return Classroom(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      ageGroupMin: ageGroupMin is int? ? ageGroupMin : this.ageGroupMin,
      ageGroupMax: ageGroupMax is int? ? ageGroupMax : this.ageGroupMax,
      capacity: capacity ?? this.capacity,
      color: color is String? ? color : this.color,
      photoUrl: photoUrl is String? ? photoUrl : this.photoUrl,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt is DateTime? ? deletedAt : this.deletedAt,
    );
  }
}
