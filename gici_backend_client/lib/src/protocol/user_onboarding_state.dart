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

abstract class UserOnboardingState implements _i1.SerializableModel {
  UserOnboardingState._({
    this.id,
    this.organizationId,
    required this.userId,
    this.introCompletedAt,
    this.termsAcceptedAt,
    this.completedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserOnboardingState({
    _i1.UuidValue? id,
    _i1.UuidValue? organizationId,
    required _i1.UuidValue userId,
    DateTime? introCompletedAt,
    DateTime? termsAcceptedAt,
    DateTime? completedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _UserOnboardingStateImpl;

  factory UserOnboardingState.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserOnboardingState(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      organizationId: jsonSerialization['organizationId'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(
              jsonSerialization['organizationId']),
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      introCompletedAt: jsonSerialization['introCompletedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['introCompletedAt']),
      termsAcceptedAt: jsonSerialization['termsAcceptedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['termsAcceptedAt']),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt']),
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

  _i1.UuidValue? organizationId;

  _i1.UuidValue userId;

  DateTime? introCompletedAt;

  DateTime? termsAcceptedAt;

  DateTime? completedAt;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [UserOnboardingState]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserOnboardingState copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? organizationId,
    _i1.UuidValue? userId,
    DateTime? introCompletedAt,
    DateTime? termsAcceptedAt,
    DateTime? completedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id?.toJson(),
      if (organizationId != null) 'organizationId': organizationId?.toJson(),
      'userId': userId.toJson(),
      if (introCompletedAt != null)
        'introCompletedAt': introCompletedAt?.toJson(),
      if (termsAcceptedAt != null) 'termsAcceptedAt': termsAcceptedAt?.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
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

class _UserOnboardingStateImpl extends UserOnboardingState {
  _UserOnboardingStateImpl({
    _i1.UuidValue? id,
    _i1.UuidValue? organizationId,
    required _i1.UuidValue userId,
    DateTime? introCompletedAt,
    DateTime? termsAcceptedAt,
    DateTime? completedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          userId: userId,
          introCompletedAt: introCompletedAt,
          termsAcceptedAt: termsAcceptedAt,
          completedAt: completedAt,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [UserOnboardingState]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserOnboardingState copyWith({
    Object? id = _Undefined,
    Object? organizationId = _Undefined,
    _i1.UuidValue? userId,
    Object? introCompletedAt = _Undefined,
    Object? termsAcceptedAt = _Undefined,
    Object? completedAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserOnboardingState(
      id: id is _i1.UuidValue? ? id : this.id,
      organizationId: organizationId is _i1.UuidValue?
          ? organizationId
          : this.organizationId,
      userId: userId ?? this.userId,
      introCompletedAt: introCompletedAt is DateTime?
          ? introCompletedAt
          : this.introCompletedAt,
      termsAcceptedAt:
          termsAcceptedAt is DateTime? ? termsAcceptedAt : this.termsAcceptedAt,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
