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

abstract class NotificationRecord
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  NotificationRecord._({
    this.id,
    required this.organizationId,
    required this.userId,
    required this.title,
    required this.body,
    required this.category,
    required this.targetScope,
    this.targetClassroomId,
    this.targetChildId,
    this.targetUserId,
    required this.createdByUserId,
    required this.isRead,
    this.readAt,
    required this.createdAt,
  });

  factory NotificationRecord({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    required _i1.UuidValue userId,
    required String title,
    required String body,
    required String category,
    required String targetScope,
    _i1.UuidValue? targetClassroomId,
    _i1.UuidValue? targetChildId,
    _i1.UuidValue? targetUserId,
    required _i1.UuidValue createdByUserId,
    required bool isRead,
    DateTime? readAt,
    required DateTime createdAt,
  }) = _NotificationRecordImpl;

  factory NotificationRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return NotificationRecord(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      organizationId: _i1.UuidValueJsonExtension.fromJson(
          jsonSerialization['organizationId']),
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      title: jsonSerialization['title'] as String,
      body: jsonSerialization['body'] as String,
      category: jsonSerialization['category'] as String,
      targetScope: jsonSerialization['targetScope'] as String,
      targetClassroomId: jsonSerialization['targetClassroomId'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(
              jsonSerialization['targetClassroomId']),
      targetChildId: jsonSerialization['targetChildId'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(
              jsonSerialization['targetChildId']),
      targetUserId: jsonSerialization['targetUserId'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(
              jsonSerialization['targetUserId']),
      createdByUserId: _i1.UuidValueJsonExtension.fromJson(
          jsonSerialization['createdByUserId']),
      isRead: jsonSerialization['isRead'] as bool,
      readAt: jsonSerialization['readAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['readAt']),
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = NotificationRecordTable();

  static const db = NotificationRecordRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue organizationId;

  _i1.UuidValue userId;

  String title;

  String body;

  String category;

  String targetScope;

  _i1.UuidValue? targetClassroomId;

  _i1.UuidValue? targetChildId;

  _i1.UuidValue? targetUserId;

  _i1.UuidValue createdByUserId;

  bool isRead;

  DateTime? readAt;

  DateTime createdAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [NotificationRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  NotificationRecord copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? organizationId,
    _i1.UuidValue? userId,
    String? title,
    String? body,
    String? category,
    String? targetScope,
    _i1.UuidValue? targetClassroomId,
    _i1.UuidValue? targetChildId,
    _i1.UuidValue? targetUserId,
    _i1.UuidValue? createdByUserId,
    bool? isRead,
    DateTime? readAt,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      'userId': userId.toJson(),
      'title': title,
      'body': body,
      'category': category,
      'targetScope': targetScope,
      if (targetClassroomId != null)
        'targetClassroomId': targetClassroomId?.toJson(),
      if (targetChildId != null) 'targetChildId': targetChildId?.toJson(),
      if (targetUserId != null) 'targetUserId': targetUserId?.toJson(),
      'createdByUserId': createdByUserId.toJson(),
      'isRead': isRead,
      if (readAt != null) 'readAt': readAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      'userId': userId.toJson(),
      'title': title,
      'body': body,
      'category': category,
      'targetScope': targetScope,
      if (targetClassroomId != null)
        'targetClassroomId': targetClassroomId?.toJson(),
      if (targetChildId != null) 'targetChildId': targetChildId?.toJson(),
      if (targetUserId != null) 'targetUserId': targetUserId?.toJson(),
      'createdByUserId': createdByUserId.toJson(),
      'isRead': isRead,
      if (readAt != null) 'readAt': readAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  static NotificationRecordInclude include() {
    return NotificationRecordInclude._();
  }

  static NotificationRecordIncludeList includeList({
    _i1.WhereExpressionBuilder<NotificationRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<NotificationRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<NotificationRecordTable>? orderByList,
    NotificationRecordInclude? include,
  }) {
    return NotificationRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(NotificationRecord.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(NotificationRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _NotificationRecordImpl extends NotificationRecord {
  _NotificationRecordImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    required _i1.UuidValue userId,
    required String title,
    required String body,
    required String category,
    required String targetScope,
    _i1.UuidValue? targetClassroomId,
    _i1.UuidValue? targetChildId,
    _i1.UuidValue? targetUserId,
    required _i1.UuidValue createdByUserId,
    required bool isRead,
    DateTime? readAt,
    required DateTime createdAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          userId: userId,
          title: title,
          body: body,
          category: category,
          targetScope: targetScope,
          targetClassroomId: targetClassroomId,
          targetChildId: targetChildId,
          targetUserId: targetUserId,
          createdByUserId: createdByUserId,
          isRead: isRead,
          readAt: readAt,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [NotificationRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  NotificationRecord copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? organizationId,
    _i1.UuidValue? userId,
    String? title,
    String? body,
    String? category,
    String? targetScope,
    Object? targetClassroomId = _Undefined,
    Object? targetChildId = _Undefined,
    Object? targetUserId = _Undefined,
    _i1.UuidValue? createdByUserId,
    bool? isRead,
    Object? readAt = _Undefined,
    DateTime? createdAt,
  }) {
    return NotificationRecord(
      id: id is _i1.UuidValue? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      body: body ?? this.body,
      category: category ?? this.category,
      targetScope: targetScope ?? this.targetScope,
      targetClassroomId: targetClassroomId is _i1.UuidValue?
          ? targetClassroomId
          : this.targetClassroomId,
      targetChildId:
          targetChildId is _i1.UuidValue? ? targetChildId : this.targetChildId,
      targetUserId:
          targetUserId is _i1.UuidValue? ? targetUserId : this.targetUserId,
      createdByUserId: createdByUserId ?? this.createdByUserId,
      isRead: isRead ?? this.isRead,
      readAt: readAt is DateTime? ? readAt : this.readAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class NotificationRecordTable extends _i1.Table<_i1.UuidValue?> {
  NotificationRecordTable({super.tableRelation})
      : super(tableName: 'notification_record') {
    organizationId = _i1.ColumnUuid(
      'organizationId',
      this,
    );
    userId = _i1.ColumnUuid(
      'userId',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    body = _i1.ColumnString(
      'body',
      this,
    );
    category = _i1.ColumnString(
      'category',
      this,
    );
    targetScope = _i1.ColumnString(
      'targetScope',
      this,
    );
    targetClassroomId = _i1.ColumnUuid(
      'targetClassroomId',
      this,
    );
    targetChildId = _i1.ColumnUuid(
      'targetChildId',
      this,
    );
    targetUserId = _i1.ColumnUuid(
      'targetUserId',
      this,
    );
    createdByUserId = _i1.ColumnUuid(
      'createdByUserId',
      this,
    );
    isRead = _i1.ColumnBool(
      'isRead',
      this,
    );
    readAt = _i1.ColumnDateTime(
      'readAt',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final _i1.ColumnUuid organizationId;

  late final _i1.ColumnUuid userId;

  late final _i1.ColumnString title;

  late final _i1.ColumnString body;

  late final _i1.ColumnString category;

  late final _i1.ColumnString targetScope;

  late final _i1.ColumnUuid targetClassroomId;

  late final _i1.ColumnUuid targetChildId;

  late final _i1.ColumnUuid targetUserId;

  late final _i1.ColumnUuid createdByUserId;

  late final _i1.ColumnBool isRead;

  late final _i1.ColumnDateTime readAt;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
        id,
        organizationId,
        userId,
        title,
        body,
        category,
        targetScope,
        targetClassroomId,
        targetChildId,
        targetUserId,
        createdByUserId,
        isRead,
        readAt,
        createdAt,
      ];
}

class NotificationRecordInclude extends _i1.IncludeObject {
  NotificationRecordInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => NotificationRecord.t;
}

class NotificationRecordIncludeList extends _i1.IncludeList {
  NotificationRecordIncludeList._({
    _i1.WhereExpressionBuilder<NotificationRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(NotificationRecord.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => NotificationRecord.t;
}

class NotificationRecordRepository {
  const NotificationRecordRepository._();

  /// Returns a list of [NotificationRecord]s matching the given query parameters.
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
  Future<List<NotificationRecord>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<NotificationRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<NotificationRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<NotificationRecordTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<NotificationRecord>(
      where: where?.call(NotificationRecord.t),
      orderBy: orderBy?.call(NotificationRecord.t),
      orderByList: orderByList?.call(NotificationRecord.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [NotificationRecord] matching the given query parameters.
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
  Future<NotificationRecord?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<NotificationRecordTable>? where,
    int? offset,
    _i1.OrderByBuilder<NotificationRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<NotificationRecordTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<NotificationRecord>(
      where: where?.call(NotificationRecord.t),
      orderBy: orderBy?.call(NotificationRecord.t),
      orderByList: orderByList?.call(NotificationRecord.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [NotificationRecord] by its [id] or null if no such row exists.
  Future<NotificationRecord?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<NotificationRecord>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [NotificationRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [NotificationRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<NotificationRecord>> insert(
    _i1.Session session,
    List<NotificationRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<NotificationRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [NotificationRecord] and returns the inserted row.
  ///
  /// The returned [NotificationRecord] will have its `id` field set.
  Future<NotificationRecord> insertRow(
    _i1.Session session,
    NotificationRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<NotificationRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [NotificationRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<NotificationRecord>> update(
    _i1.Session session,
    List<NotificationRecord> rows, {
    _i1.ColumnSelections<NotificationRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<NotificationRecord>(
      rows,
      columns: columns?.call(NotificationRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [NotificationRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<NotificationRecord> updateRow(
    _i1.Session session,
    NotificationRecord row, {
    _i1.ColumnSelections<NotificationRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<NotificationRecord>(
      row,
      columns: columns?.call(NotificationRecord.t),
      transaction: transaction,
    );
  }

  /// Deletes all [NotificationRecord]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<NotificationRecord>> delete(
    _i1.Session session,
    List<NotificationRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<NotificationRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [NotificationRecord].
  Future<NotificationRecord> deleteRow(
    _i1.Session session,
    NotificationRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<NotificationRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<NotificationRecord>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<NotificationRecordTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<NotificationRecord>(
      where: where(NotificationRecord.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<NotificationRecordTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<NotificationRecord>(
      where: where?.call(NotificationRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
