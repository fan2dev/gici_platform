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

abstract class OrganizationBranding implements _i1.SerializableModel {
  OrganizationBranding._({
    this.id,
    required this.organizationId,
    this.primaryColor,
    this.secondaryColor,
    this.logoUrl,
    this.logoDarkUrl,
    this.faviconUrl,
    this.customCss,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrganizationBranding({
    int? id,
    required int organizationId,
    String? primaryColor,
    String? secondaryColor,
    String? logoUrl,
    String? logoDarkUrl,
    String? faviconUrl,
    String? customCss,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _OrganizationBrandingImpl;

  factory OrganizationBranding.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return OrganizationBranding(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      primaryColor: jsonSerialization['primaryColor'] as String?,
      secondaryColor: jsonSerialization['secondaryColor'] as String?,
      logoUrl: jsonSerialization['logoUrl'] as String?,
      logoDarkUrl: jsonSerialization['logoDarkUrl'] as String?,
      faviconUrl: jsonSerialization['faviconUrl'] as String?,
      customCss: jsonSerialization['customCss'] as String?,
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

  String? primaryColor;

  String? secondaryColor;

  String? logoUrl;

  String? logoDarkUrl;

  String? faviconUrl;

  String? customCss;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [OrganizationBranding]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OrganizationBranding copyWith({
    int? id,
    int? organizationId,
    String? primaryColor,
    String? secondaryColor,
    String? logoUrl,
    String? logoDarkUrl,
    String? faviconUrl,
    String? customCss,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'organizationId': organizationId,
      if (primaryColor != null) 'primaryColor': primaryColor,
      if (secondaryColor != null) 'secondaryColor': secondaryColor,
      if (logoUrl != null) 'logoUrl': logoUrl,
      if (logoDarkUrl != null) 'logoDarkUrl': logoDarkUrl,
      if (faviconUrl != null) 'faviconUrl': faviconUrl,
      if (customCss != null) 'customCss': customCss,
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

class _OrganizationBrandingImpl extends OrganizationBranding {
  _OrganizationBrandingImpl({
    int? id,
    required int organizationId,
    String? primaryColor,
    String? secondaryColor,
    String? logoUrl,
    String? logoDarkUrl,
    String? faviconUrl,
    String? customCss,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          primaryColor: primaryColor,
          secondaryColor: secondaryColor,
          logoUrl: logoUrl,
          logoDarkUrl: logoDarkUrl,
          faviconUrl: faviconUrl,
          customCss: customCss,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [OrganizationBranding]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OrganizationBranding copyWith({
    Object? id = _Undefined,
    int? organizationId,
    Object? primaryColor = _Undefined,
    Object? secondaryColor = _Undefined,
    Object? logoUrl = _Undefined,
    Object? logoDarkUrl = _Undefined,
    Object? faviconUrl = _Undefined,
    Object? customCss = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return OrganizationBranding(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      primaryColor: primaryColor is String? ? primaryColor : this.primaryColor,
      secondaryColor:
          secondaryColor is String? ? secondaryColor : this.secondaryColor,
      logoUrl: logoUrl is String? ? logoUrl : this.logoUrl,
      logoDarkUrl: logoDarkUrl is String? ? logoDarkUrl : this.logoDarkUrl,
      faviconUrl: faviconUrl is String? ? faviconUrl : this.faviconUrl,
      customCss: customCss is String? ? customCss : this.customCss,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
