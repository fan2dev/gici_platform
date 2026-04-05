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

abstract class BowelMovementEntry
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  BowelMovementEntry._({
    this.id,
    required this.organizationId,
    required this.childId,
    required this.recordedByUserId,
    required this.eventAt,
    required this.eventType,
    this.consistency,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BowelMovementEntry({
    int? id,
    required int organizationId,
    required int childId,
    required int recordedByUserId,
    required DateTime eventAt,
    required String eventType,
    String? consistency,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _BowelMovementEntryImpl;

  factory BowelMovementEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return BowelMovementEntry(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      childId: jsonSerialization['childId'] as int,
      recordedByUserId: jsonSerialization['recordedByUserId'] as int,
      eventAt: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['eventAt']),
      eventType: jsonSerialization['eventType'] as String,
      consistency: jsonSerialization['consistency'] as String?,
      notes: jsonSerialization['notes'] as String?,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = BowelMovementEntryTable();

  static const db = BowelMovementEntryRepository._();

  @override
  int? id;

  int organizationId;

  int childId;

  int recordedByUserId;

  DateTime eventAt;

  String eventType;

  String? consistency;

  String? notes;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [BowelMovementEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BowelMovementEntry copyWith({
    int? id,
    int? organizationId,
    int? childId,
    int? recordedByUserId,
    DateTime? eventAt,
    String? eventType,
    String? consistency,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'organizationId': organizationId,
      'childId': childId,
      'recordedByUserId': recordedByUserId,
      'eventAt': eventAt.toJson(),
      'eventType': eventType,
      if (consistency != null) 'consistency': consistency,
      if (notes != null) 'notes': notes,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'organizationId': organizationId,
      'childId': childId,
      'recordedByUserId': recordedByUserId,
      'eventAt': eventAt.toJson(),
      'eventType': eventType,
      if (consistency != null) 'consistency': consistency,
      if (notes != null) 'notes': notes,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static BowelMovementEntryInclude include() {
    return BowelMovementEntryInclude._();
  }

  static BowelMovementEntryIncludeList includeList({
    _i1.WhereExpressionBuilder<BowelMovementEntryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BowelMovementEntryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BowelMovementEntryTable>? orderByList,
    BowelMovementEntryInclude? include,
  }) {
    return BowelMovementEntryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BowelMovementEntry.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(BowelMovementEntry.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BowelMovementEntryImpl extends BowelMovementEntry {
  _BowelMovementEntryImpl({
    int? id,
    required int organizationId,
    required int childId,
    required int recordedByUserId,
    required DateTime eventAt,
    required String eventType,
    String? consistency,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          childId: childId,
          recordedByUserId: recordedByUserId,
          eventAt: eventAt,
          eventType: eventType,
          consistency: consistency,
          notes: notes,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [BowelMovementEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BowelMovementEntry copyWith({
    Object? id = _Undefined,
    int? organizationId,
    int? childId,
    int? recordedByUserId,
    DateTime? eventAt,
    String? eventType,
    Object? consistency = _Undefined,
    Object? notes = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BowelMovementEntry(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      childId: childId ?? this.childId,
      recordedByUserId: recordedByUserId ?? this.recordedByUserId,
      eventAt: eventAt ?? this.eventAt,
      eventType: eventType ?? this.eventType,
      consistency: consistency is String? ? consistency : this.consistency,
      notes: notes is String? ? notes : this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class BowelMovementEntryTable extends _i1.Table<int?> {
  BowelMovementEntryTable({super.tableRelation})
      : super(tableName: 'bowel_movement_entry') {
    organizationId = _i1.ColumnInt(
      'organizationId',
      this,
    );
    childId = _i1.ColumnInt(
      'childId',
      this,
    );
    recordedByUserId = _i1.ColumnInt(
      'recordedByUserId',
      this,
    );
    eventAt = _i1.ColumnDateTime(
      'eventAt',
      this,
    );
    eventType = _i1.ColumnString(
      'eventType',
      this,
    );
    consistency = _i1.ColumnString(
      'consistency',
      this,
    );
    notes = _i1.ColumnString(
      'notes',
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

  late final _i1.ColumnInt organizationId;

  late final _i1.ColumnInt childId;

  late final _i1.ColumnInt recordedByUserId;

  late final _i1.ColumnDateTime eventAt;

  late final _i1.ColumnString eventType;

  late final _i1.ColumnString consistency;

  late final _i1.ColumnString notes;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        organizationId,
        childId,
        recordedByUserId,
        eventAt,
        eventType,
        consistency,
        notes,
        createdAt,
        updatedAt,
      ];
}

class BowelMovementEntryInclude extends _i1.IncludeObject {
  BowelMovementEntryInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => BowelMovementEntry.t;
}

class BowelMovementEntryIncludeList extends _i1.IncludeList {
  BowelMovementEntryIncludeList._({
    _i1.WhereExpressionBuilder<BowelMovementEntryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(BowelMovementEntry.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => BowelMovementEntry.t;
}

class BowelMovementEntryRepository {
  const BowelMovementEntryRepository._();

  /// Returns a list of [BowelMovementEntry]s matching the given query parameters.
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
  Future<List<BowelMovementEntry>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BowelMovementEntryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BowelMovementEntryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BowelMovementEntryTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<BowelMovementEntry>(
      where: where?.call(BowelMovementEntry.t),
      orderBy: orderBy?.call(BowelMovementEntry.t),
      orderByList: orderByList?.call(BowelMovementEntry.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [BowelMovementEntry] matching the given query parameters.
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
  Future<BowelMovementEntry?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BowelMovementEntryTable>? where,
    int? offset,
    _i1.OrderByBuilder<BowelMovementEntryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BowelMovementEntryTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<BowelMovementEntry>(
      where: where?.call(BowelMovementEntry.t),
      orderBy: orderBy?.call(BowelMovementEntry.t),
      orderByList: orderByList?.call(BowelMovementEntry.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [BowelMovementEntry] by its [id] or null if no such row exists.
  Future<BowelMovementEntry?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<BowelMovementEntry>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [BowelMovementEntry]s in the list and returns the inserted rows.
  ///
  /// The returned [BowelMovementEntry]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<BowelMovementEntry>> insert(
    _i1.Session session,
    List<BowelMovementEntry> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<BowelMovementEntry>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [BowelMovementEntry] and returns the inserted row.
  ///
  /// The returned [BowelMovementEntry] will have its `id` field set.
  Future<BowelMovementEntry> insertRow(
    _i1.Session session,
    BowelMovementEntry row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<BowelMovementEntry>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [BowelMovementEntry]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<BowelMovementEntry>> update(
    _i1.Session session,
    List<BowelMovementEntry> rows, {
    _i1.ColumnSelections<BowelMovementEntryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<BowelMovementEntry>(
      rows,
      columns: columns?.call(BowelMovementEntry.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BowelMovementEntry]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<BowelMovementEntry> updateRow(
    _i1.Session session,
    BowelMovementEntry row, {
    _i1.ColumnSelections<BowelMovementEntryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<BowelMovementEntry>(
      row,
      columns: columns?.call(BowelMovementEntry.t),
      transaction: transaction,
    );
  }

  /// Deletes all [BowelMovementEntry]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<BowelMovementEntry>> delete(
    _i1.Session session,
    List<BowelMovementEntry> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<BowelMovementEntry>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [BowelMovementEntry].
  Future<BowelMovementEntry> deleteRow(
    _i1.Session session,
    BowelMovementEntry row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<BowelMovementEntry>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<BowelMovementEntry>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<BowelMovementEntryTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<BowelMovementEntry>(
      where: where(BowelMovementEntry.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BowelMovementEntryTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<BowelMovementEntry>(
      where: where?.call(BowelMovementEntry.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
