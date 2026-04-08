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

abstract class SchoolCalendarEvent
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  SchoolCalendarEvent._({
    this.id,
    required this.organizationId,
    required this.title,
    this.description,
    required this.eventDate,
    this.endDate,
    required this.eventType,
    required this.isRecurring,
    required this.createdByUserId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory SchoolCalendarEvent({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    required String title,
    String? description,
    required DateTime eventDate,
    DateTime? endDate,
    required String eventType,
    required bool isRecurring,
    required _i1.UuidValue createdByUserId,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) = _SchoolCalendarEventImpl;

  factory SchoolCalendarEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return SchoolCalendarEvent(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      organizationId: _i1.UuidValueJsonExtension.fromJson(
          jsonSerialization['organizationId']),
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String?,
      eventDate:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['eventDate']),
      endDate: jsonSerialization['endDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endDate']),
      eventType: jsonSerialization['eventType'] as String,
      isRecurring: jsonSerialization['isRecurring'] as bool,
      createdByUserId: _i1.UuidValueJsonExtension.fromJson(
          jsonSerialization['createdByUserId']),
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      deletedAt: jsonSerialization['deletedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['deletedAt']),
    );
  }

  static final t = SchoolCalendarEventTable();

  static const db = SchoolCalendarEventRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue organizationId;

  String title;

  String? description;

  DateTime eventDate;

  DateTime? endDate;

  String eventType;

  bool isRecurring;

  _i1.UuidValue createdByUserId;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime? deletedAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [SchoolCalendarEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SchoolCalendarEvent copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? organizationId,
    String? title,
    String? description,
    DateTime? eventDate,
    DateTime? endDate,
    String? eventType,
    bool? isRecurring,
    _i1.UuidValue? createdByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      'title': title,
      if (description != null) 'description': description,
      'eventDate': eventDate.toJson(),
      if (endDate != null) 'endDate': endDate?.toJson(),
      'eventType': eventType,
      'isRecurring': isRecurring,
      'createdByUserId': createdByUserId.toJson(),
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
      'title': title,
      if (description != null) 'description': description,
      'eventDate': eventDate.toJson(),
      if (endDate != null) 'endDate': endDate?.toJson(),
      'eventType': eventType,
      'isRecurring': isRecurring,
      'createdByUserId': createdByUserId.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (deletedAt != null) 'deletedAt': deletedAt?.toJson(),
    };
  }

  static SchoolCalendarEventInclude include() {
    return SchoolCalendarEventInclude._();
  }

  static SchoolCalendarEventIncludeList includeList({
    _i1.WhereExpressionBuilder<SchoolCalendarEventTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SchoolCalendarEventTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SchoolCalendarEventTable>? orderByList,
    SchoolCalendarEventInclude? include,
  }) {
    return SchoolCalendarEventIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SchoolCalendarEvent.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SchoolCalendarEvent.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SchoolCalendarEventImpl extends SchoolCalendarEvent {
  _SchoolCalendarEventImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    required String title,
    String? description,
    required DateTime eventDate,
    DateTime? endDate,
    required String eventType,
    required bool isRecurring,
    required _i1.UuidValue createdByUserId,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          title: title,
          description: description,
          eventDate: eventDate,
          endDate: endDate,
          eventType: eventType,
          isRecurring: isRecurring,
          createdByUserId: createdByUserId,
          createdAt: createdAt,
          updatedAt: updatedAt,
          deletedAt: deletedAt,
        );

  /// Returns a shallow copy of this [SchoolCalendarEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SchoolCalendarEvent copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? organizationId,
    String? title,
    Object? description = _Undefined,
    DateTime? eventDate,
    Object? endDate = _Undefined,
    String? eventType,
    bool? isRecurring,
    _i1.UuidValue? createdByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? deletedAt = _Undefined,
  }) {
    return SchoolCalendarEvent(
      id: id is _i1.UuidValue? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      title: title ?? this.title,
      description: description is String? ? description : this.description,
      eventDate: eventDate ?? this.eventDate,
      endDate: endDate is DateTime? ? endDate : this.endDate,
      eventType: eventType ?? this.eventType,
      isRecurring: isRecurring ?? this.isRecurring,
      createdByUserId: createdByUserId ?? this.createdByUserId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt is DateTime? ? deletedAt : this.deletedAt,
    );
  }
}

