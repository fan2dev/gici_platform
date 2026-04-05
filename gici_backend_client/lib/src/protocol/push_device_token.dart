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

abstract class PushDeviceToken implements _i1.SerializableModel {
  PushDeviceToken._({
    this.id,
    required this.organizationId,
    required this.userId,
    required this.token,
    required this.platform,
    this.deviceId,
    this.deviceModel,
    this.appVersion,
    required this.isActive,
    required this.lastUsedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PushDeviceToken({
    int? id,
    required int organizationId,
    required int userId,
    required String token,
    required String platform,
    String? deviceId,
    String? deviceModel,
    String? appVersion,
    required bool isActive,
    required DateTime lastUsedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _PushDeviceTokenImpl;

  factory PushDeviceToken.fromJson(Map<String, dynamic> jsonSerialization) {
    return PushDeviceToken(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      userId: jsonSerialization['userId'] as int,
      token: jsonSerialization['token'] as String,
      platform: jsonSerialization['platform'] as String,
      deviceId: jsonSerialization['deviceId'] as String?,
      deviceModel: jsonSerialization['deviceModel'] as String?,
      appVersion: jsonSerialization['appVersion'] as String?,
      isActive: jsonSerialization['isActive'] as bool,
      lastUsedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['lastUsedAt']),
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

  int userId;

  String token;

  String platform;

  String? deviceId;

  String? deviceModel;

  String? appVersion;

  bool isActive;

  DateTime lastUsedAt;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [PushDeviceToken]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PushDeviceToken copyWith({
    int? id,
    int? organizationId,
    int? userId,
    String? token,
    String? platform,
    String? deviceId,
    String? deviceModel,
    String? appVersion,
    bool? isActive,
    DateTime? lastUsedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'organizationId': organizationId,
      'userId': userId,
      'token': token,
      'platform': platform,
      if (deviceId != null) 'deviceId': deviceId,
      if (deviceModel != null) 'deviceModel': deviceModel,
      if (appVersion != null) 'appVersion': appVersion,
      'isActive': isActive,
      'lastUsedAt': lastUsedAt.toJson(),
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

class _PushDeviceTokenImpl extends PushDeviceToken {
  _PushDeviceTokenImpl({
    int? id,
    required int organizationId,
    required int userId,
    required String token,
    required String platform,
    String? deviceId,
    String? deviceModel,
    String? appVersion,
    required bool isActive,
    required DateTime lastUsedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          userId: userId,
          token: token,
          platform: platform,
          deviceId: deviceId,
          deviceModel: deviceModel,
          appVersion: appVersion,
          isActive: isActive,
          lastUsedAt: lastUsedAt,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [PushDeviceToken]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PushDeviceToken copyWith({
    Object? id = _Undefined,
    int? organizationId,
    int? userId,
    String? token,
    String? platform,
    Object? deviceId = _Undefined,
    Object? deviceModel = _Undefined,
    Object? appVersion = _Undefined,
    bool? isActive,
    DateTime? lastUsedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PushDeviceToken(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      userId: userId ?? this.userId,
      token: token ?? this.token,
      platform: platform ?? this.platform,
      deviceId: deviceId is String? ? deviceId : this.deviceId,
      deviceModel: deviceModel is String? ? deviceModel : this.deviceModel,
      appVersion: appVersion is String? ? appVersion : this.appVersion,
      isActive: isActive ?? this.isActive,
      lastUsedAt: lastUsedAt ?? this.lastUsedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
