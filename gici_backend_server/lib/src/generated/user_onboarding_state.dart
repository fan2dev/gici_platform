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

abstract class UserOnboardingState
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  UserOnboardingState._({
    this.id,
    this.organizationId,
    required this.userId,
    this.introCompletedAt,
    this.termsAcceptedAt,
    this.completedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserOnboardingState({
    int? id,
    int? organizationId,
    required int userId,
    DateTime? introCompletedAt,
    DateTime? termsAcceptedAt,
    DateTime? completedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _UserOnboardingStateImpl;

  factory UserOnboardingState.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserOnboardingState(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int?,
      userId: jsonSerialization['userId'] as int,
      introCompletedAt: jsonSerialization['introCompletedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['introCompletedAt']),
      termsAcceptedAt: jsonSerialization['termsAcceptedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['termsAcceptedAt']),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt']),
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = UserOnboardingStateTable();

  static const db = UserOnboardingStateRepository._();

  @override
  int? id;

  int? organizationId;

  int userId;

  DateTime? introCompletedAt;

  DateTime? termsAcceptedAt;

  DateTime? completedAt;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [UserOnboardingState]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserOnboardingState copyWith({
    int? id,
    int? organizationId,
    int? userId,
    DateTime? introCompletedAt,
    DateTime? termsAcceptedAt,
    DateTime? completedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (organizationId != null) 'organizationId': organizationId,
      'userId': userId,
      if (introCompletedAt != null)
        'introCompletedAt': introCompletedAt?.toJson(),
      if (termsAcceptedAt != null) 'termsAcceptedAt': termsAcceptedAt?.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      if (organizationId != null) 'organizationId': organizationId,
      'userId': userId,
      if (introCompletedAt != null)
        'introCompletedAt': introCompletedAt?.toJson(),
      if (termsAcceptedAt != null) 'termsAcceptedAt': termsAcceptedAt?.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static UserOnboardingStateInclude include() {
    return UserOnboardingStateInclude._();
  }

  static UserOnboardingStateIncludeList includeList({
    _i1.WhereExpressionBuilder<UserOnboardingStateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserOnboardingStateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserOnboardingStateTable>? orderByList,
    UserOnboardingStateInclude? include,
  }) {
    return UserOnboardingStateIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserOnboardingState.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(UserOnboardingState.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserOnboardingStateImpl extends UserOnboardingState {
  _UserOnboardingStateImpl({
    int? id,
    int? organizationId,
    required int userId,
    DateTime? introCompletedAt,
    DateTime? termsAcceptedAt,
    DateTime? completedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          userId: userId,
          introCompletedAt: introCompletedAt,
          termsAcceptedAt: termsAcceptedAt,
          completedAt: completedAt,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [UserOnboardingState]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserOnboardingState copyWith({
    Object? id = _Undefined,
    Object? organizationId = _Undefined,
    int? userId,
    Object? introCompletedAt = _Undefined,
    Object? termsAcceptedAt = _Undefined,
    Object? completedAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserOnboardingState(
      id: id is int? ? id : this.id,
      organizationId:
          organizationId is int? ? organizationId : this.organizationId,
      userId: userId ?? this.userId,
      introCompletedAt: introCompletedAt is DateTime?
          ? introCompletedAt
          : this.introCompletedAt,
      termsAcceptedAt:
          termsAcceptedAt is DateTime? ? termsAcceptedAt : this.termsAcceptedAt,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class UserOnboardingStateTable extends _i1.Table<int?> {
  UserOnboardingStateTable({super.tableRelation})
      : super(tableName: 'user_onboarding_state') {
    organizationId = _i1.ColumnInt(
      'organizationId',
      this,
    );
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    introCompletedAt = _i1.ColumnDateTime(
      'introCompletedAt',
      this,
    );
    termsAcceptedAt = _i1.ColumnDateTime(
      'termsAcceptedAt',
      this,
    );
    completedAt = _i1.ColumnDateTime(
      'completedAt',
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

  late final _i1.ColumnInt userId;

  late final _i1.ColumnDateTime introCompletedAt;

  late final _i1.ColumnDateTime termsAcceptedAt;

  late final _i1.ColumnDateTime completedAt;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        organizationId,
        userId,
        introCompletedAt,
        termsAcceptedAt,
        completedAt,
        createdAt,
        updatedAt,
      ];
}

class UserOnboardingStateInclude extends _i1.IncludeObject {
  UserOnboardingStateInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => UserOnboardingState.t;
}

class UserOnboardingStateIncludeList extends _i1.IncludeList {
  UserOnboardingStateIncludeList._({
    _i1.WhereExpressionBuilder<UserOnboardingStateTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UserOnboardingState.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => UserOnboardingState.t;
}

class UserOnboardingStateRepository {
  const UserOnboardingStateRepository._();

  /// Returns a list of [UserOnboardingState]s matching the given query parameters.
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
  Future<List<UserOnboardingState>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserOnboardingStateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserOnboardingStateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserOnboardingStateTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<UserOnboardingState>(
      where: where?.call(UserOnboardingState.t),
      orderBy: orderBy?.call(UserOnboardingState.t),
      orderByList: orderByList?.call(UserOnboardingState.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [UserOnboardingState] matching the given query parameters.
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
  Future<UserOnboardingState?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserOnboardingStateTable>? where,
    int? offset,
    _i1.OrderByBuilder<UserOnboardingStateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserOnboardingStateTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<UserOnboardingState>(
      where: where?.call(UserOnboardingState.t),
      orderBy: orderBy?.call(UserOnboardingState.t),
      orderByList: orderByList?.call(UserOnboardingState.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [UserOnboardingState] by its [id] or null if no such row exists.
  Future<UserOnboardingState?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<UserOnboardingState>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [UserOnboardingState]s in the list and returns the inserted rows.
  ///
  /// The returned [UserOnboardingState]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<UserOnboardingState>> insert(
    _i1.Session session,
    List<UserOnboardingState> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<UserOnboardingState>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [UserOnboardingState] and returns the inserted row.
  ///
  /// The returned [UserOnboardingState] will have its `id` field set.
  Future<UserOnboardingState> insertRow(
    _i1.Session session,
    UserOnboardingState row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<UserOnboardingState>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [UserOnboardingState]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<UserOnboardingState>> update(
    _i1.Session session,
    List<UserOnboardingState> rows, {
    _i1.ColumnSelections<UserOnboardingStateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<UserOnboardingState>(
      rows,
      columns: columns?.call(UserOnboardingState.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserOnboardingState]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UserOnboardingState> updateRow(
    _i1.Session session,
    UserOnboardingState row, {
    _i1.ColumnSelections<UserOnboardingStateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<UserOnboardingState>(
      row,
      columns: columns?.call(UserOnboardingState.t),
      transaction: transaction,
    );
  }

  /// Deletes all [UserOnboardingState]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<UserOnboardingState>> delete(
    _i1.Session session,
    List<UserOnboardingState> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<UserOnboardingState>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [UserOnboardingState].
  Future<UserOnboardingState> deleteRow(
    _i1.Session session,
    UserOnboardingState row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UserOnboardingState>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<UserOnboardingState>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<UserOnboardingStateTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<UserOnboardingState>(
      where: where(UserOnboardingState.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserOnboardingStateTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<UserOnboardingState>(
      where: where?.call(UserOnboardingState.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
