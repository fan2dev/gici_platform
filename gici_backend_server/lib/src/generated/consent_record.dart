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

abstract class ConsentRecord
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  ConsentRecord._({
    this.id,
    required this.organizationId,
    required this.userId,
    this.childId,
    required this.consentType,
    required this.isAccepted,
    this.acceptedAt,
    this.ipAddress,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ConsentRecord({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    required _i1.UuidValue userId,
    _i1.UuidValue? childId,
    required String consentType,
    required bool isAccepted,
    DateTime? acceptedAt,
    String? ipAddress,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ConsentRecordImpl;

  factory ConsentRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return ConsentRecord(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      organizationId: _i1.UuidValueJsonExtension.fromJson(
          jsonSerialization['organizationId']),
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      childId: jsonSerialization['childId'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['childId']),
      consentType: jsonSerialization['consentType'] as String,
      isAccepted: jsonSerialization['isAccepted'] as bool,
      acceptedAt: jsonSerialization['acceptedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['acceptedAt']),
      ipAddress: jsonSerialization['ipAddress'] as String?,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = ConsentRecordTable();

  static const db = ConsentRecordRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue organizationId;

  _i1.UuidValue userId;

  _i1.UuidValue? childId;

  String consentType;

  bool isAccepted;

  DateTime? acceptedAt;

  String? ipAddress;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [ConsentRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ConsentRecord copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? organizationId,
    _i1.UuidValue? userId,
    _i1.UuidValue? childId,
    String? consentType,
    bool? isAccepted,
    DateTime? acceptedAt,
    String? ipAddress,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      'userId': userId.toJson(),
      if (childId != null) 'childId': childId?.toJson(),
      'consentType': consentType,
      'isAccepted': isAccepted,
      if (acceptedAt != null) 'acceptedAt': acceptedAt?.toJson(),
      if (ipAddress != null) 'ipAddress': ipAddress,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      'userId': userId.toJson(),
      if (childId != null) 'childId': childId?.toJson(),
      'consentType': consentType,
      'isAccepted': isAccepted,
      if (acceptedAt != null) 'acceptedAt': acceptedAt?.toJson(),
      if (ipAddress != null) 'ipAddress': ipAddress,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static ConsentRecordInclude include() {
    return ConsentRecordInclude._();
  }

  static ConsentRecordIncludeList includeList({
    _i1.WhereExpressionBuilder<ConsentRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ConsentRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ConsentRecordTable>? orderByList,
    ConsentRecordInclude? include,
  }) {
    return ConsentRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ConsentRecord.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ConsentRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ConsentRecordImpl extends ConsentRecord {
  _ConsentRecordImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    required _i1.UuidValue userId,
    _i1.UuidValue? childId,
    required String consentType,
    required bool isAccepted,
    DateTime? acceptedAt,
    String? ipAddress,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          userId: userId,
          childId: childId,
          consentType: consentType,
          isAccepted: isAccepted,
          acceptedAt: acceptedAt,
          ipAddress: ipAddress,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [ConsentRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ConsentRecord copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? organizationId,
    _i1.UuidValue? userId,
    Object? childId = _Undefined,
    String? consentType,
    bool? isAccepted,
    Object? acceptedAt = _Undefined,
    Object? ipAddress = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ConsentRecord(
      id: id is _i1.UuidValue? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      userId: userId ?? this.userId,
      childId: childId is _i1.UuidValue? ? childId : this.childId,
      consentType: consentType ?? this.consentType,
      isAccepted: isAccepted ?? this.isAccepted,
      acceptedAt: acceptedAt is DateTime? ? acceptedAt : this.acceptedAt,
      ipAddress: ipAddress is String? ? ipAddress : this.ipAddress,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ConsentRecordTable extends _i1.Table<_i1.UuidValue?> {
  ConsentRecordTable({super.tableRelation})
      : super(tableName: 'consent_record') {
    organizationId = _i1.ColumnUuid(
      'organizationId',
      this,
    );
    userId = _i1.ColumnUuid(
      'userId',
      this,
    );
    childId = _i1.ColumnUuid(
      'childId',
      this,
    );
    consentType = _i1.ColumnString(
      'consentType',
      this,
    );
    isAccepted = _i1.ColumnBool(
      'isAccepted',
      this,
    );
    acceptedAt = _i1.ColumnDateTime(
      'acceptedAt',
      this,
    );
    ipAddress = _i1.ColumnString(
      'ipAddress',
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

  late final _i1.ColumnUuid userId;

  late final _i1.ColumnUuid childId;

  late final _i1.ColumnString consentType;

  late final _i1.ColumnBool isAccepted;

  late final _i1.ColumnDateTime acceptedAt;

  late final _i1.ColumnString ipAddress;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        organizationId,
        userId,
        childId,
        consentType,
        isAccepted,
        acceptedAt,
        ipAddress,
        createdAt,
        updatedAt,
      ];
}

class ConsentRecordInclude extends _i1.IncludeObject {
  ConsentRecordInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => ConsentRecord.t;
}

class ConsentRecordIncludeList extends _i1.IncludeList {
  ConsentRecordIncludeList._({
    _i1.WhereExpressionBuilder<ConsentRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ConsentRecord.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => ConsentRecord.t;
}

class ConsentRecordRepository {
  const ConsentRecordRepository._();

  /// Returns a list of [ConsentRecord]s matching the given query parameters.
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
  Future<List<ConsentRecord>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ConsentRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ConsentRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ConsentRecordTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<ConsentRecord>(
      where: where?.call(ConsentRecord.t),
      orderBy: orderBy?.call(ConsentRecord.t),
      orderByList: orderByList?.call(ConsentRecord.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [ConsentRecord] matching the given query parameters.
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
  Future<ConsentRecord?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ConsentRecordTable>? where,
    int? offset,
    _i1.OrderByBuilder<ConsentRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ConsentRecordTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<ConsentRecord>(
      where: where?.call(ConsentRecord.t),
      orderBy: orderBy?.call(ConsentRecord.t),
      orderByList: orderByList?.call(ConsentRecord.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [ConsentRecord] by its [id] or null if no such row exists.
  Future<ConsentRecord?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<ConsentRecord>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [ConsentRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [ConsentRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ConsentRecord>> insert(
    _i1.Session session,
    List<ConsentRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ConsentRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ConsentRecord] and returns the inserted row.
  ///
  /// The returned [ConsentRecord] will have its `id` field set.
  Future<ConsentRecord> insertRow(
    _i1.Session session,
    ConsentRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ConsentRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ConsentRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ConsentRecord>> update(
    _i1.Session session,
    List<ConsentRecord> rows, {
    _i1.ColumnSelections<ConsentRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ConsentRecord>(
      rows,
      columns: columns?.call(ConsentRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ConsentRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ConsentRecord> updateRow(
    _i1.Session session,
    ConsentRecord row, {
    _i1.ColumnSelections<ConsentRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ConsentRecord>(
      row,
      columns: columns?.call(ConsentRecord.t),
      transaction: transaction,
    );
  }

  /// Deletes all [ConsentRecord]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ConsentRecord>> delete(
    _i1.Session session,
    List<ConsentRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ConsentRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ConsentRecord].
  Future<ConsentRecord> deleteRow(
    _i1.Session session,
    ConsentRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ConsentRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ConsentRecord>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ConsentRecordTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ConsentRecord>(
      where: where(ConsentRecord.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ConsentRecordTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ConsentRecord>(
      where: where?.call(ConsentRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
