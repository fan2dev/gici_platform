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

abstract class AuthSession implements _i1.SerializableModel {
  AuthSession._({
    required this.appUserId,
    this.organizationId,
    required this.email,
    required this.role,
    required this.firstName,
    required this.lastName,
  });

  factory AuthSession({
    required int appUserId,
    int? organizationId,
    required String email,
    required String role,
    required String firstName,
    required String lastName,
  }) = _AuthSessionImpl;

  factory AuthSession.fromJson(Map<String, dynamic> jsonSerialization) {
    return AuthSession(
      appUserId: jsonSerialization['appUserId'] as int,
      organizationId: jsonSerialization['organizationId'] as int?,
      email: jsonSerialization['email'] as String,
      role: jsonSerialization['role'] as String,
      firstName: jsonSerialization['firstName'] as String,
      lastName: jsonSerialization['lastName'] as String,
    );
  }

  int appUserId;

  int? organizationId;

  String email;

  String role;

  String firstName;

  String lastName;

  /// Returns a shallow copy of this [AuthSession]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AuthSession copyWith({
    int? appUserId,
    int? organizationId,
    String? email,
    String? role,
    String? firstName,
    String? lastName,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'appUserId': appUserId,
      if (organizationId != null) 'organizationId': organizationId,
      'email': email,
      'role': role,
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AuthSessionImpl extends AuthSession {
  _AuthSessionImpl({
    required int appUserId,
    int? organizationId,
    required String email,
    required String role,
    required String firstName,
    required String lastName,
  }) : super._(
          appUserId: appUserId,
          organizationId: organizationId,
          email: email,
          role: role,
          firstName: firstName,
          lastName: lastName,
        );

  /// Returns a shallow copy of this [AuthSession]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AuthSession copyWith({
    int? appUserId,
    Object? organizationId = _Undefined,
    String? email,
    String? role,
    String? firstName,
    String? lastName,
  }) {
    return AuthSession(
      appUserId: appUserId ?? this.appUserId,
      organizationId:
          organizationId is int? ? organizationId : this.organizationId,
      email: email ?? this.email,
      role: role ?? this.role,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }
}
