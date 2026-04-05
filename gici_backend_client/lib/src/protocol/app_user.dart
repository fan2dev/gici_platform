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

abstract class AppUser implements _i1.SerializableModel {
  AppUser._({
    this.id,
    this.organizationId,
    required this.email,
    required this.passwordHash,
    required this.firstName,
    required this.lastName,
    this.phone,
    this.avatarUrl,
    required this.role,
    required this.isActive,
    required this.emailVerified,
    required this.phoneVerified,
    this.lastLoginAt,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory AppUser({
    int? id,
    int? organizationId,
    required String email,
    required String passwordHash,
    required String firstName,
    required String lastName,
    String? phone,
    String? avatarUrl,
    required String role,
    required bool isActive,
    required bool emailVerified,
    required bool phoneVerified,
    DateTime? lastLoginAt,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) = _AppUserImpl;

  factory AppUser.fromJson(Map<String, dynamic> jsonSerialization) {
    return AppUser(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int?,
      email: jsonSerialization['email'] as String,
      passwordHash: jsonSerialization['passwordHash'] as String,
      firstName: jsonSerialization['firstName'] as String,
      lastName: jsonSerialization['lastName'] as String,
      phone: jsonSerialization['phone'] as String?,
      avatarUrl: jsonSerialization['avatarUrl'] as String?,
      role: jsonSerialization['role'] as String,
      isActive: jsonSerialization['isActive'] as bool,
      emailVerified: jsonSerialization['emailVerified'] as bool,
      phoneVerified: jsonSerialization['phoneVerified'] as bool,
      lastLoginAt: jsonSerialization['lastLoginAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastLoginAt']),
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

  int? organizationId;

  String email;

  String passwordHash;

  String firstName;

  String lastName;

  String? phone;

  String? avatarUrl;

  String role;

  bool isActive;

  bool emailVerified;

  bool phoneVerified;

  DateTime? lastLoginAt;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime? deletedAt;

  /// Returns a shallow copy of this [AppUser]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AppUser copyWith({
    int? id,
    int? organizationId,
    String? email,
    String? passwordHash,
    String? firstName,
    String? lastName,
    String? phone,
    String? avatarUrl,
    String? role,
    bool? isActive,
    bool? emailVerified,
    bool? phoneVerified,
    DateTime? lastLoginAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (organizationId != null) 'organizationId': organizationId,
      'email': email,
      'passwordHash': passwordHash,
      'firstName': firstName,
      'lastName': lastName,
      if (phone != null) 'phone': phone,
      if (avatarUrl != null) 'avatarUrl': avatarUrl,
      'role': role,
      'isActive': isActive,
      'emailVerified': emailVerified,
      'phoneVerified': phoneVerified,
      if (lastLoginAt != null) 'lastLoginAt': lastLoginAt?.toJson(),
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

class _AppUserImpl extends AppUser {
  _AppUserImpl({
    int? id,
    int? organizationId,
    required String email,
    required String passwordHash,
    required String firstName,
    required String lastName,
    String? phone,
    String? avatarUrl,
    required String role,
    required bool isActive,
    required bool emailVerified,
    required bool phoneVerified,
    DateTime? lastLoginAt,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          email: email,
          passwordHash: passwordHash,
          firstName: firstName,
          lastName: lastName,
          phone: phone,
          avatarUrl: avatarUrl,
          role: role,
          isActive: isActive,
          emailVerified: emailVerified,
          phoneVerified: phoneVerified,
          lastLoginAt: lastLoginAt,
          createdAt: createdAt,
          updatedAt: updatedAt,
          deletedAt: deletedAt,
        );

  /// Returns a shallow copy of this [AppUser]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AppUser copyWith({
    Object? id = _Undefined,
    Object? organizationId = _Undefined,
    String? email,
    String? passwordHash,
    String? firstName,
    String? lastName,
    Object? phone = _Undefined,
    Object? avatarUrl = _Undefined,
    String? role,
    bool? isActive,
    bool? emailVerified,
    bool? phoneVerified,
    Object? lastLoginAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? deletedAt = _Undefined,
  }) {
    return AppUser(
      id: id is int? ? id : this.id,
      organizationId:
          organizationId is int? ? organizationId : this.organizationId,
      email: email ?? this.email,
      passwordHash: passwordHash ?? this.passwordHash,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone is String? ? phone : this.phone,
      avatarUrl: avatarUrl is String? ? avatarUrl : this.avatarUrl,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      emailVerified: emailVerified ?? this.emailVerified,
      phoneVerified: phoneVerified ?? this.phoneVerified,
      lastLoginAt: lastLoginAt is DateTime? ? lastLoginAt : this.lastLoginAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt is DateTime? ? deletedAt : this.deletedAt,
    );
  }
}
