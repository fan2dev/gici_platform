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

abstract class Organization
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
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
    _i1.UuidValue? id,
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
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
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

  static final t = OrganizationTable();

  static const db = OrganizationRepository._();

  @override
  _i1.UuidValue? id;

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

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [Organization]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Organization copyWith({
    _i1.UuidValue? id,
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
      if (id != null) 'id': id?.toJson(),
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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id?.toJson(),
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

  static OrganizationInclude include() {
    return OrganizationInclude._();
  }

  static OrganizationIncludeList includeList({
    _i1.WhereExpressionBuilder<OrganizationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrganizationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrganizationTable>? orderByList,
    OrganizationInclude? include,
  }) {
    return OrganizationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Organization.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Organization.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OrganizationImpl extends Organization {
  _OrganizationImpl({
    _i1.UuidValue? id,
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
      id: id is _i1.UuidValue? ? id : this.id,
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

class OrganizationTable extends _i1.Table<_i1.UuidValue?> {
  OrganizationTable({super.tableRelation}) : super(tableName: 'organization') {
    name = _i1.ColumnString(
      'name',
      this,
    );
    legalName = _i1.ColumnString(
      'legalName',
      this,
    );
    slug = _i1.ColumnString(
      'slug',
      this,
    );
    contactEmail = _i1.ColumnString(
      'contactEmail',
      this,
    );
    contactPhone = _i1.ColumnString(
      'contactPhone',
      this,
    );
    address = _i1.ColumnString(
      'address',
      this,
    );
    city = _i1.ColumnString(
      'city',
      this,
    );
    postalCode = _i1.ColumnString(
      'postalCode',
      this,
    );
    country = _i1.ColumnString(
      'country',
      this,
    );
    taxId = _i1.ColumnString(
      'taxId',
      this,
    );
    status = _i1.ColumnString(
      'status',
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
    deletedAt = _i1.ColumnDateTime(
      'deletedAt',
      this,
    );
  }

  late final _i1.ColumnString name;

  late final _i1.ColumnString legalName;

  late final _i1.ColumnString slug;

  late final _i1.ColumnString contactEmail;

  late final _i1.ColumnString contactPhone;

  late final _i1.ColumnString address;

  late final _i1.ColumnString city;

  late final _i1.ColumnString postalCode;

  late final _i1.ColumnString country;

  late final _i1.ColumnString taxId;

  late final _i1.ColumnString status;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnDateTime deletedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        legalName,
        slug,
        contactEmail,
        contactPhone,
        address,
        city,
        postalCode,
        country,
        taxId,
        status,
        createdAt,
        updatedAt,
        deletedAt,
      ];
}

class OrganizationInclude extends _i1.IncludeObject {
  OrganizationInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => Organization.t;
}

class OrganizationIncludeList extends _i1.IncludeList {
  OrganizationIncludeList._({
    _i1.WhereExpressionBuilder<OrganizationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Organization.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => Organization.t;
}

class OrganizationRepository {
  const OrganizationRepository._();

  /// Returns a list of [Organization]s matching the given query parameters.
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
  Future<List<Organization>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OrganizationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrganizationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrganizationTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Organization>(
      where: where?.call(Organization.t),
      orderBy: orderBy?.call(Organization.t),
      orderByList: orderByList?.call(Organization.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Organization] matching the given query parameters.
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
  Future<Organization?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OrganizationTable>? where,
    int? offset,
    _i1.OrderByBuilder<OrganizationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrganizationTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Organization>(
      where: where?.call(Organization.t),
      orderBy: orderBy?.call(Organization.t),
      orderByList: orderByList?.call(Organization.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Organization] by its [id] or null if no such row exists.
  Future<Organization?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Organization>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Organization]s in the list and returns the inserted rows.
  ///
  /// The returned [Organization]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Organization>> insert(
    _i1.Session session,
    List<Organization> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Organization>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Organization] and returns the inserted row.
  ///
  /// The returned [Organization] will have its `id` field set.
  Future<Organization> insertRow(
    _i1.Session session,
    Organization row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Organization>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Organization]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Organization>> update(
    _i1.Session session,
    List<Organization> rows, {
    _i1.ColumnSelections<OrganizationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Organization>(
      rows,
      columns: columns?.call(Organization.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Organization]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Organization> updateRow(
    _i1.Session session,
    Organization row, {
    _i1.ColumnSelections<OrganizationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Organization>(
      row,
      columns: columns?.call(Organization.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Organization]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Organization>> delete(
    _i1.Session session,
    List<Organization> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Organization>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Organization].
  Future<Organization> deleteRow(
    _i1.Session session,
    Organization row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Organization>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Organization>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<OrganizationTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Organization>(
      where: where(Organization.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OrganizationTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Organization>(
      where: where?.call(Organization.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
