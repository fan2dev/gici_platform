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

abstract class MenuEntry
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  MenuEntry._({
    this.id,
    required this.organizationId,
    required this.menuDate,
    required this.mealType,
    required this.title,
    this.description,
    this.classroomId,
    required this.createdByUserId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory MenuEntry({
    int? id,
    required int organizationId,
    required DateTime menuDate,
    required String mealType,
    required String title,
    String? description,
    int? classroomId,
    required int createdByUserId,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) = _MenuEntryImpl;

  factory MenuEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return MenuEntry(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      menuDate:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['menuDate']),
      mealType: jsonSerialization['mealType'] as String,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String?,
      classroomId: jsonSerialization['classroomId'] as int?,
      createdByUserId: jsonSerialization['createdByUserId'] as int,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      deletedAt: jsonSerialization['deletedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['deletedAt']),
    );
  }

  static final t = MenuEntryTable();

  static const db = MenuEntryRepository._();

  @override
  int? id;

  int organizationId;

  DateTime menuDate;

  String mealType;

  String title;

  String? description;

  int? classroomId;

  int createdByUserId;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime? deletedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [MenuEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MenuEntry copyWith({
    int? id,
    int? organizationId,
    DateTime? menuDate,
    String? mealType,
    String? title,
    String? description,
    int? classroomId,
    int? createdByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'organizationId': organizationId,
      'menuDate': menuDate.toJson(),
      'mealType': mealType,
      'title': title,
      if (description != null) 'description': description,
      if (classroomId != null) 'classroomId': classroomId,
      'createdByUserId': createdByUserId,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (deletedAt != null) 'deletedAt': deletedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'organizationId': organizationId,
      'menuDate': menuDate.toJson(),
      'mealType': mealType,
      'title': title,
      if (description != null) 'description': description,
      if (classroomId != null) 'classroomId': classroomId,
      'createdByUserId': createdByUserId,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (deletedAt != null) 'deletedAt': deletedAt?.toJson(),
    };
  }

  static MenuEntryInclude include() {
    return MenuEntryInclude._();
  }

  static MenuEntryIncludeList includeList({
    _i1.WhereExpressionBuilder<MenuEntryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MenuEntryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MenuEntryTable>? orderByList,
    MenuEntryInclude? include,
  }) {
    return MenuEntryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MenuEntry.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(MenuEntry.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MenuEntryImpl extends MenuEntry {
  _MenuEntryImpl({
    int? id,
    required int organizationId,
    required DateTime menuDate,
    required String mealType,
    required String title,
    String? description,
    int? classroomId,
    required int createdByUserId,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          menuDate: menuDate,
          mealType: mealType,
          title: title,
          description: description,
          classroomId: classroomId,
          createdByUserId: createdByUserId,
          createdAt: createdAt,
          updatedAt: updatedAt,
          deletedAt: deletedAt,
        );

  /// Returns a shallow copy of this [MenuEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MenuEntry copyWith({
    Object? id = _Undefined,
    int? organizationId,
    DateTime? menuDate,
    String? mealType,
    String? title,
    Object? description = _Undefined,
    Object? classroomId = _Undefined,
    int? createdByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? deletedAt = _Undefined,
  }) {
    return MenuEntry(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      menuDate: menuDate ?? this.menuDate,
      mealType: mealType ?? this.mealType,
      title: title ?? this.title,
      description: description is String? ? description : this.description,
      classroomId: classroomId is int? ? classroomId : this.classroomId,
      createdByUserId: createdByUserId ?? this.createdByUserId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt is DateTime? ? deletedAt : this.deletedAt,
    );
  }
}

class MenuEntryTable extends _i1.Table<int?> {
  MenuEntryTable({super.tableRelation}) : super(tableName: 'menu_entry') {
    organizationId = _i1.ColumnInt(
      'organizationId',
      this,
    );
    menuDate = _i1.ColumnDateTime(
      'menuDate',
      this,
    );
    mealType = _i1.ColumnString(
      'mealType',
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
    classroomId = _i1.ColumnInt(
      'classroomId',
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
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
    deletedAt = _i1.ColumnDateTime(
      'deletedAt',
      this,
    );
  }

  late final _i1.ColumnInt organizationId;

  late final _i1.ColumnDateTime menuDate;

  late final _i1.ColumnString mealType;

  late final _i1.ColumnString title;

  late final _i1.ColumnString description;

  late final _i1.ColumnInt classroomId;

  late final _i1.ColumnInt createdByUserId;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnDateTime deletedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        organizationId,
        menuDate,
        mealType,
        title,
        description,
        classroomId,
        createdByUserId,
        createdAt,
        updatedAt,
        deletedAt,
      ];
}

class MenuEntryInclude extends _i1.IncludeObject {
  MenuEntryInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => MenuEntry.t;
}

class MenuEntryIncludeList extends _i1.IncludeList {
  MenuEntryIncludeList._({
    _i1.WhereExpressionBuilder<MenuEntryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(MenuEntry.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => MenuEntry.t;
}

class MenuEntryRepository {
  const MenuEntryRepository._();

  /// Returns a list of [MenuEntry]s matching the given query parameters.
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
  Future<List<MenuEntry>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MenuEntryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MenuEntryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MenuEntryTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<MenuEntry>(
      where: where?.call(MenuEntry.t),
      orderBy: orderBy?.call(MenuEntry.t),
      orderByList: orderByList?.call(MenuEntry.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [MenuEntry] matching the given query parameters.
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
  Future<MenuEntry?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MenuEntryTable>? where,
    int? offset,
    _i1.OrderByBuilder<MenuEntryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MenuEntryTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<MenuEntry>(
      where: where?.call(MenuEntry.t),
      orderBy: orderBy?.call(MenuEntry.t),
      orderByList: orderByList?.call(MenuEntry.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [MenuEntry] by its [id] or null if no such row exists.
  Future<MenuEntry?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<MenuEntry>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [MenuEntry]s in the list and returns the inserted rows.
  ///
  /// The returned [MenuEntry]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<MenuEntry>> insert(
    _i1.Session session,
    List<MenuEntry> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<MenuEntry>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [MenuEntry] and returns the inserted row.
  ///
  /// The returned [MenuEntry] will have its `id` field set.
  Future<MenuEntry> insertRow(
    _i1.Session session,
    MenuEntry row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<MenuEntry>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [MenuEntry]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<MenuEntry>> update(
    _i1.Session session,
    List<MenuEntry> rows, {
    _i1.ColumnSelections<MenuEntryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<MenuEntry>(
      rows,
      columns: columns?.call(MenuEntry.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MenuEntry]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<MenuEntry> updateRow(
    _i1.Session session,
    MenuEntry row, {
    _i1.ColumnSelections<MenuEntryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<MenuEntry>(
      row,
      columns: columns?.call(MenuEntry.t),
      transaction: transaction,
    );
  }

  /// Deletes all [MenuEntry]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<MenuEntry>> delete(
    _i1.Session session,
    List<MenuEntry> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<MenuEntry>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [MenuEntry].
  Future<MenuEntry> deleteRow(
    _i1.Session session,
    MenuEntry row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<MenuEntry>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<MenuEntry>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<MenuEntryTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<MenuEntry>(
      where: where(MenuEntry.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MenuEntryTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<MenuEntry>(
      where: where?.call(MenuEntry.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
