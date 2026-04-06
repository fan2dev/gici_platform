/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'menu_entry.dart' as _i2;
import 'notification_record.dart' as _i3;

abstract class DashboardSummary
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  DashboardSummary._({
    required this.childrenCount,
    required this.classroomsCount,
    required this.staffCount,
    required this.unreadNotifications,
    required this.pendingRequests,
    required this.todayMenuEntries,
    required this.recentNotifications,
  });

  factory DashboardSummary({
    required int childrenCount,
    required int classroomsCount,
    required int staffCount,
    required int unreadNotifications,
    required int pendingRequests,
    required List<_i2.MenuEntry> todayMenuEntries,
    required List<_i3.NotificationRecord> recentNotifications,
  }) = _DashboardSummaryImpl;

  factory DashboardSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return DashboardSummary(
      childrenCount: jsonSerialization['childrenCount'] as int,
      classroomsCount: jsonSerialization['classroomsCount'] as int,
      staffCount: jsonSerialization['staffCount'] as int,
      unreadNotifications: jsonSerialization['unreadNotifications'] as int,
      pendingRequests: jsonSerialization['pendingRequests'] as int,
      todayMenuEntries: (jsonSerialization['todayMenuEntries'] as List)
          .map((e) => _i2.MenuEntry.fromJson((e as Map<String, dynamic>)))
          .toList(),
      recentNotifications: (jsonSerialization['recentNotifications'] as List)
          .map((e) =>
              _i3.NotificationRecord.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  int childrenCount;

  int classroomsCount;

  int staffCount;

  int unreadNotifications;

  int pendingRequests;

  List<_i2.MenuEntry> todayMenuEntries;

  List<_i3.NotificationRecord> recentNotifications;

  /// Returns a shallow copy of this [DashboardSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DashboardSummary copyWith({
    int? childrenCount,
    int? classroomsCount,
    int? staffCount,
    int? unreadNotifications,
    int? pendingRequests,
    List<_i2.MenuEntry>? todayMenuEntries,
    List<_i3.NotificationRecord>? recentNotifications,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'childrenCount': childrenCount,
      'classroomsCount': classroomsCount,
      'staffCount': staffCount,
      'unreadNotifications': unreadNotifications,
      'pendingRequests': pendingRequests,
      'todayMenuEntries':
          todayMenuEntries.toJson(valueToJson: (v) => v.toJson()),
      'recentNotifications':
          recentNotifications.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'childrenCount': childrenCount,
      'classroomsCount': classroomsCount,
      'staffCount': staffCount,
      'unreadNotifications': unreadNotifications,
      'pendingRequests': pendingRequests,
      'todayMenuEntries':
          todayMenuEntries.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'recentNotifications':
          recentNotifications.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _DashboardSummaryImpl extends DashboardSummary {
  _DashboardSummaryImpl({
    required int childrenCount,
    required int classroomsCount,
    required int staffCount,
    required int unreadNotifications,
    required int pendingRequests,
    required List<_i2.MenuEntry> todayMenuEntries,
    required List<_i3.NotificationRecord> recentNotifications,
  }) : super._(
          childrenCount: childrenCount,
          classroomsCount: classroomsCount,
          staffCount: staffCount,
          unreadNotifications: unreadNotifications,
          pendingRequests: pendingRequests,
          todayMenuEntries: todayMenuEntries,
          recentNotifications: recentNotifications,
        );

  /// Returns a shallow copy of this [DashboardSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DashboardSummary copyWith({
    int? childrenCount,
    int? classroomsCount,
    int? staffCount,
    int? unreadNotifications,
    int? pendingRequests,
    List<_i2.MenuEntry>? todayMenuEntries,
    List<_i3.NotificationRecord>? recentNotifications,
  }) {
    return DashboardSummary(
      childrenCount: childrenCount ?? this.childrenCount,
      classroomsCount: classroomsCount ?? this.classroomsCount,
      staffCount: staffCount ?? this.staffCount,
      unreadNotifications: unreadNotifications ?? this.unreadNotifications,
      pendingRequests: pendingRequests ?? this.pendingRequests,
      todayMenuEntries: todayMenuEntries ??
          this.todayMenuEntries.map((e0) => e0.copyWith()).toList(),
      recentNotifications: recentNotifications ??
          this.recentNotifications.map((e0) => e0.copyWith()).toList(),
    );
  }
}
