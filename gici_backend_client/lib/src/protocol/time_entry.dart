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

abstract class TimeEntry implements _i1.SerializableModel {
  TimeEntry._({
    this.id,
    required this.organizationId,
    required this.userId,
    required this.entryType,
    required this.recordedAt,
    this.parentEntryId,
    this.correctionReason,
    this.locationData,
    this.deviceInfo,
    this.notes,
    required this.isManualEntry,
    required this.createdByUserId,
    required this.createdAt,
  });

  factory TimeEntry({
    int? id,
    required int organizationId,
    required int userId,
    required String entryType,
    required DateTime recordedAt,
    int? parentEntryId,
    String? correctionReason,
    String? locationData,
    String? deviceInfo,
    String? notes,
    required bool isManualEntry,
    required int createdByUserId,
    required DateTime createdAt,
  }) = _TimeEntryImpl;

  factory TimeEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return TimeEntry(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      userId: jsonSerialization['userId'] as int,
      entryType: jsonSerialization['entryType'] as String,
      recordedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['recordedAt']),
      parentEntryId: jsonSerialization['parentEntryId'] as int?,
      correctionReason: jsonSerialization['correctionReason'] as String?,
      locationData: jsonSerialization['locationData'] as String?,
      deviceInfo: jsonSerialization['deviceInfo'] as String?,
      notes: jsonSerialization['notes'] as String?,
      isManualEntry: jsonSerialization['isManualEntry'] as bool,
      createdByUserId: jsonSerialization['createdByUserId'] as int,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int organizationId;

  int userId;

  String entryType;

  DateTime recordedAt;

  int? parentEntryId;

  String? correctionReason;

  String? locationData;

  String? deviceInfo;

  String? notes;

  bool isManualEntry;

  int createdByUserId;

  DateTime createdAt;

  /// Returns a shallow copy of this [TimeEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TimeEntry copyWith({
    int? id,
    int? organizationId,
    int? userId,
    String? entryType,
    DateTime? recordedAt,
    int? parentEntryId,
    String? correctionReason,
    String? locationData,
    String? deviceInfo,
    String? notes,
    bool? isManualEntry,
    int? createdByUserId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'organizationId': organizationId,
      'userId': userId,
      'entryType': entryType,
      'recordedAt': recordedAt.toJson(),
      if (parentEntryId != null) 'parentEntryId': parentEntryId,
      if (correctionReason != null) 'correctionReason': correctionReason,
      if (locationData != null) 'locationData': locationData,
      if (deviceInfo != null) 'deviceInfo': deviceInfo,
      if (notes != null) 'notes': notes,
      'isManualEntry': isManualEntry,
      'createdByUserId': createdByUserId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TimeEntryImpl extends TimeEntry {
  _TimeEntryImpl({
    int? id,
    required int organizationId,
    required int userId,
    required String entryType,
    required DateTime recordedAt,
    int? parentEntryId,
    String? correctionReason,
    String? locationData,
    String? deviceInfo,
    String? notes,
    required bool isManualEntry,
    required int createdByUserId,
    required DateTime createdAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          userId: userId,
          entryType: entryType,
          recordedAt: recordedAt,
          parentEntryId: parentEntryId,
          correctionReason: correctionReason,
          locationData: locationData,
          deviceInfo: deviceInfo,
          notes: notes,
          isManualEntry: isManualEntry,
          createdByUserId: createdByUserId,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [TimeEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TimeEntry copyWith({
    Object? id = _Undefined,
    int? organizationId,
    int? userId,
    String? entryType,
    DateTime? recordedAt,
    Object? parentEntryId = _Undefined,
    Object? correctionReason = _Undefined,
    Object? locationData = _Undefined,
    Object? deviceInfo = _Undefined,
    Object? notes = _Undefined,
    bool? isManualEntry,
    int? createdByUserId,
    DateTime? createdAt,
  }) {
    return TimeEntry(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      userId: userId ?? this.userId,
      entryType: entryType ?? this.entryType,
      recordedAt: recordedAt ?? this.recordedAt,
      parentEntryId: parentEntryId is int? ? parentEntryId : this.parentEntryId,
      correctionReason: correctionReason is String?
          ? correctionReason
          : this.correctionReason,
      locationData: locationData is String? ? locationData : this.locationData,
      deviceInfo: deviceInfo is String? ? deviceInfo : this.deviceInfo,
      notes: notes is String? ? notes : this.notes,
      isManualEntry: isManualEntry ?? this.isManualEntry,
      createdByUserId: createdByUserId ?? this.createdByUserId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