class SchoolCalendarEventTable extends _i1.Table<_i1.UuidValue?> {
  SchoolCalendarEventTable({super.tableRelation})
      : super(tableName: 'school_calendar_event') {
    organizationId = _i1.ColumnUuid(
      'organizationId',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    eventDate = _i1.ColumnDateTime(
      'eventDate',
      this,
    );
    endDate = _i1.ColumnDateTime(
      'endDate',
      this,
    );
    eventType = _i1.ColumnString(
      'eventType',
      this,
    );
    isRecurring = _i1.ColumnBool(
      'isRecurring',
      this,
    );
    createdByUserId = _i1.ColumnUuid(
      'createdByUserId',
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

  late final _i1.ColumnString title;

  late final _i1.ColumnString description;

  late final _i1.ColumnDateTime eventDate;

  late final _i1.ColumnDateTime endDate;

  late final _i1.ColumnString eventType;

  late final _i1.ColumnBool isRecurring;

  late final _i1.ColumnUuid createdByUserId;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnDateTime deletedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        organizationId,
        title,
        description,
        eventDate,
        endDate,
        eventType,
        isRecurring,
        createdByUserId,
        createdAt,
        updatedAt,
        deletedAt,
      ];
}

class SchoolCalendarEventInclude extends _i1.IncludeObject {
  SchoolCalendarEventInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => SchoolCalendarEvent.t;
}

class SchoolCalendarEventIncludeList extends _i1.IncludeList {
  SchoolCalendarEventIncludeList._({
    _i1.WhereExpressionBuilder<SchoolCalendarEventTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SchoolCalendarEvent.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => SchoolCalendarEvent.t;
}

class SchoolCalendarEventRepository {
  const SchoolCalendarEventRepository._();

  /// Returns a list of [SchoolCalendarEvent]s matching the given query parameters.
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
  Future<List<SchoolCalendarEvent>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SchoolCalendarEventTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SchoolCalendarEventTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SchoolCalendarEventTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SchoolCalendarEvent>(
      where: where?.call(SchoolCalendarEvent.t),
      orderBy: orderBy?.call(SchoolCalendarEvent.t),
      orderByList: orderByList?.call(SchoolCalendarEvent.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [SchoolCalendarEvent] matching the given query parameters.
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
  Future<SchoolCalendarEvent?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SchoolCalendarEventTable>? where,
    int? offset,
    _i1.OrderByBuilder<SchoolCalendarEventTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SchoolCalendarEventTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SchoolCalendarEvent>(
      where: where?.call(SchoolCalendarEvent.t),
      orderBy: orderBy?.call(SchoolCalendarEvent.t),
      orderByList: orderByList?.call(SchoolCalendarEvent.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [SchoolCalendarEvent] by its [id] or null if no such row exists.
  Future<SchoolCalendarEvent?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SchoolCalendarEvent>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [SchoolCalendarEvent]s in the list and returns the inserted rows.
  ///
  /// The returned [SchoolCalendarEvent]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SchoolCalendarEvent>> insert(
    _i1.Session session,
    List<SchoolCalendarEvent> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SchoolCalendarEvent>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SchoolCalendarEvent] and returns the inserted row.
  ///
  /// The returned [SchoolCalendarEvent] will have its `id` field set.
  Future<SchoolCalendarEvent> insertRow(
    _i1.Session session,
    SchoolCalendarEvent row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SchoolCalendarEvent>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SchoolCalendarEvent]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SchoolCalendarEvent>> update(
    _i1.Session session,
    List<SchoolCalendarEvent> rows, {
    _i1.ColumnSelections<SchoolCalendarEventTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SchoolCalendarEvent>(
      rows,
      columns: columns?.call(SchoolCalendarEvent.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SchoolCalendarEvent]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SchoolCalendarEvent> updateRow(
    _i1.Session session,
    SchoolCalendarEvent row, {
    _i1.ColumnSelections<SchoolCalendarEventTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SchoolCalendarEvent>(
      row,
      columns: columns?.call(SchoolCalendarEvent.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SchoolCalendarEvent]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SchoolCalendarEvent>> delete(
    _i1.Session session,
    List<SchoolCalendarEvent> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SchoolCalendarEvent>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SchoolCalendarEvent].
  Future<SchoolCalendarEvent> deleteRow(
    _i1.Session session,
    SchoolCalendarEvent row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SchoolCalendarEvent>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SchoolCalendarEvent>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SchoolCalendarEventTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SchoolCalendarEvent>(
      where: where(SchoolCalendarEvent.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SchoolCalendarEventTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SchoolCalendarEvent>(
      where: where?.call(SchoolCalendarEvent.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
