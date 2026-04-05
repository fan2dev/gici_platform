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

abstract class MealEntry implements _i1.SerializableModel {
  MealEntry._({
    this.id,
    required this.organizationId,
    required this.childId,
    required this.recordedByUserId,
    required this.mealType,
    required this.consumptionLevel,
    required this.recordedAt,
    this.menuItems,
    this.notes,
    this.photoUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MealEntry({
    int? id,
    required int organizationId,
    required int childId,
    required int recordedByUserId,
    required String mealType,
    required String consumptionLevel,
    required DateTime recordedAt,
    String? menuItems,
    String? notes,
    String? photoUrl,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _MealEntryImpl;

  factory MealEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return MealEntry(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      childId: jsonSerialization['childId'] as int,
      recordedByUserId: jsonSerialization['recordedByUserId'] as int,
      mealType: jsonSerialization['mealType'] as String,
      consumptionLevel: jsonSerialization['consumptionLevel'] as String,
      recordedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['recordedAt']),
      menuItems: jsonSerialization['menuItems'] as String?,
      notes: jsonSerialization['notes'] as String?,
      photoUrl: jsonSerialization['photoUrl'] as String?,
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

  String mealType;

  String consumptionLevel;

  DateTime recordedAt;

  String? menuItems;

  String? notes;

  String? photoUrl;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [MealEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MealEntry copyWith({
    int? id,
    int? organizationId,
    int? childId,
    int? recordedByUserId,
    String? mealType,
    String? consumptionLevel,
    DateTime? recordedAt,
    String? menuItems,
    String? notes,
    String? photoUrl,
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
      'mealType': mealType,
      'consumptionLevel': consumptionLevel,
      'recordedAt': recordedAt.toJson(),
      if (menuItems != null) 'menuItems': menuItems,
      if (notes != null) 'notes': notes,
      if (photoUrl != null) 'photoUrl': photoUrl,
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

class _MealEntryImpl extends MealEntry {
  _MealEntryImpl({
    int? id,
    required int organizationId,
    required int childId,
    required int recordedByUserId,
    required String mealType,
    required String consumptionLevel,
    required DateTime recordedAt,
    String? menuItems,
    String? notes,
    String? photoUrl,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          childId: childId,
          recordedByUserId: recordedByUserId,
          mealType: mealType,
          consumptionLevel: consumptionLevel,
          recordedAt: recordedAt,
          menuItems: menuItems,
          notes: notes,
          photoUrl: photoUrl,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [MealEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MealEntry copyWith({
    Object? id = _Undefined,
    int? organizationId,
    int? childId,
    int? recordedByUserId,
    String? mealType,
    String? consumptionLevel,
    DateTime? recordedAt,
    Object? menuItems = _Undefined,
    Object? notes = _Undefined,
    Object? photoUrl = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MealEntry(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      childId: childId ?? this.childId,
      recordedByUserId: recordedByUserId ?? this.recordedByUserId,
      mealType: mealType ?? this.mealType,
      consumptionLevel: consumptionLevel ?? this.consumptionLevel,
      recordedAt: recordedAt ?? this.recordedAt,
      menuItems: menuItems is String? ? menuItems : this.menuItems,
      notes: notes is String? ? notes : this.notes,
      photoUrl: photoUrl is String? ? photoUrl : this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
