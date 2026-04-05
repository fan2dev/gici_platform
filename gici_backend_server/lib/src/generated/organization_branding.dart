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

abstract class OrganizationBranding
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
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
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
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
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      organizationId: _i1.UuidValueJsonExtension.fromJson(
          jsonSerialization['organizationId']),
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

  static final t = OrganizationBrandingTable();

  static const db = OrganizationBrandingRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue organizationId;

  String? primaryColor;

  String? secondaryColor;

  String? logoUrl;

  String? logoDarkUrl;

  String? faviconUrl;

  String? customCss;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [OrganizationBranding]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OrganizationBranding copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? organizationId,
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
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
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

  static OrganizationBrandingInclude include() {
    return OrganizationBrandingInclude._();
  }

  static OrganizationBrandingIncludeList includeList({
    _i1.WhereExpressionBuilder<OrganizationBrandingTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrganizationBrandingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrganizationBrandingTable>? orderByList,
    OrganizationBrandingInclude? include,
  }) {
    return OrganizationBrandingIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OrganizationBranding.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(OrganizationBranding.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OrganizationBrandingImpl extends OrganizationBranding {
  _OrganizationBrandingImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
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
    _i1.UuidValue? organizationId,
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
      id: id is _i1.UuidValue? ? id : this.id,
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

class OrganizationBrandingTable extends _i1.Table<_i1.UuidValue?> {
  OrganizationBrandingTable({super.tableRelation})
      : super(tableName: 'organization_branding') {
    organizationId = _i1.ColumnUuid(
      'organizationId',
      this,
    );
    primaryColor = _i1.ColumnString(
      'primaryColor',
      this,
    );
    secondaryColor = _i1.ColumnString(
      'secondaryColor',
      this,
    );
    logoUrl = _i1.ColumnString(
      'logoUrl',
      this,
    );
    logoDarkUrl = _i1.ColumnString(
      'logoDarkUrl',
      this,
    );
    faviconUrl = _i1.ColumnString(
      'faviconUrl',
      this,
    );
    customCss = _i1.ColumnString(
      'customCss',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final _i1.ColumnUuid organizationId;

  late final _i1.ColumnString primaryColor;

  late final _i1.ColumnString secondaryColor;

  late final _i1.ColumnString logoUrl;

  late final _i1.ColumnString logoDarkUrl;

  late final _i1.ColumnString faviconUrl;

  late final _i1.ColumnString customCss;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        organizationId,
        primaryColor,
        secondaryColor,
        logoUrl,
        logoDarkUrl,
        faviconUrl,
        customCss,
        createdAt,
        updatedAt,
      ];
}

class OrganizationBrandingInclude extends _i1.IncludeObject {
  OrganizationBrandingInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => OrganizationBranding.t;
}

class OrganizationBrandingIncludeList extends _i1.IncludeList {
  OrganizationBrandingIncludeList._({
    _i1.WhereExpressionBuilder<OrganizationBrandingTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(OrganizationBranding.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => OrganizationBranding.t;
}

class OrganizationBrandingRepository {
  const OrganizationBrandingRepository._();

  /// Returns a list of [OrganizationBranding]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<OrganizationBranding>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OrganizationBrandingTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrganizationBrandingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrganizationBrandingTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<OrganizationBranding>(
      where: where?.call(OrganizationBranding.t),
      orderBy: orderBy?.call(OrganizationBranding.t),
      orderByList: orderByList?.call(OrganizationBranding.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [OrganizationBranding] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<OrganizationBranding?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OrganizationBrandingTable>? where,
    int? offset,
    _i1.OrderByBuilder<OrganizationBrandingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrganizationBrandingTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<OrganizationBranding>(
      where: where?.call(OrganizationBranding.t),
      orderBy: orderBy?.call(OrganizationBranding.t),
      orderByList: orderByList?.call(OrganizationBranding.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [OrganizationBranding] by its [id] or null if no such row exists.
  Future<OrganizationBranding?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<OrganizationBranding>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [OrganizationBranding]s in the list and returns the inserted rows.
  ///
  /// The returned [OrganizationBranding]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<OrganizationBranding>> insert(
    _i1.Session session,
    List<OrganizationBranding> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<OrganizationBranding>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [OrganizationBranding] and returns the inserted row.
  ///
  /// The returned [OrganizationBranding] will have its `id` field set.
  Future<OrganizationBranding> insertRow(
    _i1.Session session,
    OrganizationBranding row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<OrganizationBranding>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [OrganizationBranding]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<OrganizationBranding>> update(
    _i1.Session session,
    List<OrganizationBranding> rows, {
    _i1.ColumnSelections<OrganizationBrandingTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<OrganizationBranding>(
      rows,
      columns: columns?.call(OrganizationBranding.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OrganizationBranding]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<OrganizationBranding> updateRow(
    _i1.Session session,
    OrganizationBranding row, {
    _i1.ColumnSelections<OrganizationBrandingTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<OrganizationBranding>(
      row,
      columns: columns?.call(OrganizationBranding.t),
      transaction: transaction,
    );
  }

  /// Deletes all [OrganizationBranding]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<OrganizationBranding>> delete(
    _i1.Session session,
    List<OrganizationBranding> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<OrganizationBranding>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [OrganizationBranding].
  Future<OrganizationBranding> deleteRow(
    _i1.Session session,
    OrganizationBranding row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<OrganizationBranding>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<OrganizationBranding>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<OrganizationBrandingTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<OrganizationBranding>(
      where: where(OrganizationBranding.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OrganizationBrandingTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<OrganizationBranding>(
      where: where?.call(OrganizationBranding.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
