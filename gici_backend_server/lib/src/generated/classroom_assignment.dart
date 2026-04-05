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

abstract class ClassroomAssignment
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ClassroomAssignment._({
    this.id,
    required this.organizationId,
    required this.classroomId,
    required this.childId,
    required this.assignedAt,
    this.assignedByUserId,
    this.withdrawnAt,
    this.withdrawnByUserId,
    this.withdrawnReason,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ClassroomAssignment({
    int? id,
    required int organizationId,
    required int classroomId,
    required int childId,
    required DateTime assignedAt,
    int? assignedByUserId,
    DateTime? withdrawnAt,
    int? withdrawnByUserId,
    String? withdrawnReason,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ClassroomAssignmentImpl;

  factory ClassroomAssignment.fromJson(Map<String, dynamic> jsonSerialization) {
    return ClassroomAssignment(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      classroomId: jsonSerialization['classroomId'] as int,
      childId: jsonSerialization['childId'] as int,
      assignedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['assignedAt']),
      assignedByUserId: jsonSerialization['assignedByUserId'] as int?,
      withdrawnAt: jsonSerialization['withdrawnAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['withdrawnAt']),
      withdrawnByUserId: jsonSerialization['withdrawnByUserId'] as int?,
      withdrawnReason: jsonSerialization['withdrawnReason'] as String?,
      status: jsonSerialization['status'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = ClassroomAssignmentTable();

  static const db = ClassroomAssignmentRepository._();

  @override
  int? id;

  int organizationId;

  int classroomId;

  int childId;

  DateTime assignedAt;

  int? assignedByUserId;

  DateTime? withdrawnAt;

  int? withdrawnByUserId;

  String? withdrawnReason;

  String status;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ClassroomAssignment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ClassroomAssignment copyWith({
    int? id,
    int? organizationId,
    int? classroomId,
    int? childId,
    DateTime? assignedAt,
    int? assignedByUserId,
    DateTime? withdrawnAt,
    int? withdrawnByUserId,
    String? withdrawnReason,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'organizationId': organizationId,
      'classroomId': classroomId,
      'childId': childId,
      'assignedAt': assignedAt.toJson(),
      if (assignedByUserId != null) 'assignedByUserId': assignedByUserId,
      if (withdrawnAt != null) 'withdrawnAt': withdrawnAt?.toJson(),
      if (withdrawnByUserId != null) 'withdrawnByUserId': withdrawnByUserId,
      if (withdrawnReason != null) 'withdrawnReason': withdrawnReason,
      'status': status,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'organizationId': organizationId,
      'classroomId': classroomId,
      'childId': childId,
      'assignedAt': assignedAt.toJson(),
      if (assignedByUserId != null) 'assignedByUserId': assignedByUserId,
      if (withdrawnAt != null) 'withdrawnAt': withdrawnAt?.toJson(),
      if (withdrawnByUserId != null) 'withdrawnByUserId': withdrawnByUserId,
      if (withdrawnReason != null) 'withdrawnReason': withdrawnReason,
      'status': status,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static ClassroomAssignmentInclude include() {
    return ClassroomAssignmentInclude._();
  }

  static ClassroomAssignmentIncludeList includeList({
    _i1.WhereExpressionBuilder<ClassroomAssignmentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ClassroomAssignmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClassroomAssignmentTable>? orderByList,
    ClassroomAssignmentInclude? include,
  }) {
    return ClassroomAssignmentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ClassroomAssignment.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ClassroomAssignment.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClassroomAssignmentImpl extends ClassroomAssignment {
  _ClassroomAssignmentImpl({
    int? id,
    required int organizationId,
    required int classroomId,
    required int childId,
    required DateTime assignedAt,
    int? assignedByUserId,
    DateTime? withdrawnAt,
    int? withdrawnByUserId,
    String? withdrawnReason,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          classroomId: classroomId,
          childId: childId,
          assignedAt: assignedAt,
          assignedByUserId: assignedByUserId,
          withdrawnAt: withdrawnAt,
          withdrawnByUserId: withdrawnByUserId,
          withdrawnReason: withdrawnReason,
          status: status,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [ClassroomAssignment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ClassroomAssignment copyWith({
    Object? id = _Undefined,
    int? organizationId,
    int? classroomId,
    int? childId,
    DateTime? assignedAt,
    Object? assignedByUserId = _Undefined,
    Object? withdrawnAt = _Undefined,
    Object? withdrawnByUserId = _Undefined,
    Object? withdrawnReason = _Undefined,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ClassroomAssignment(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      classroomId: classroomId ?? this.classroomId,
      childId: childId ?? this.childId,
      assignedAt: assignedAt ?? this.assignedAt,
      assignedByUserId:
          assignedByUserId is int? ? assignedByUserId : this.assignedByUserId,
      withdrawnAt: withdrawnAt is DateTime? ? withdrawnAt : this.withdrawnAt,
      withdrawnByUserId: withdrawnByUserId is int?
          ? withdrawnByUserId
          : this.withdrawnByUserId,
      withdrawnReason:
          withdrawnReason is String? ? withdrawnReason : this.withdrawnReason,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ClassroomAssignmentTable extends _i1.Table<int?> {
  ClassroomAssignmentTable({super.tableRelation})
      : super(tableName: 'classroom_assignment') {
    organizationId = _i1.ColumnInt(
      'organizationId',
      this,
    );
    classroomId = _i1.ColumnInt(
      'classroomId',
      this,
    );
    childId = _i1.ColumnInt(
      'childId',
      this,
    );
    assignedAt = _i1.ColumnDateTime(
      'assignedAt',
      this,
    );
    assignedByUserId = _i1.ColumnInt(
      'assignedByUserId',
      this,
    );
    withdrawnAt = _i1.ColumnDateTime(
      'withdrawnAt',
      this,
    );
    withdrawnByUserId = _i1.ColumnInt(
      'withdrawnByUserId',
      this,
    );
    withdrawnReason = _i1.ColumnString(
      'withdrawnReason',
      this,
    );
    status = _i1.ColumnString(
      'status',
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

  late final _i1.ColumnInt classroomId;

  late final _i1.ColumnInt childId;

  late final _i1.ColumnDateTime assignedAt;

  late final _i1.ColumnInt assignedByUserId;

  late final _i1.ColumnDateTime withdrawnAt;

  late final _i1.ColumnInt withdrawnByUserId;

  late final _i1.ColumnString withdrawnReason;

  late final _i1.ColumnString status;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        organizationId,
        classroomId,
        childId,
        assignedAt,
        assignedByUserId,
        withdrawnAt,
        withdrawnByUserId,
        withdrawnReason,
        status,
        createdAt,
        updatedAt,
      ];
}

class ClassroomAssignmentInclude extends _i1.IncludeObject {
  ClassroomAssignmentInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ClassroomAssignment.t;
}

class ClassroomAssignmentIncludeList extends _i1.IncludeList {
  ClassroomAssignmentIncludeList._({
    _i1.WhereExpressionBuilder<ClassroomAssignmentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ClassroomAssignment.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ClassroomAssignment.t;
}

class ClassroomAssignmentRepository {
  const ClassroomAssignmentRepository._();

  /// Returns a list of [ClassroomAssignment]s matching the given query parameters.
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
  Future<List<ClassroomAssignment>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClassroomAssignmentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ClassroomAssignmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClassroomAssignmentTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<ClassroomAssignment>(
      where: where?.call(ClassroomAssignment.t),
      orderBy: orderBy?.call(ClassroomAssignment.t),
      orderByList: orderByList?.call(ClassroomAssignment.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [ClassroomAssignment] matching the given query parameters.
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
  Future<ClassroomAssignment?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClassroomAssignmentTable>? where,
    int? offset,
    _i1.OrderByBuilder<ClassroomAssignmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClassroomAssignmentTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<ClassroomAssignment>(
      where: where?.call(ClassroomAssignment.t),
      orderBy: orderBy?.call(ClassroomAssignment.t),
      orderByList: orderByList?.call(ClassroomAssignment.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [ClassroomAssignment] by its [id] or null if no such row exists.
  Future<ClassroomAssignment?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<ClassroomAssignment>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [ClassroomAssignment]s in the list and returns the inserted rows.
  ///
  /// The returned [ClassroomAssignment]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ClassroomAssignment>> insert(
    _i1.Session session,
    List<ClassroomAssignment> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ClassroomAssignment>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ClassroomAssignment] and returns the inserted row.
  ///
  /// The returned [ClassroomAssignment] will have its `id` field set.
  Future<ClassroomAssignment> insertRow(
    _i1.Session session,
    ClassroomAssignment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ClassroomAssignment>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ClassroomAssignment]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ClassroomAssignment>> update(
    _i1.Session session,
    List<ClassroomAssignment> rows, {
    _i1.ColumnSelections<ClassroomAssignmentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ClassroomAssignment>(
      rows,
      columns: columns?.call(ClassroomAssignment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ClassroomAssignment]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ClassroomAssignment> updateRow(
    _i1.Session session,
    ClassroomAssignment row, {
    _i1.ColumnSelections<ClassroomAssignmentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ClassroomAssignment>(
      row,
      columns: columns?.call(ClassroomAssignment.t),
      transaction: transaction,
    );
  }

  /// Deletes all [ClassroomAssignment]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ClassroomAssignment>> delete(
    _i1.Session session,
    List<ClassroomAssignment> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ClassroomAssignment>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ClassroomAssignment].
  Future<ClassroomAssignment> deleteRow(
    _i1.Session session,
    ClassroomAssignment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ClassroomAssignment>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ClassroomAssignment>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ClassroomAssignmentTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ClassroomAssignment>(
      where: where(ClassroomAssignment.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClassroomAssignmentTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ClassroomAssignment>(
      where: where?.call(ClassroomAssignment.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
