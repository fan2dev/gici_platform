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

abstract class StaffClassroomPermission
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  StaffClassroomPermission._({
    this.id,
    required this.organizationId,
    required this.userId,
    required this.classroomId,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StaffClassroomPermission({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    required _i1.UuidValue userId,
    required _i1.UuidValue classroomId,
    required String role,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _StaffClassroomPermissionImpl;

  factory StaffClassroomPermission.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return StaffClassroomPermission(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      organizationId: _i1.UuidValueJsonExtension.fromJson(
          jsonSerialization['organizationId']),
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      classroomId:
          _i1.UuidValueJsonExtension.fromJson(jsonSerialization['classroomId']),
      role: jsonSerialization['role'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = StaffClassroomPermissionTable();

  static const db = StaffClassroomPermissionRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue organizationId;

  _i1.UuidValue userId;

  _i1.UuidValue classroomId;

  String role;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [StaffClassroomPermission]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StaffClassroomPermission copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? organizationId,
    _i1.UuidValue? userId,
    _i1.UuidValue? classroomId,
    String? role,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      'userId': userId.toJson(),
      'classroomId': classroomId.toJson(),
      'role': role,
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
      'classroomId': classroomId.toJson(),
      'role': role,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static StaffClassroomPermissionInclude include() {
    return StaffClassroomPermissionInclude._();
  }

  static StaffClassroomPermissionIncludeList includeList({
    _i1.WhereExpressionBuilder<StaffClassroomPermissionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StaffClassroomPermissionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StaffClassroomPermissionTable>? orderByList,
    StaffClassroomPermissionInclude? include,
  }) {
    return StaffClassroomPermissionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StaffClassroomPermission.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(StaffClassroomPermission.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StaffClassroomPermissionImpl extends StaffClassroomPermission {
  _StaffClassroomPermissionImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    required _i1.UuidValue userId,
    required _i1.UuidValue classroomId,
    required String role,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          userId: userId,
          classroomId: classroomId,
          role: role,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [StaffClassroomPermission]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StaffClassroomPermission copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? organizationId,
    _i1.UuidValue? userId,
    _i1.UuidValue? classroomId,
    String? role,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StaffClassroomPermission(
      id: id is _i1.UuidValue? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      userId: userId ?? this.userId,
      classroomId: classroomId ?? this.classroomId,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class StaffClassroomPermissionTable extends _i1.Table<_i1.UuidValue?> {
  StaffClassroomPermissionTable({super.tableRelation})
      : super(tableName: 'staff_classroom_permission') {
    organizationId = _i1.ColumnUuid(
      'organizationId',
      this,
    );
    userId = _i1.ColumnUuid(
      'userId',
      this,
    );
    classroomId = _i1.ColumnUuid(
      'classroomId',
      this,
    );
    role = _i1.ColumnString(
      'role',
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

  late final _i1.ColumnUuid classroomId;

  late final _i1.ColumnString role;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        organizationId,
        userId,
        classroomId,
        role,
        createdAt,
        updatedAt,
      ];
}

class StaffClassroomPermissionInclude extends _i1.IncludeObject {
  StaffClassroomPermissionInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => StaffClassroomPermission.t;
}

class StaffClassroomPermissionIncludeList extends _i1.IncludeList {
  StaffClassroomPermissionIncludeList._({
    _i1.WhereExpressionBuilder<StaffClassroomPermissionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StaffClassroomPermission.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => StaffClassroomPermission.t;
}

class StaffClassroomPermissionRepository {
  const StaffClassroomPermissionRepository._();

  /// Returns a list of [StaffClassroomPermission]s matching the given query parameters.
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
  Future<List<StaffClassroomPermission>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StaffClassroomPermissionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StaffClassroomPermissionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StaffClassroomPermissionTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<StaffClassroomPermission>(
      where: where?.call(StaffClassroomPermission.t),
      orderBy: orderBy?.call(StaffClassroomPermission.t),
      orderByList: orderByList?.call(StaffClassroomPermission.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [StaffClassroomPermission] matching the given query parameters.
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
  Future<StaffClassroomPermission?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StaffClassroomPermissionTable>? where,
    int? offset,
    _i1.OrderByBuilder<StaffClassroomPermissionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StaffClassroomPermissionTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<StaffClassroomPermission>(
      where: where?.call(StaffClassroomPermission.t),
      orderBy: orderBy?.call(StaffClassroomPermission.t),
      orderByList: orderByList?.call(StaffClassroomPermission.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [StaffClassroomPermission] by its [id] or null if no such row exists.
  Future<StaffClassroomPermission?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<StaffClassroomPermission>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [StaffClassroomPermission]s in the list and returns the inserted rows.
  ///
  /// The returned [StaffClassroomPermission]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<StaffClassroomPermission>> insert(
    _i1.Session session,
    List<StaffClassroomPermission> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<StaffClassroomPermission>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [StaffClassroomPermission] and returns the inserted row.
  ///
  /// The returned [StaffClassroomPermission] will have its `id` field set.
  Future<StaffClassroomPermission> insertRow(
    _i1.Session session,
    StaffClassroomPermission row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<StaffClassroomPermission>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [StaffClassroomPermission]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<StaffClassroomPermission>> update(
    _i1.Session session,
    List<StaffClassroomPermission> rows, {
    _i1.ColumnSelections<StaffClassroomPermissionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<StaffClassroomPermission>(
      rows,
      columns: columns?.call(StaffClassroomPermission.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StaffClassroomPermission]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StaffClassroomPermission> updateRow(
    _i1.Session session,
    StaffClassroomPermission row, {
    _i1.ColumnSelections<StaffClassroomPermissionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<StaffClassroomPermission>(
      row,
      columns: columns?.call(StaffClassroomPermission.t),
      transaction: transaction,
    );
  }

  /// Deletes all [StaffClassroomPermission]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<StaffClassroomPermission>> delete(
    _i1.Session session,
    List<StaffClassroomPermission> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<StaffClassroomPermission>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [StaffClassroomPermission].
  Future<StaffClassroomPermission> deleteRow(
    _i1.Session session,
    StaffClassroomPermission row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StaffClassroomPermission>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<StaffClassroomPermission>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<StaffClassroomPermissionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<StaffClassroomPermission>(
      where: where(StaffClassroomPermission.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StaffClassroomPermissionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<StaffClassroomPermission>(
      where: where?.call(StaffClassroomPermission.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
