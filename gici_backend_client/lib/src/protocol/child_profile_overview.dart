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
import 'child.dart' as _i2;

abstract class ChildProfileOverview implements _i1.SerializableModel {
  ChildProfileOverview._({
    required this.child,
    this.activeClassroomId,
    this.activeClassroomName,
    required this.guardianUserIds,
    required this.guardianDisplayNames,
    required this.documentsCount,
    required this.reportsCount,
    this.lastHabitAt,
  });

  factory ChildProfileOverview({
    required _i2.Child child,
    _i1.UuidValue? activeClassroomId,
    String? activeClassroomName,
    required List<_i1.UuidValue> guardianUserIds,
    required List<String> guardianDisplayNames,
    required int documentsCount,
    required int reportsCount,
    DateTime? lastHabitAt,
  }) = _ChildProfileOverviewImpl;

  factory ChildProfileOverview.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return ChildProfileOverview(
      child: _i2.Child.fromJson(
          (jsonSerialization['child'] as Map<String, dynamic>)),
      activeClassroomId: jsonSerialization['activeClassroomId'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(
              jsonSerialization['activeClassroomId']),
      activeClassroomName: jsonSerialization['activeClassroomName'] as String?,
      guardianUserIds: (jsonSerialization['guardianUserIds'] as List)
          .map((e) => _i1.UuidValueJsonExtension.fromJson(e))
          .toList(),
      guardianDisplayNames: (jsonSerialization['guardianDisplayNames'] as List)
          .map((e) => e as String)
          .toList(),
      documentsCount: jsonSerialization['documentsCount'] as int,
      reportsCount: jsonSerialization['reportsCount'] as int,
      lastHabitAt: jsonSerialization['lastHabitAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastHabitAt']),
    );
  }

  _i2.Child child;

  _i1.UuidValue? activeClassroomId;

  String? activeClassroomName;

  List<_i1.UuidValue> guardianUserIds;

  List<String> guardianDisplayNames;

  int documentsCount;

  int reportsCount;

  DateTime? lastHabitAt;

  /// Returns a shallow copy of this [ChildProfileOverview]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ChildProfileOverview copyWith({
    _i2.Child? child,
    _i1.UuidValue? activeClassroomId,
    String? activeClassroomName,
    List<_i1.UuidValue>? guardianUserIds,
    List<String>? guardianDisplayNames,
    int? documentsCount,
    int? reportsCount,
    DateTime? lastHabitAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'child': child.toJson(),
      if (activeClassroomId != null)
        'activeClassroomId': activeClassroomId?.toJson(),
      if (activeClassroomName != null)
        'activeClassroomName': activeClassroomName,
      'guardianUserIds': guardianUserIds.toJson(valueToJson: (v) => v.toJson()),
      'guardianDisplayNames': guardianDisplayNames.toJson(),
      'documentsCount': documentsCount,
      'reportsCount': reportsCount,
      if (lastHabitAt != null) 'lastHabitAt': lastHabitAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChildProfileOverviewImpl extends ChildProfileOverview {
  _ChildProfileOverviewImpl({
    required _i2.Child child,
    _i1.UuidValue? activeClassroomId,
    String? activeClassroomName,
    required List<_i1.UuidValue> guardianUserIds,
    required List<String> guardianDisplayNames,
    required int documentsCount,
    required int reportsCount,
    DateTime? lastHabitAt,
  }) : super._(
          child: child,
          activeClassroomId: activeClassroomId,
          activeClassroomName: activeClassroomName,
          guardianUserIds: guardianUserIds,
          guardianDisplayNames: guardianDisplayNames,
          documentsCount: documentsCount,
          reportsCount: reportsCount,
          lastHabitAt: lastHabitAt,
        );

  /// Returns a shallow copy of this [ChildProfileOverview]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ChildProfileOverview copyWith({
    _i2.Child? child,
    Object? activeClassroomId = _Undefined,
    Object? activeClassroomName = _Undefined,
    List<_i1.UuidValue>? guardianUserIds,
    List<String>? guardianDisplayNames,
    int? documentsCount,
    int? reportsCount,
    Object? lastHabitAt = _Undefined,
  }) {
    return ChildProfileOverview(
      child: child ?? this.child.copyWith(),
      activeClassroomId: activeClassroomId is _i1.UuidValue?
          ? activeClassroomId
          : this.activeClassroomId,
      activeClassroomName: activeClassroomName is String?
          ? activeClassroomName
          : this.activeClassroomName,
      guardianUserIds:
          guardianUserIds ?? this.guardianUserIds.map((e0) => e0).toList(),
      guardianDisplayNames: guardianDisplayNames ??
          this.guardianDisplayNames.map((e0) => e0).toList(),
      documentsCount: documentsCount ?? this.documentsCount,
      reportsCount: reportsCount ?? this.reportsCount,
      lastHabitAt: lastHabitAt is DateTime? ? lastHabitAt : this.lastHabitAt,
    );
  }
}
