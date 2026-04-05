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

abstract class TimeEntry
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  TimeEntry._({
    this.id,
    required this.organizationId,
    required this.userId,
    required this.entryType,
    required this.recordedAt,
    this.parentEntryId,
    this.correctionReason,
    this.locationData,
    this.deviceInfo,
    this.notes,
    required this.isManualEntry,
    required this.createdByUserId,
    required this.createdAt,
  });

  factory TimeEntry({
    int? id,
    required int organizationId,
    required int userId,
    required String entryType,
    required DateTime recordedAt,
    int? parentEntryId,
    String? correctionReason,
    String? locationData,
    String? deviceInfo,
    String? notes,
    required bool isManualEntry,
    required int createdByUserId,
    required DateTime createdAt,
  }) = _TimeEntryImpl;

  factory TimeEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return TimeEntry(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      userId: jsonSerialization['userId'] as int,
      entryType: jsonSerialization['entryType'] as String,
      recordedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['recordedAt']),
      parentEntryId: jsonSerialization['parentEntryId'] as int?,
      correctionReason: jsonSerialization['correctionReason'] as String?,
      locationData: jsonSerialization['locationData'] as String?,
      deviceInfo: jsonSerialization['deviceInfo'] as String?,
      notes: jsonSerialization['notes'] as String?,
      isManualEntry: jsonSerialization['isManualEntry'] as bool,
      createdByUserId: jsonSerialization['createdByUserId'] as int,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = TimeEntryTable();

  static const db = TimeEntryRepository._();

  @override
  int? id;

  int organizationId;

  int userId;

  String entryType;

  DateTime recordedAt;

  int? parentEntryId;

  String? correctionReason;

  String? locationData;

  String? deviceInfo;

  String? notes;

  bool isManualEntry;

  int createdByUserId;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [TimeEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TimeEntry copyWith({
    int? id,
    int? organizationId,
    int? userId,
    String? entryType,
    DateTime? recordedAt,
    int? parentEntryId,
    String? correctionReason,
    String? locationData,
    String? deviceInfo,
    String? notes,
    bool? isManualEntry,
    int? createdByUserId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'organizationId': organizationId,
      'userId': userId,
      'entryType': entryType,
      'recordedAt': recordedAt.toJson(),
      if (parentEntryId != null) 'parentEntryId': parentEntryId,
      if (correctionReason != null) 'correctionReason': correctionReason,
      if (locationData != null) 'locationData': locationData,
      if (deviceInfo != null) 'deviceInfo': deviceInfo,
      if (notes != null) 'notes': notes,
      'isManualEntry': isManualEntry,
      'createdByUserId': createdByUserId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'organizationId': organizationId,
      'userId': userId,
      'entryType': entryType,
      'recordedAt': recordedAt.toJson(),
      if (parentEntryId != null) 'parentEntryId': parentEntryId,
      if (correctionReason != null) 'correctionReason': correctionReason,
      if (locationData != null) 'locationData': locationData,
      if (deviceInfo != null) 'deviceInfo': deviceInfo,
      if (notes != null) 'notes': notes,
      'isManualEntry': isManualEntry,
      'createdByUserId': createdByUserId,
      'createdAt': createdAt.toJson(),
    };
  }

  static TimeEntryInclude include() {
    return TimeEntryInclude._();
  }

  static TimeEntryIncludeList includeList({
    _i1.WhereExpressionBuilder<TimeEntryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TimeEntryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TimeEntryTable>? orderByList,
    TimeEntryInclude? include,
  }) {
    return TimeEntryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TimeEntry.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(TimeEntry.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TimeEntryImpl extends TimeEntry {
  _TimeEntryImpl({
    int? id,
    required int organizationId,
    required int userId,
    required String entryType,
    required DateTime recordedAt,
    int? parentEntryId,
    String? correctionReason,
    String? locationData,
    String? deviceInfo,
    String? notes,
    required bool isManualEntry,
    required int createdByUserId,
    required DateTime createdAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          userId: userId,
          entryType: entryType,
          recordedAt: recordedAt,
          parentEntryId: parentEntryId,
          correctionReason: correctionReason,
          locationData: locationData,
          deviceInfo: deviceInfo,
          notes: notes,
          isManualEntry: isManualEntry,
          createdByUserId: createdByUserId,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [TimeEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TimeEntry copyWith({
    Object? id = _Undefined,
    int? organizationId,
    int? userId,
    String? entryType,
    DateTime? recordedAt,
    Object? parentEntryId = _Undefined,
    Object? correctionReason = _Undefined,
    Object? locationData = _Undefined,
    Object? deviceInfo = _Undefined,
    Object? notes = _Undefined,
    bool? isManualEntry,
    int? createdByUserId,
    DateTime? createdAt,
  }) {
    return TimeEntry(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      userId: userId ?? this.userId,
      entryType: entryType ?? this.entryType,
      recordedAt: recordedAt ?? this.recordedAt,
      parentEntryId: parentEntryId is int? ? parentEntryId : this.parentEntryId,
      correctionReason: correctionReason is String?
          ? correctionReason
          : this.correctionReason,
      locationData: locationData is String? ? locationData : this.locationData,
      deviceInfo: deviceInfo is String? ? deviceInfo : this.deviceInfo,
      notes: notes is String? ? notes : this.notes,
      isManualEntry: isManualEntry ?? this.isManualEntry,
      createdByUserId: createdByUserId ?? this.createdByUserId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class TimeEntryTable extends _i1.Table<int?> {
  TimeEntryTable({super.tableRelation}) : super(tableName: 'time_entry') {
    organizationId = _i1.ColumnInt(
      'organizationId',
      this,
    );
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    entryType = _i1.ColumnString(
      'entryType',
      this,
    );
    recordedAt = _i1.ColumnDateTime(
      'recordedAt',
      this,
    );
    parentEntryId = _i1.ColumnInt(
      'parentEntryId',
      this,
    );
    correctionReason = _i1.ColumnString(
      'correctionReason',
      this,
    );
    locationData = _i1.ColumnString(
      'locationData',
      this,
    );
    deviceInfo = _i1.ColumnString(
      'deviceInfo',
      this,
    );
    notes = _i1.ColumnString(
      'notes',
      this,
    );
    isManualEntry = _i1.ColumnBool(
      'isManualEntry',
      this,
    );
    createdByUserId = _i1.ColumnInt(
      'createdByUserId',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final _i1.ColumnInt organizationId;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString entryType;

  late final _i1.ColumnDateTime recordedAt;

  late final _i1.ColumnInt parentEntryId;

  late final _i1.ColumnString correctionReason;

  late final _i1.ColumnString locationData;

  late final _i1.ColumnString deviceInfo;

  late final _i1.ColumnString notes;

  late final _i1.ColumnBool isManualEntry;

  late final _i1.ColumnInt createdByUserId;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
        id,
        organizationId,
        userId,
        entryType,
        recordedAt,
        parentEntryId,
        correctionReason,
        locationData,
        deviceInfo,
        notes,
        isManualEntry,
        createdByUserId,
        createdAt,
      ];
}

class TimeEntryInclude extends _i1.IncludeObject {
  TimeEntryInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => TimeEntry.t;
}

class TimeEntryIncludeList extends _i1.IncludeList {
  TimeEntryIncludeList._({
    _i1.WhereExpressionBuilder<TimeEntryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TimeEntry.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => TimeEntry.t;
}

class TimeEntryRepository {
  const TimeEntryRepository._();

  /// Returns a list of [TimeEntry]s matching the given query parameters.
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
  Future<List<TimeEntry>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TimeEntryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TimeEntryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TimeEntryTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<TimeEntry>(
      where: where?.call(TimeEntry.t),
      orderBy: orderBy?.call(TimeEntry.t),
      orderByList: orderByList?.call(TimeEntry.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [TimeEntry] matching the given query parameters.
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
  Future<TimeEntry?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TimeEntryTable>? where,
    int? offset,
    _i1.OrderByBuilder<TimeEntryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TimeEntryTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<TimeEntry>(
      where: where?.call(TimeEntry.t),
      orderBy: orderBy?.call(TimeEntry.t),
      orderByList: orderByList?.call(TimeEntry.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [TimeEntry] by its [id] or null if no such row exists.
  Future<TimeEntry?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<TimeEntry>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [TimeEntry]s in the list and returns the inserted rows.
  ///
  /// The returned [TimeEntry]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<TimeEntry>> insert(
    _i1.Session session,
    List<TimeEntry> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<TimeEntry>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [TimeEntry] and returns the inserted row.
  ///
  /// The returned [TimeEntry] will have its `id` field set.
  Future<TimeEntry> insertRow(
    _i1.Session session,
    TimeEntry row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<TimeEntry>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [TimeEntry]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<TimeEntry>> update(
    _i1.Session session,
    List<TimeEntry> rows, {
    _i1.ColumnSelections<TimeEntryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<TimeEntry>(
      rows,
      columns: columns?.call(TimeEntry.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TimeEntry]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TimeEntry> updateRow(
    _i1.Session session,
    TimeEntry row, {
    _i1.ColumnSelections<TimeEntryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<TimeEntry>(
      row,
      columns: columns?.call(TimeEntry.t),
      transaction: transaction,
    );
  }

  /// Deletes all [TimeEntry]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<TimeEntry>> delete(
    _i1.Session session,
    List<TimeEntry> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<TimeEntry>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [TimeEntry].
  Future<TimeEntry> deleteRow(
    _i1.Session session,
    TimeEntry row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TimeEntry>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<TimeEntry>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<TimeEntryTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<TimeEntry>(
      where: where(TimeEntry.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TimeEntryTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<TimeEntry>(
      where: where?.call(TimeEntry.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
