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

abstract class Child implements _i1.SerializableModel {
  Child._({
    this.id,
    required this.organizationId,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    this.gender,
    this.photoUrl,
    this.medicalNotes,
    this.dietaryNotes,
    this.allergies,
    this.emergencyContactName,
    this.emergencyContactPhone,
    this.enrollmentDate,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Child({
    int? id,
    required int organizationId,
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
    String? gender,
    String? photoUrl,
    String? medicalNotes,
    String? dietaryNotes,
    String? allergies,
    String? emergencyContactName,
    String? emergencyContactPhone,
    DateTime? enrollmentDate,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) = _ChildImpl;

  factory Child.fromJson(Map<String, dynamic> jsonSerialization) {
    return Child(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      firstName: jsonSerialization['firstName'] as String,
      lastName: jsonSerialization['lastName'] as String,
      dateOfBirth:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['dateOfBirth']),
      gender: jsonSerialization['gender'] as String?,
      photoUrl: jsonSerialization['photoUrl'] as String?,
      medicalNotes: jsonSerialization['medicalNotes'] as String?,
      dietaryNotes: jsonSerialization['dietaryNotes'] as String?,
      allergies: jsonSerialization['allergies'] as String?,
      emergencyContactName:
          jsonSerialization['emergencyContactName'] as String?,
      emergencyContactPhone:
          jsonSerialization['emergencyContactPhone'] as String?,
      enrollmentDate: jsonSerialization['enrollmentDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['enrollmentDate']),
      status: jsonSerialization['status'] as String,
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

  String firstName;

  String lastName;

  DateTime dateOfBirth;

  String? gender;

  String? photoUrl;

  String? medicalNotes;

  String? dietaryNotes;

  String? allergies;

  String? emergencyContactName;

  String? emergencyContactPhone;

  DateTime? enrollmentDate;

  String status;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime? deletedAt;

  /// Returns a shallow copy of this [Child]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Child copyWith({
    int? id,
    int? organizationId,
    String? firstName,
    String? lastName,
    DateTime? dateOfBirth,
    String? gender,
    String? photoUrl,
    String? medicalNotes,
    String? dietaryNotes,
    String? allergies,
    String? emergencyContactName,
    String? emergencyContactPhone,
    DateTime? enrollmentDate,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'organizationId': organizationId,
      'firstName': firstName,
      'lastName': lastName,
      'dateOfBirth': dateOfBirth.toJson(),
      if (gender != null) 'gender': gender,
      if (photoUrl != null) 'photoUrl': photoUrl,
      if (medicalNotes != null) 'medicalNotes': medicalNotes,
      if (dietaryNotes != null) 'dietaryNotes': dietaryNotes,
      if (allergies != null) 'allergies': allergies,
      if (emergencyContactName != null)
        'emergencyContactName': emergencyContactName,
      if (emergencyContactPhone != null)
        'emergencyContactPhone': emergencyContactPhone,
      if (enrollmentDate != null) 'enrollmentDate': enrollmentDate?.toJson(),
      'status': status,
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

class _ChildImpl extends Child {
  _ChildImpl({
    int? id,
    required int organizationId,
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
    String? gender,
    String? photoUrl,
    String? medicalNotes,
    String? dietaryNotes,
    String? allergies,
    String? emergencyContactName,
    String? emergencyContactPhone,
    DateTime? enrollmentDate,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          firstName: firstName,
          lastName: lastName,
          dateOfBirth: dateOfBirth,
          gender: gender,
          photoUrl: photoUrl,
          medicalNotes: medicalNotes,
          dietaryNotes: dietaryNotes,
          allergies: allergies,
          emergencyContactName: emergencyContactName,
          emergencyContactPhone: emergencyContactPhone,
          enrollmentDate: enrollmentDate,
          status: status,
          createdAt: createdAt,
          updatedAt: updatedAt,
          deletedAt: deletedAt,
        );

  /// Returns a shallow copy of this [Child]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Child copyWith({
    Object? id = _Undefined,
    int? organizationId,
    String? firstName,
    String? lastName,
    DateTime? dateOfBirth,
    Object? gender = _Undefined,
    Object? photoUrl = _Undefined,
    Object? medicalNotes = _Undefined,
    Object? dietaryNotes = _Undefined,
    Object? allergies = _Undefined,
    Object? emergencyContactName = _Undefined,
    Object? emergencyContactPhone = _Undefined,
    Object? enrollmentDate = _Undefined,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? deletedAt = _Undefined,
  }) {
    return Child(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender is String? ? gender : this.gender,
      photoUrl: photoUrl is String? ? photoUrl : this.photoUrl,
      medicalNotes: medicalNotes is String? ? medicalNotes : this.medicalNotes,
      dietaryNotes: dietaryNotes is String? ? dietaryNotes : this.dietaryNotes,
      allergies: allergies is String? ? allergies : this.allergies,
      emergencyContactName: emergencyContactName is String?
          ? emergencyContactName
          : this.emergencyContactName,
      emergencyContactPhone: emergencyContactPhone is String?
          ? emergencyContactPhone
          : this.emergencyContactPhone,
      enrollmentDate:
          enrollmentDate is DateTime? ? enrollmentDate : this.enrollmentDate,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt is DateTime? ? deletedAt : this.deletedAt,
    );
  }
}
