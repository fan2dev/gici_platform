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

abstract class ChildGuardianRelation
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ChildGuardianRelation._({
    this.id,
    required this.organizationId,
    required this.childId,
    required this.guardianUserId,
    required this.relation,
    required this.isPrimary,
    required this.canPickup,
    required this.canViewReports,
    required this.canViewPhotos,
    this.emergencyContactOrder,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChildGuardianRelation({
    int? id,
    required int organizationId,
    required int childId,
    required int guardianUserId,
    required String relation,
    required bool isPrimary,
    required bool canPickup,
    required bool canViewReports,
    required bool canViewPhotos,
    int? emergencyContactOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ChildGuardianRelationImpl;

  factory ChildGuardianRelation.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return ChildGuardianRelation(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      childId: jsonSerialization['childId'] as int,
      guardianUserId: jsonSerialization['guardianUserId'] as int,
      relation: jsonSerialization['relation'] as String,
      isPrimary: jsonSerialization['isPrimary'] as bool,
      canPickup: jsonSerialization['canPickup'] as bool,
      canViewReports: jsonSerialization['canViewReports'] as bool,
      canViewPhotos: jsonSerialization['canViewPhotos'] as bool,
      emergencyContactOrder: jsonSerialization['emergencyContactOrder'] as int?,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = ChildGuardianRelationTable();

  static const db = ChildGuardianRelationRepository._();

  @override
  int? id;

  int organizationId;

  int childId;

  int guardianUserId;

  String relation;

  bool isPrimary;

  bool canPickup;

  bool canViewReports;

  bool canViewPhotos;

  int? emergencyContactOrder;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ChildGuardianRelation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ChildGuardianRelation copyWith({
    int? id,
    int? organizationId,
    int? childId,
    int? guardianUserId,
    String? relation,
    bool? isPrimary,
    bool? canPickup,
    bool? canViewReports,
    bool? canViewPhotos,
    int? emergencyContactOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'organizationId': organizationId,
      'childId': childId,
      'guardianUserId': guardianUserId,
      'relation': relation,
      'isPrimary': isPrimary,
      'canPickup': canPickup,
      'canViewReports': canViewReports,
      'canViewPhotos': canViewPhotos,
      if (emergencyContactOrder != null)
        'emergencyContactOrder': emergencyContactOrder,
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
      'guardianUserId': guardianUserId,
      'relation': relation,
      'isPrimary': isPrimary,
      'canPickup': canPickup,
      'canViewReports': canViewReports,
      'canViewPhotos': canViewPhotos,
      if (emergencyContactOrder != null)
        'emergencyContactOrder': emergencyContactOrder,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static ChildGuardianRelationInclude include() {
    return ChildGuardianRelationInclude._();
  }

  static ChildGuardianRelationIncludeList includeList({
    _i1.WhereExpressionBuilder<ChildGuardianRelationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChildGuardianRelationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChildGuardianRelationTable>? orderByList,
    ChildGuardianRelationInclude? include,
  }) {
    return ChildGuardianRelationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ChildGuardianRelation.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ChildGuardianRelation.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChildGuardianRelationImpl extends ChildGuardianRelation {
  _ChildGuardianRelationImpl({
    int? id,
    required int organizationId,
    required int childId,
    required int guardianUserId,
    required String relation,
    required bool isPrimary,
    required bool canPickup,
    required bool canViewReports,
    required bool canViewPhotos,
    int? emergencyContactOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          childId: childId,
          guardianUserId: guardianUserId,
          relation: relation,
          isPrimary: isPrimary,
          canPickup: canPickup,
          canViewReports: canViewReports,
          canViewPhotos: canViewPhotos,
          emergencyContactOrder: emergencyContactOrder,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [ChildGuardianRelation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ChildGuardianRelation copyWith({
    Object? id = _Undefined,
    int? organizationId,
    int? childId,
    int? guardianUserId,
    String? relation,
    bool? isPrimary,
    bool? canPickup,
    bool? canViewReports,
    bool? canViewPhotos,
    Object? emergencyContactOrder = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ChildGuardianRelation(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      childId: childId ?? this.childId,
      guardianUserId: guardianUserId ?? this.guardianUserId,
      relation: relation ?? this.relation,
      isPrimary: isPrimary ?? this.isPrimary,
      canPickup: canPickup ?? this.canPickup,
      canViewReports: canViewReports ?? this.canViewReports,
      canViewPhotos: canViewPhotos ?? this.canViewPhotos,
      emergencyContactOrder: emergencyContactOrder is int?
          ? emergencyContactOrder
          : this.emergencyContactOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ChildGuardianRelationTable extends _i1.Table<int?> {
  ChildGuardianRelationTable({super.tableRelation})
      : super(tableName: 'child_guardian_relation') {
    organizationId = _i1.ColumnInt(
      'organizationId',
      this,
    );
    childId = _i1.ColumnInt(
      'childId',
      this,
    );
    guardianUserId = _i1.ColumnInt(
      'guardianUserId',
      this,
    );
    relation = _i1.ColumnString(
      'relation',
      this,
    );
    isPrimary = _i1.ColumnBool(
      'isPrimary',
      this,
    );
    canPickup = _i1.ColumnBool(
      'canPickup',
      this,
    );
    canViewReports = _i1.ColumnBool(
      'canViewReports',
      this,
    );
    canViewPhotos = _i1.ColumnBool(
      'canViewPhotos',
      this,
    );
    emergencyContactOrder = _i1.ColumnInt(
      'emergencyContactOrder',
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

  late final _i1.ColumnInt guardianUserId;

  late final _i1.ColumnString relation;

  late final _i1.ColumnBool isPrimary;

  late final _i1.ColumnBool canPickup;

  late final _i1.ColumnBool canViewReports;

  late final _i1.ColumnBool canViewPhotos;

  late final _i1.ColumnInt emergencyContactOrder;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        organizationId,
        childId,
        guardianUserId,
        relation,
        isPrimary,
        canPickup,
        canViewReports,
        canViewPhotos,
        emergencyContactOrder,
        createdAt,
        updatedAt,
      ];
}

class ChildGuardianRelationInclude extends _i1.IncludeObject {
  ChildGuardianRelationInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ChildGuardianRelation.t;
}

class ChildGuardianRelationIncludeList extends _i1.IncludeList {
  ChildGuardianRelationIncludeList._({
    _i1.WhereExpressionBuilder<ChildGuardianRelationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ChildGuardianRelation.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ChildGuardianRelation.t;
}

class ChildGuardianRelationRepository {
  const ChildGuardianRelationRepository._();

  /// Returns a list of [ChildGuardianRelation]s matching the given query parameters.
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
  Future<List<ChildGuardianRelation>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ChildGuardianRelationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChildGuardianRelationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChildGuardianRelationTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<ChildGuardianRelation>(
      where: where?.call(ChildGuardianRelation.t),
      orderBy: orderBy?.call(ChildGuardianRelation.t),
      orderByList: orderByList?.call(ChildGuardianRelation.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [ChildGuardianRelation] matching the given query parameters.
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
  Future<ChildGuardianRelation?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ChildGuardianRelationTable>? where,
    int? offset,
    _i1.OrderByBuilder<ChildGuardianRelationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChildGuardianRelationTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<ChildGuardianRelation>(
      where: where?.call(ChildGuardianRelation.t),
      orderBy: orderBy?.call(ChildGuardianRelation.t),
      orderByList: orderByList?.call(ChildGuardianRelation.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [ChildGuardianRelation] by its [id] or null if no such row exists.
  Future<ChildGuardianRelation?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<ChildGuardianRelation>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [ChildGuardianRelation]s in the list and returns the inserted rows.
  ///
  /// The returned [ChildGuardianRelation]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ChildGuardianRelation>> insert(
    _i1.Session session,
    List<ChildGuardianRelation> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ChildGuardianRelation>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ChildGuardianRelation] and returns the inserted row.
  ///
  /// The returned [ChildGuardianRelation] will have its `id` field set.
  Future<ChildGuardianRelation> insertRow(
    _i1.Session session,
    ChildGuardianRelation row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ChildGuardianRelation>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ChildGuardianRelation]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ChildGuardianRelation>> update(
    _i1.Session session,
    List<ChildGuardianRelation> rows, {
    _i1.ColumnSelections<ChildGuardianRelationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ChildGuardianRelation>(
      rows,
      columns: columns?.call(ChildGuardianRelation.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ChildGuardianRelation]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ChildGuardianRelation> updateRow(
    _i1.Session session,
    ChildGuardianRelation row, {
    _i1.ColumnSelections<ChildGuardianRelationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ChildGuardianRelation>(
      row,
      columns: columns?.call(ChildGuardianRelation.t),
      transaction: transaction,
    );
  }

  /// Deletes all [ChildGuardianRelation]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ChildGuardianRelation>> delete(
    _i1.Session session,
    List<ChildGuardianRelation> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ChildGuardianRelation>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ChildGuardianRelation].
  Future<ChildGuardianRelation> deleteRow(
    _i1.Session session,
    ChildGuardianRelation row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ChildGuardianRelation>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ChildGuardianRelation>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ChildGuardianRelationTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ChildGuardianRelation>(
      where: where(ChildGuardianRelation.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ChildGuardianRelationTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ChildGuardianRelation>(
      where: where?.call(ChildGuardianRelation.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
