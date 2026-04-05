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

abstract class OrganizationSettings implements _i1.SerializableModel {
  OrganizationSettings._({
    this.id,
    required this.organizationId,
    required this.defaultLanguage,
    required this.timezone,
    required this.dateFormat,
    required this.timeFormat,
    required this.workingHoursStart,
    required this.workingHoursEnd,
    required this.maxChildrenPerClassroom,
    required this.earlyCheckInMinutes,
    required this.lateCheckOutMinutes,
    required this.guardianPhotoUploadEnabled,
    required this.chatEnabled,
    required this.pushNotificationsEnabled,
    required this.requireGuardianUploadApproval,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrganizationSettings({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    required String defaultLanguage,
    required String timezone,
    required String dateFormat,
    required String timeFormat,
    required String workingHoursStart,
    required String workingHoursEnd,
    required int maxChildrenPerClassroom,
    required int earlyCheckInMinutes,
    required int lateCheckOutMinutes,
    required bool guardianPhotoUploadEnabled,
    required bool chatEnabled,
    required bool pushNotificationsEnabled,
    required bool requireGuardianUploadApproval,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _OrganizationSettingsImpl;

  factory OrganizationSettings.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return OrganizationSettings(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      organizationId: _i1.UuidValueJsonExtension.fromJson(
          jsonSerialization['organizationId']),
      defaultLanguage: jsonSerialization['defaultLanguage'] as String,
      timezone: jsonSerialization['timezone'] as String,
      dateFormat: jsonSerialization['dateFormat'] as String,
      timeFormat: jsonSerialization['timeFormat'] as String,
      workingHoursStart: jsonSerialization['workingHoursStart'] as String,
      workingHoursEnd: jsonSerialization['workingHoursEnd'] as String,
      maxChildrenPerClassroom:
          jsonSerialization['maxChildrenPerClassroom'] as int,
      earlyCheckInMinutes: jsonSerialization['earlyCheckInMinutes'] as int,
      lateCheckOutMinutes: jsonSerialization['lateCheckOutMinutes'] as int,
      guardianPhotoUploadEnabled:
          jsonSerialization['guardianPhotoUploadEnabled'] as bool,
      chatEnabled: jsonSerialization['chatEnabled'] as bool,
      pushNotificationsEnabled:
          jsonSerialization['pushNotificationsEnabled'] as bool,
      requireGuardianUploadApproval:
          jsonSerialization['requireGuardianUploadApproval'] as bool,
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

  String defaultLanguage;

  String timezone;

  String dateFormat;

  String timeFormat;

  String workingHoursStart;

  String workingHoursEnd;

  int maxChildrenPerClassroom;

  int earlyCheckInMinutes;

  int lateCheckOutMinutes;

  bool guardianPhotoUploadEnabled;

  bool chatEnabled;

  bool pushNotificationsEnabled;

  bool requireGuardianUploadApproval;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [OrganizationSettings]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OrganizationSettings copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? organizationId,
    String? defaultLanguage,
    String? timezone,
    String? dateFormat,
    String? timeFormat,
    String? workingHoursStart,
    String? workingHoursEnd,
    int? maxChildrenPerClassroom,
    int? earlyCheckInMinutes,
    int? lateCheckOutMinutes,
    bool? guardianPhotoUploadEnabled,
    bool? chatEnabled,
    bool? pushNotificationsEnabled,
    bool? requireGuardianUploadApproval,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      'defaultLanguage': defaultLanguage,
      'timezone': timezone,
      'dateFormat': dateFormat,
      'timeFormat': timeFormat,
      'workingHoursStart': workingHoursStart,
      'workingHoursEnd': workingHoursEnd,
      'maxChildrenPerClassroom': maxChildrenPerClassroom,
      'earlyCheckInMinutes': earlyCheckInMinutes,
      'lateCheckOutMinutes': lateCheckOutMinutes,
      'guardianPhotoUploadEnabled': guardianPhotoUploadEnabled,
      'chatEnabled': chatEnabled,
      'pushNotificationsEnabled': pushNotificationsEnabled,
      'requireGuardianUploadApproval': requireGuardianUploadApproval,
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

class _OrganizationSettingsImpl extends OrganizationSettings {
  _OrganizationSettingsImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    required String defaultLanguage,
    required String timezone,
    required String dateFormat,
    required String timeFormat,
    required String workingHoursStart,
    required String workingHoursEnd,
    required int maxChildrenPerClassroom,
    required int earlyCheckInMinutes,
    required int lateCheckOutMinutes,
    required bool guardianPhotoUploadEnabled,
    required bool chatEnabled,
    required bool pushNotificationsEnabled,
    required bool requireGuardianUploadApproval,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          defaultLanguage: defaultLanguage,
          timezone: timezone,
          dateFormat: dateFormat,
          timeFormat: timeFormat,
          workingHoursStart: workingHoursStart,
          workingHoursEnd: workingHoursEnd,
          maxChildrenPerClassroom: maxChildrenPerClassroom,
          earlyCheckInMinutes: earlyCheckInMinutes,
          lateCheckOutMinutes: lateCheckOutMinutes,
          guardianPhotoUploadEnabled: guardianPhotoUploadEnabled,
          chatEnabled: chatEnabled,
          pushNotificationsEnabled: pushNotificationsEnabled,
          requireGuardianUploadApproval: requireGuardianUploadApproval,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [OrganizationSettings]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OrganizationSettings copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? organizationId,
    String? defaultLanguage,
    String? timezone,
    String? dateFormat,
    String? timeFormat,
    String? workingHoursStart,
    String? workingHoursEnd,
    int? maxChildrenPerClassroom,
    int? earlyCheckInMinutes,
    int? lateCheckOutMinutes,
    bool? guardianPhotoUploadEnabled,
    bool? chatEnabled,
    bool? pushNotificationsEnabled,
    bool? requireGuardianUploadApproval,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return OrganizationSettings(
      id: id is _i1.UuidValue? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      defaultLanguage: defaultLanguage ?? this.defaultLanguage,
      timezone: timezone ?? this.timezone,
      dateFormat: dateFormat ?? this.dateFormat,
      timeFormat: timeFormat ?? this.timeFormat,
      workingHoursStart: workingHoursStart ?? this.workingHoursStart,
      workingHoursEnd: workingHoursEnd ?? this.workingHoursEnd,
      maxChildrenPerClassroom:
          maxChildrenPerClassroom ?? this.maxChildrenPerClassroom,
      earlyCheckInMinutes: earlyCheckInMinutes ?? this.earlyCheckInMinutes,
      lateCheckOutMinutes: lateCheckOutMinutes ?? this.lateCheckOutMinutes,
      guardianPhotoUploadEnabled:
          guardianPhotoUploadEnabled ?? this.guardianPhotoUploadEnabled,
      chatEnabled: chatEnabled ?? this.chatEnabled,
      pushNotificationsEnabled:
          pushNotificationsEnabled ?? this.pushNotificationsEnabled,
      requireGuardianUploadApproval:
          requireGuardianUploadApproval ?? this.requireGuardianUploadApproval,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
