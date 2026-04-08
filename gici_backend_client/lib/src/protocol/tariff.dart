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

abstract class Tariff implements _i1.SerializableModel {
  Tariff._({
    this.id,
    required this.organizationId,
    required this.name,
    this.description,
    required this.schedule,
    required this.monthlyPrice,
    required this.includesTransport,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Tariff({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    required String name,
    String? description,
    required String schedule,
    required double monthlyPrice,
    required bool includesTransport,
    required bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) = _TariffImpl;

  factory Tariff.fromJson(Map<String, dynamic> jsonSerialization) {
    return Tariff(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      organizationId: _i1.UuidValueJsonExtension.fromJson(
          jsonSerialization['organizationId']),
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      schedule: jsonSerialization['schedule'] as String,
      monthlyPrice: (jsonSerialization['monthlyPrice'] as num).toDouble(),
      includesTransport: jsonSerialization['includesTransport'] as bool,
      isActive: jsonSerialization['isActive'] as bool,
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
  _i1.UuidValue? id;

  _i1.UuidValue organizationId;

  String name;

  String? description;

  String schedule;

  double monthlyPrice;

  bool includesTransport;

  bool isActive;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime? deletedAt;

  /// Returns a shallow copy of this [Tariff]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Tariff copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? organizationId,
    String? name,
    String? description,
    String? schedule,
    double? monthlyPrice,
    bool? includesTransport,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      'name': name,
      if (description != null) 'description': description,
      'schedule': schedule,
      'monthlyPrice': monthlyPrice,
      'includesTransport': includesTransport,
      'isActive': isActive,
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

class _TariffImpl extends Tariff {
  _TariffImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    required String name,
    String? description,
    required String schedule,
    required double monthlyPrice,
    required bool includesTransport,
    required bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          name: name,
          description: description,
          schedule: schedule,
          monthlyPrice: monthlyPrice,
          includesTransport: includesTransport,
          isActive: isActive,
          createdAt: createdAt,
          updatedAt: updatedAt,
          deletedAt: deletedAt,
        );

  /// Returns a shallow copy of this [Tariff]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Tariff copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? organizationId,
    String? name,
    Object? description = _Undefined,
    String? schedule,
    double? monthlyPrice,
    bool? includesTransport,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? deletedAt = _Undefined,
  }) {
    return Tariff(
      id: id is _i1.UuidValue? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      schedule: schedule ?? this.schedule,
      monthlyPrice: monthlyPrice ?? this.monthlyPrice,
      includesTransport: includesTransport ?? this.includesTransport,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt is DateTime? ? deletedAt : this.deletedAt,
    );
  }
}
