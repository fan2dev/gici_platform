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

abstract class Tariff
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  Tariff._({
    this.id,
    required this.organizationId,
    required this.name,
    this.description,
    required this.schedule,
    required this.monthlyPrice,
    required this.includesTransport,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Tariff({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    required String name,
    String? description,
    required String schedule,
    required double monthlyPrice,
    required bool includesTransport,
    required bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) = _TariffImpl;

  factory Tariff.fromJson(Map<String, dynamic> jsonSerialization) {
    return Tariff(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      organizationId: _i1.UuidValueJsonExtension.fromJson(
          jsonSerialization['organizationId']),
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      schedule: jsonSerialization['schedule'] as String,
      monthlyPrice: (jsonSerialization['monthlyPrice'] as num).toDouble(),
      includesTransport: jsonSerialization['includesTransport'] as bool,
      isActive: jsonSerialization['isActive'] as bool,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      deletedAt: jsonSerialization['deletedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['deletedAt']),
    );
  }

  static final t = TariffTable();

  static const db = TariffRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue organizationId;

  String name;

  String? description;

  String schedule;

  double monthlyPrice;

  bool includesTransport;

  bool isActive;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime? deletedAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [Tariff]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Tariff copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? organizationId,
    String? name,
    String? description,
    String? schedule,
    double? monthlyPrice,
    bool? includesTransport,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      'name': name,
      if (description != null) 'description': description,
      'schedule': schedule,
      'monthlyPrice': monthlyPrice,
      'includesTransport': includesTransport,
      'isActive': isActive,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (deletedAt != null) 'deletedAt': deletedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      'name': name,
      if (description != null) 'description': description,
      'schedule': schedule,
      'monthlyPrice': monthlyPrice,
      'includesTransport': includesTransport,
      'isActive': isActive,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (deletedAt != null) 'deletedAt': deletedAt?.toJson(),
    };
  }

  static TariffInclude include() {
    return TariffInclude._();
  }

  static TariffIncludeList includeList({
    _i1.WhereExpressionBuilder<TariffTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TariffTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TariffTable>? orderByList,
    TariffInclude? include,
  }) {
    return TariffIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Tariff.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Tariff.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TariffImpl extends Tariff {
  _TariffImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    required String name,
    String? description,
    required String schedule,
    required double monthlyPrice,
    required bool includesTransport,
    required bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          name: name,
          description: description,
          schedule: schedule,
          monthlyPrice: monthlyPrice,
          includesTransport: includesTransport,
          isActive: isActive,
          createdAt: createdAt,
          updatedAt: updatedAt,
          deletedAt: deletedAt,
        );

  /// Returns a shallow copy of this [Tariff]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Tariff copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? organizationId,
    String? name,
    Object? description = _Undefined,
    String? schedule,
    double? monthlyPrice,
    bool? includesTransport,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? deletedAt = _Undefined,
  }) {
    return Tariff(
      id: id is _i1.UuidValue? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      schedule: schedule ?? this.schedule,
      monthlyPrice: monthlyPrice ?? this.monthlyPrice,
      includesTransport: includesTransport ?? this.includesTransport,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt is DateTime? ? deletedAt : this.deletedAt,
    );
  }
}

class TariffTable extends _i1.Table<_i1.UuidValue?> {
  TariffTable({super.tableRelation}) : super(tableName: 'tariff') {
    organizationId = _i1.ColumnUuid(
      'organizationId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    schedule = _i1.ColumnString(
      'schedule',
      this,
    );
    monthlyPrice = _i1.ColumnDouble(
      'monthlyPrice',
      this,
    );
    includesTransport = _i1.ColumnBool(
      'includesTransport',
      this,
    );
    isActive = _i1.ColumnBool(
      'isActive',
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

  late final _i1.ColumnUuid organizationId;

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnString schedule;

  late final _i1.ColumnDouble monthlyPrice;

  late final _i1.ColumnBool includesTransport;

  late final _i1.ColumnBool isActive;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnDateTime deletedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        organizationId,
        name,
        description,
        schedule,
        monthlyPrice,
        includesTransport,
        isActive,
        createdAt,
        updatedAt,
        deletedAt,
      ];
}

class TariffInclude extends _i1.IncludeObject {
  TariffInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => Tariff.t;
}

class TariffIncludeList extends _i1.IncludeList {
  TariffIncludeList._({
    _i1.WhereExpressionBuilder<TariffTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Tariff.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => Tariff.t;
}

class TariffRepository {
  const TariffRepository._();

  /// Returns a list of [Tariff]s matching the given query parameters.
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
  Future<List<Tariff>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TariffTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TariffTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TariffTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Tariff>(
      where: where?.call(Tariff.t),
      orderBy: orderBy?.call(Tariff.t),
      orderByList: orderByList?.call(Tariff.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Tariff] matching the given query parameters.
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
  Future<Tariff?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TariffTable>? where,
    int? offset,
    _i1.OrderByBuilder<TariffTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TariffTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Tariff>(
      where: where?.call(Tariff.t),
      orderBy: orderBy?.call(Tariff.t),
      orderByList: orderByList?.call(Tariff.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Tariff] by its [id] or null if no such row exists.
  Future<Tariff?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Tariff>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Tariff]s in the list and returns the inserted rows.
  ///
  /// The returned [Tariff]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Tariff>> insert(
    _i1.Session session,
    List<Tariff> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Tariff>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Tariff] and returns the inserted row.
  ///
  /// The returned [Tariff] will have its `id` field set.
  Future<Tariff> insertRow(
    _i1.Session session,
    Tariff row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Tariff>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Tariff]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Tariff>> update(
    _i1.Session session,
    List<Tariff> rows, {
    _i1.ColumnSelections<TariffTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Tariff>(
      rows,
      columns: columns?.call(Tariff.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Tariff]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Tariff> updateRow(
    _i1.Session session,
    Tariff row, {
    _i1.ColumnSelections<TariffTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Tariff>(
      row,
      columns: columns?.call(Tariff.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Tariff]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Tariff>> delete(
    _i1.Session session,
    List<Tariff> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Tariff>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Tariff].
  Future<Tariff> deleteRow(
    _i1.Session session,
    Tariff row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Tariff>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Tariff>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<TariffTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Tariff>(
      where: where(Tariff.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TariffTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Tariff>(
      where: where?.call(Tariff.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
