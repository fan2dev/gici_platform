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

abstract class MealEntry
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  MealEntry._({
    this.id,
    required this.organizationId,
    required this.childId,
    required this.recordedByUserId,
    required this.mealType,
    required this.consumptionLevel,
    required this.recordedAt,
    this.menuItems,
    this.notes,
    this.photoUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MealEntry({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    required _i1.UuidValue childId,
    required _i1.UuidValue recordedByUserId,
    required String mealType,
    required String consumptionLevel,
    required DateTime recordedAt,
    String? menuItems,
    String? notes,
    String? photoUrl,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _MealEntryImpl;

  factory MealEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return MealEntry(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      organizationId: _i1.UuidValueJsonExtension.fromJson(
          jsonSerialization['organizationId']),
      childId:
          _i1.UuidValueJsonExtension.fromJson(jsonSerialization['childId']),
      recordedByUserId: _i1.UuidValueJsonExtension.fromJson(
          jsonSerialization['recordedByUserId']),
      mealType: jsonSerialization['mealType'] as String,
      consumptionLevel: jsonSerialization['consumptionLevel'] as String,
      recordedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['recordedAt']),
      menuItems: jsonSerialization['menuItems'] as String?,
      notes: jsonSerialization['notes'] as String?,
      photoUrl: jsonSerialization['photoUrl'] as String?,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = MealEntryTable();

  static const db = MealEntryRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue organizationId;

  _i1.UuidValue childId;

  _i1.UuidValue recordedByUserId;

  String mealType;

  String consumptionLevel;

  DateTime recordedAt;

  String? menuItems;

  String? notes;

  String? photoUrl;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [MealEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MealEntry copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? organizationId,
    _i1.UuidValue? childId,
    _i1.UuidValue? recordedByUserId,
    String? mealType,
    String? consumptionLevel,
    DateTime? recordedAt,
    String? menuItems,
    String? notes,
    String? photoUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      'childId': childId.toJson(),
      'recordedByUserId': recordedByUserId.toJson(),
      'mealType': mealType,
      'consumptionLevel': consumptionLevel,
      'recordedAt': recordedAt.toJson(),
      if (menuItems != null) 'menuItems': menuItems,
      if (notes != null) 'notes': notes,
      if (photoUrl != null) 'photoUrl': photoUrl,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      'childId': childId.toJson(),
      'recordedByUserId': recordedByUserId.toJson(),
      'mealType': mealType,
      'consumptionLevel': consumptionLevel,
      'recordedAt': recordedAt.toJson(),
      if (menuItems != null) 'menuItems': menuItems,
      if (notes != null) 'notes': notes,
      if (photoUrl != null) 'photoUrl': photoUrl,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static MealEntryInclude include() {
    return MealEntryInclude._();
  }

  static MealEntryIncludeList includeList({
    _i1.WhereExpressionBuilder<MealEntryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MealEntryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MealEntryTable>? orderByList,
    MealEntryInclude? include,
  }) {
    return MealEntryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MealEntry.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(MealEntry.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MealEntryImpl extends MealEntry {
  _MealEntryImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    required _i1.UuidValue childId,
    required _i1.UuidValue recordedByUserId,
    required String mealType,
    required String consumptionLevel,
    required DateTime recordedAt,
    String? menuItems,
    String? notes,
    String? photoUrl,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          childId: childId,
          recordedByUserId: recordedByUserId,
          mealType: mealType,
          consumptionLevel: consumptionLevel,
          recordedAt: recordedAt,
          menuItems: menuItems,
          notes: notes,
          photoUrl: photoUrl,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [MealEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MealEntry copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? organizationId,
    _i1.UuidValue? childId,
    _i1.UuidValue? recordedByUserId,
    String? mealType,
    String? consumptionLevel,
    DateTime? recordedAt,
    Object? menuItems = _Undefined,
    Object? notes = _Undefined,
    Object? photoUrl = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MealEntry(
      id: id is _i1.UuidValue? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      childId: childId ?? this.childId,
      recordedByUserId: recordedByUserId ?? this.recordedByUserId,
      mealType: mealType ?? this.mealType,
      consumptionLevel: consumptionLevel ?? this.consumptionLevel,
      recordedAt: recordedAt ?? this.recordedAt,
      menuItems: menuItems is String? ? menuItems : this.menuItems,
      notes: notes is String? ? notes : this.notes,
      photoUrl: photoUrl is String? ? photoUrl : this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class MealEntryTable extends _i1.Table<_i1.UuidValue?> {
  MealEntryTable({super.tableRelation}) : super(tableName: 'meal_entry') {
    organizationId = _i1.ColumnUuid(
      'organizationId',
      this,
    );
    childId = _i1.ColumnUuid(
      'childId',
      this,
    );
    recordedByUserId = _i1.ColumnUuid(
      'recordedByUserId',
      this,
    );
    mealType = _i1.ColumnString(
      'mealType',
      this,
    );
    consumptionLevel = _i1.ColumnString(
      'consumptionLevel',
      this,
    );
    recordedAt = _i1.ColumnDateTime(
      'recordedAt',
      this,
    );
    menuItems = _i1.ColumnString(
      'menuItems',
      this,
    );
    notes = _i1.ColumnString(
      'notes',
      this,
    );
    photoUrl = _i1.ColumnString(
      'photoUrl',
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

  late final _i1.ColumnUuid childId;

  late final _i1.ColumnUuid recordedByUserId;

  late final _i1.ColumnString mealType;

  late final _i1.ColumnString consumptionLevel;

  late final _i1.ColumnDateTime recordedAt;

  late final _i1.ColumnString menuItems;

  late final _i1.ColumnString notes;

  late final _i1.ColumnString photoUrl;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        organizationId,
        childId,
        recordedByUserId,
        mealType,
        consumptionLevel,
        recordedAt,
        menuItems,
        notes,
        photoUrl,
        createdAt,
        updatedAt,
      ];
}

class MealEntryInclude extends _i1.IncludeObject {
  MealEntryInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => MealEntry.t;
}

class MealEntryIncludeList extends _i1.IncludeList {
  MealEntryIncludeList._({
    _i1.WhereExpressionBuilder<MealEntryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(MealEntry.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => MealEntry.t;
}

class MealEntryRepository {
  const MealEntryRepository._();

  /// Returns a list of [MealEntry]s matching the given query parameters.
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
  Future<List<MealEntry>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MealEntryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MealEntryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MealEntryTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<MealEntry>(
      where: where?.call(MealEntry.t),
      orderBy: orderBy?.call(MealEntry.t),
      orderByList: orderByList?.call(MealEntry.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [MealEntry] matching the given query parameters.
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
  Future<MealEntry?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MealEntryTable>? where,
    int? offset,
    _i1.OrderByBuilder<MealEntryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MealEntryTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<MealEntry>(
      where: where?.call(MealEntry.t),
      orderBy: orderBy?.call(MealEntry.t),
      orderByList: orderByList?.call(MealEntry.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [MealEntry] by its [id] or null if no such row exists.
  Future<MealEntry?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<MealEntry>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [MealEntry]s in the list and returns the inserted rows.
  ///
  /// The returned [MealEntry]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<MealEntry>> insert(
    _i1.Session session,
    List<MealEntry> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<MealEntry>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [MealEntry] and returns the inserted row.
  ///
  /// The returned [MealEntry] will have its `id` field set.
  Future<MealEntry> insertRow(
    _i1.Session session,
    MealEntry row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<MealEntry>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [MealEntry]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<MealEntry>> update(
    _i1.Session session,
    List<MealEntry> rows, {
    _i1.ColumnSelections<MealEntryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<MealEntry>(
      rows,
      columns: columns?.call(MealEntry.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MealEntry]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<MealEntry> updateRow(
    _i1.Session session,
    MealEntry row, {
    _i1.ColumnSelections<MealEntryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<MealEntry>(
      row,
      columns: columns?.call(MealEntry.t),
      transaction: transaction,
    );
  }

  /// Deletes all [MealEntry]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<MealEntry>> delete(
    _i1.Session session,
    List<MealEntry> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<MealEntry>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [MealEntry].
  Future<MealEntry> deleteRow(
    _i1.Session session,
    MealEntry row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<MealEntry>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<MealEntry>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<MealEntryTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<MealEntry>(
      where: where(MealEntry.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MealEntryTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<MealEntry>(
      where: where?.call(MealEntry.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
