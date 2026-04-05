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

abstract class MenuEntry implements _i1.SerializableModel {
  MenuEntry._({
    this.id,
    required this.organizationId,
    required this.menuDate,
    required this.mealType,
    required this.title,
    this.description,
    this.classroomId,
    required this.createdByUserId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory MenuEntry({
    int? id,
    required int organizationId,
    required DateTime menuDate,
    required String mealType,
    required String title,
    String? description,
    int? classroomId,
    required int createdByUserId,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) = _MenuEntryImpl;

  factory MenuEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return MenuEntry(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      menuDate:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['menuDate']),
      mealType: jsonSerialization['mealType'] as String,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String?,
      classroomId: jsonSerialization['classroomId'] as int?,
      createdByUserId: jsonSerialization['createdByUserId'] as int,
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

  DateTime menuDate;

  String mealType;

  String title;

  String? description;

  int? classroomId;

  int createdByUserId;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime? deletedAt;

  /// Returns a shallow copy of this [MenuEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MenuEntry copyWith({
    int? id,
    int? organizationId,
    DateTime? menuDate,
    String? mealType,
    String? title,
    String? description,
    int? classroomId,
    int? createdByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'organizationId': organizationId,
      'menuDate': menuDate.toJson(),
      'mealType': mealType,
      'title': title,
      if (description != null) 'description': description,
      if (classroomId != null) 'classroomId': classroomId,
      'createdByUserId': createdByUserId,
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

class _MenuEntryImpl extends MenuEntry {
  _MenuEntryImpl({
    int? id,
    required int organizationId,
    required DateTime menuDate,
    required String mealType,
    required String title,
    String? description,
    int? classroomId,
    required int createdByUserId,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          menuDate: menuDate,
          mealType: mealType,
          title: title,
          description: description,
          classroomId: classroomId,
          createdByUserId: createdByUserId,
          createdAt: createdAt,
          updatedAt: updatedAt,
          deletedAt: deletedAt,
        );

  /// Returns a shallow copy of this [MenuEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MenuEntry copyWith({
    Object? id = _Undefined,
    int? organizationId,
    DateTime? menuDate,
    String? mealType,
    String? title,
    Object? description = _Undefined,
    Object? classroomId = _Undefined,
    int? createdByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? deletedAt = _Undefined,
  }) {
    return MenuEntry(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      menuDate: menuDate ?? this.menuDate,
      mealType: mealType ?? this.mealType,
      title: title ?? this.title,
      description: description is String? ? description : this.description,
      classroomId: classroomId is int? ? classroomId : this.classroomId,
      createdByUserId: createdByUserId ?? this.createdByUserId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt is DateTime? ? deletedAt : this.deletedAt,
    );
  }
}
