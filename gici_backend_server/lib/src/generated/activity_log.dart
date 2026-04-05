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

abstract class ActivityLog
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  ActivityLog._({
    this.id,
    required this.organizationId,
    this.userId,
    required this.action,
    this.entityType,
    this.entityId,
    this.oldValues,
    this.newValues,
    this.ipAddress,
    this.userAgent,
    this.metadata,
    required this.createdAt,
  });

  factory ActivityLog({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    _i1.UuidValue? userId,
    required String action,
    String? entityType,
    String? entityId,
    String? oldValues,
    String? newValues,
    String? ipAddress,
    String? userAgent,
    String? metadata,
    required DateTime createdAt,
  }) = _ActivityLogImpl;

  factory ActivityLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return ActivityLog(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      organizationId: _i1.UuidValueJsonExtension.fromJson(
          jsonSerialization['organizationId']),
      userId: jsonSerialization['userId'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      action: jsonSerialization['action'] as String,
      entityType: jsonSerialization['entityType'] as String?,
      entityId: jsonSerialization['entityId'] as String?,
      oldValues: jsonSerialization['oldValues'] as String?,
      newValues: jsonSerialization['newValues'] as String?,
      ipAddress: jsonSerialization['ipAddress'] as String?,
      userAgent: jsonSerialization['userAgent'] as String?,
      metadata: jsonSerialization['metadata'] as String?,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = ActivityLogTable();

  static const db = ActivityLogRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue organizationId;

  _i1.UuidValue? userId;

  String action;

  String? entityType;

  String? entityId;

  String? oldValues;

  String? newValues;

  String? ipAddress;

  String? userAgent;

  String? metadata;

  DateTime createdAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [ActivityLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ActivityLog copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? organizationId,
    _i1.UuidValue? userId,
    String? action,
    String? entityType,
    String? entityId,
    String? oldValues,
    String? newValues,
    String? ipAddress,
    String? userAgent,
    String? metadata,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      if (userId != null) 'userId': userId?.toJson(),
      'action': action,
      if (entityType != null) 'entityType': entityType,
      if (entityId != null) 'entityId': entityId,
      if (oldValues != null) 'oldValues': oldValues,
      if (newValues != null) 'newValues': newValues,
      if (ipAddress != null) 'ipAddress': ipAddress,
      if (userAgent != null) 'userAgent': userAgent,
      if (metadata != null) 'metadata': metadata,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      if (userId != null) 'userId': userId?.toJson(),
      'action': action,
      if (entityType != null) 'entityType': entityType,
      if (entityId != null) 'entityId': entityId,
      if (oldValues != null) 'oldValues': oldValues,
      if (newValues != null) 'newValues': newValues,
      if (ipAddress != null) 'ipAddress': ipAddress,
      if (userAgent != null) 'userAgent': userAgent,
      if (metadata != null) 'metadata': metadata,
      'createdAt': createdAt.toJson(),
    };
  }

  static ActivityLogInclude include() {
    return ActivityLogInclude._();
  }

  static ActivityLogIncludeList includeList({
    _i1.WhereExpressionBuilder<ActivityLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ActivityLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ActivityLogTable>? orderByList,
    ActivityLogInclude? include,
  }) {
    return ActivityLogIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ActivityLog.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ActivityLog.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ActivityLogImpl extends ActivityLog {
  _ActivityLogImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    _i1.UuidValue? userId,
    required String action,
    String? entityType,
    String? entityId,
    String? oldValues,
    String? newValues,
    String? ipAddress,
    String? userAgent,
    String? metadata,
    required DateTime createdAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          userId: userId,
          action: action,
          entityType: entityType,
          entityId: entityId,
          oldValues: oldValues,
          newValues: newValues,
          ipAddress: ipAddress,
          userAgent: userAgent,
          metadata: metadata,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [ActivityLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ActivityLog copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? organizationId,
    Object? userId = _Undefined,
    String? action,
    Object? entityType = _Undefined,
    Object? entityId = _Undefined,
    Object? oldValues = _Undefined,
    Object? newValues = _Undefined,
    Object? ipAddress = _Undefined,
    Object? userAgent = _Undefined,
    Object? metadata = _Undefined,
    DateTime? createdAt,
  }) {
    return ActivityLog(
      id: id is _i1.UuidValue? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      userId: userId is _i1.UuidValue? ? userId : this.userId,
      action: action ?? this.action,
      entityType: entityType is String? ? entityType : this.entityType,
      entityId: entityId is String? ? entityId : this.entityId,
      oldValues: oldValues is String? ? oldValues : this.oldValues,
      newValues: newValues is String? ? newValues : this.newValues,
      ipAddress: ipAddress is String? ? ipAddress : this.ipAddress,
      userAgent: userAgent is String? ? userAgent : this.userAgent,
      metadata: metadata is String? ? metadata : this.metadata,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class ActivityLogTable extends _i1.Table<_i1.UuidValue?> {
  ActivityLogTable({super.tableRelation}) : super(tableName: 'activity_log') {
    organizationId = _i1.ColumnUuid(
      'organizationId',
      this,
    );
    userId = _i1.ColumnUuid(
      'userId',
      this,
    );
    action = _i1.ColumnString(
      'action',
      this,
    );
    entityType = _i1.ColumnString(
      'entityType',
      this,
    );
    entityId = _i1.ColumnString(
      'entityId',
      this,
    );
    oldValues = _i1.ColumnString(
      'oldValues',
      this,
    );
    newValues = _i1.ColumnString(
      'newValues',
      this,
    );
    ipAddress = _i1.ColumnString(
      'ipAddress',
      this,
    );
    userAgent = _i1.ColumnString(
      'userAgent',
      this,
    );
    metadata = _i1.ColumnString(
      'metadata',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final _i1.ColumnUuid organizationId;

  late final _i1.ColumnUuid userId;

  late final _i1.ColumnString action;

  late final _i1.ColumnString entityType;

  late final _i1.ColumnString entityId;

  late final _i1.ColumnString oldValues;

  late final _i1.ColumnString newValues;

  late final _i1.ColumnString ipAddress;

  late final _i1.ColumnString userAgent;

  late final _i1.ColumnString metadata;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
        id,
        organizationId,
        userId,
        action,
        entityType,
        entityId,
        oldValues,
        newValues,
        ipAddress,
        userAgent,
        metadata,
        createdAt,
      ];
}

class ActivityLogInclude extends _i1.IncludeObject {
  ActivityLogInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => ActivityLog.t;
}

class ActivityLogIncludeList extends _i1.IncludeList {
  ActivityLogIncludeList._({
    _i1.WhereExpressionBuilder<ActivityLogTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ActivityLog.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => ActivityLog.t;
}

class ActivityLogRepository {
  const ActivityLogRepository._();

  /// Returns a list of [ActivityLog]s matching the given query parameters.
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
  Future<List<ActivityLog>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ActivityLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ActivityLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ActivityLogTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<ActivityLog>(
      where: where?.call(ActivityLog.t),
      orderBy: orderBy?.call(ActivityLog.t),
      orderByList: orderByList?.call(ActivityLog.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [ActivityLog] matching the given query parameters.
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
  Future<ActivityLog?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ActivityLogTable>? where,
    int? offset,
    _i1.OrderByBuilder<ActivityLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ActivityLogTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<ActivityLog>(
      where: where?.call(ActivityLog.t),
      orderBy: orderBy?.call(ActivityLog.t),
      orderByList: orderByList?.call(ActivityLog.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [ActivityLog] by its [id] or null if no such row exists.
  Future<ActivityLog?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<ActivityLog>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [ActivityLog]s in the list and returns the inserted rows.
  ///
  /// The returned [ActivityLog]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ActivityLog>> insert(
    _i1.Session session,
    List<ActivityLog> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ActivityLog>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ActivityLog] and returns the inserted row.
  ///
  /// The returned [ActivityLog] will have its `id` field set.
  Future<ActivityLog> insertRow(
    _i1.Session session,
    ActivityLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ActivityLog>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ActivityLog]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ActivityLog>> update(
    _i1.Session session,
    List<ActivityLog> rows, {
    _i1.ColumnSelections<ActivityLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ActivityLog>(
      rows,
      columns: columns?.call(ActivityLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ActivityLog]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ActivityLog> updateRow(
    _i1.Session session,
    ActivityLog row, {
    _i1.ColumnSelections<ActivityLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ActivityLog>(
      row,
      columns: columns?.call(ActivityLog.t),
      transaction: transaction,
    );
  }

  /// Deletes all [ActivityLog]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ActivityLog>> delete(
    _i1.Session session,
    List<ActivityLog> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ActivityLog>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ActivityLog].
  Future<ActivityLog> deleteRow(
    _i1.Session session,
    ActivityLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ActivityLog>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ActivityLog>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ActivityLogTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ActivityLog>(
      where: where(ActivityLog.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ActivityLogTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ActivityLog>(
      where: where?.call(ActivityLog.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
