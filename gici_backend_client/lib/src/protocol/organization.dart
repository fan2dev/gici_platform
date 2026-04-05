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

abstract class Organization implements _i1.SerializableModel {
  Organization._({
    this.id,
    required this.name,
    this.legalName,
    required this.slug,
    required this.contactEmail,
    this.contactPhone,
    this.address,
    this.city,
    this.postalCode,
    this.country,
    this.taxId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Organization({
    int? id,
    required String name,
    String? legalName,
    required String slug,
    required String contactEmail,
    String? contactPhone,
    String? address,
    String? city,
    String? postalCode,
    String? country,
    String? taxId,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) = _OrganizationImpl;

  factory Organization.fromJson(Map<String, dynamic> jsonSerialization) {
    return Organization(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      legalName: jsonSerialization['legalName'] as String?,
      slug: jsonSerialization['slug'] as String,
      contactEmail: jsonSerialization['contactEmail'] as String,
      contactPhone: jsonSerialization['contactPhone'] as String?,
      address: jsonSerialization['address'] as String?,
      city: jsonSerialization['city'] as String?,
      postalCode: jsonSerialization['postalCode'] as String?,
      country: jsonSerialization['country'] as String?,
      taxId: jsonSerialization['taxId'] as String?,
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

  String name;

  String? legalName;

  String slug;

  String contactEmail;

  String? contactPhone;

  String? address;

  String? city;

  String? postalCode;

  String? country;

  String? taxId;

  String status;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime? deletedAt;

  /// Returns a shallow copy of this [Organization]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Organization copyWith({
    int? id,
    String? name,
    String? legalName,
    String? slug,
    String? contactEmail,
    String? contactPhone,
    String? address,
    String? city,
    String? postalCode,
    String? country,
    String? taxId,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      if (legalName != null) 'legalName': legalName,
      'slug': slug,
      'contactEmail': contactEmail,
      if (contactPhone != null) 'contactPhone': contactPhone,
      if (address != null) 'address': address,
      if (city != null) 'city': city,
      if (postalCode != null) 'postalCode': postalCode,
      if (country != null) 'country': country,
      if (taxId != null) 'taxId': taxId,
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

class _OrganizationImpl extends Organization {
  _OrganizationImpl({
    int? id,
    required String name,
    String? legalName,
    required String slug,
    required String contactEmail,
    String? contactPhone,
    String? address,
    String? city,
    String? postalCode,
    String? country,
    String? taxId,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) : super._(
          id: id,
          name: name,
          legalName: legalName,
          slug: slug,
          contactEmail: contactEmail,
          contactPhone: contactPhone,
          address: address,
          city: city,
          postalCode: postalCode,
          country: country,
          taxId: taxId,
          status: status,
          createdAt: createdAt,
          updatedAt: updatedAt,
          deletedAt: deletedAt,
        );

  /// Returns a shallow copy of this [Organization]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Organization copyWith({
    Object? id = _Undefined,
    String? name,
    Object? legalName = _Undefined,
    String? slug,
    String? contactEmail,
    Object? contactPhone = _Undefined,
    Object? address = _Undefined,
    Object? city = _Undefined,
    Object? postalCode = _Undefined,
    Object? country = _Undefined,
    Object? taxId = _Undefined,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? deletedAt = _Undefined,
  }) {
    return Organization(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      legalName: legalName is String? ? legalName : this.legalName,
      slug: slug ?? this.slug,
      contactEmail: contactEmail ?? this.contactEmail,
      contactPhone: contactPhone is String? ? contactPhone : this.contactPhone,
      address: address is String? ? address : this.address,
      city: city is String? ? city : this.city,
      postalCode: postalCode is String? ? postalCode : this.postalCode,
      country: country is String? ? country : this.country,
      taxId: taxId is String? ? taxId : this.taxId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt is DateTime? ? deletedAt : this.deletedAt,
    );
  }
}
