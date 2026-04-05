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

abstract class Classroom
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Classroom._({
    this.id,
    required this.organizationId,
    required this.name,
    this.description,
    this.ageGroupMin,
    this.ageGroupMax,
    required this.capacity,
    this.color,
    this.photoUrl,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Classroom({
    int? id,
    required int organizationId,
    required String name,
    String? description,
    int? ageGroupMin,
    int? ageGroupMax,
    required int capacity,
    String? color,
    String? photoUrl,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) = _ClassroomImpl;

  factory Classroom.fromJson(Map<String, dynamic> jsonSerialization) {
    return Classroom(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      ageGroupMin: jsonSerialization['ageGroupMin'] as int?,
      ageGroupMax: jsonSerialization['ageGroupMax'] as int?,
      capacity: jsonSerialization['capacity'] as int,
      color: jsonSerialization['color'] as String?,
      photoUrl: jsonSerialization['photoUrl'] as String?,
      status: jsonSerialization['status'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      deletedAt: jsonSerialization['deletedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['deletedAt']),
    );
  }

  static final t = ClassroomTable();

  static const db = ClassroomRepository._();

  @override
  int? id;

  int organizationId;

  String name;

  String? description;

  int? ageGroupMin;

  int? ageGroupMax;

  int capacity;

  String? color;

  String? photoUrl;

  String status;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime? deletedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Classroom]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Classroom copyWith({
    int? id,
    int? organizationId,
    String? name,
    String? description,
    int? ageGroupMin,
    int? ageGroupMax,
    int? capacity,
    String? color,
    String? photoUrl,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'organizationId': organizationId,
      'name': name,
      if (description != null) 'description': description,
      if (ageGroupMin != null) 'ageGroupMin': ageGroupMin,
      if (ageGroupMax != null) 'ageGroupMax': ageGroupMax,
      'capacity': capacity,
      if (color != null) 'color': color,
      if (photoUrl != null) 'photoUrl': photoUrl,
      'status': status,
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
      'name': name,
      if (description != null) 'description': description,
      if (ageGroupMin != null) 'ageGroupMin': ageGroupMin,
      if (ageGroupMax != null) 'ageGroupMax': ageGroupMax,
      'capacity': capacity,
      if (color != null) 'color': color,
      if (photoUrl != null) 'photoUrl': photoUrl,
      'status': status,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (deletedAt != null) 'deletedAt': deletedAt?.toJson(),
    };
  }

  static ClassroomInclude include() {
    return ClassroomInclude._();
  }

  static ClassroomIncludeList includeList({
    _i1.WhereExpressionBuilder<ClassroomTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ClassroomTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClassroomTable>? orderByList,
    ClassroomInclude? include,
  }) {
    return ClassroomIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Classroom.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Classroom.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClassroomImpl extends Classroom {
  _ClassroomImpl({
    int? id,
    required int organizationId,
    required String name,
    String? description,
    int? ageGroupMin,
    int? ageGroupMax,
    required int capacity,
    String? color,
    String? photoUrl,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          name: name,
          description: description,
          ageGroupMin: ageGroupMin,
          ageGroupMax: ageGroupMax,
          capacity: capacity,
          color: color,
          photoUrl: photoUrl,
          status: status,
          createdAt: createdAt,
          updatedAt: updatedAt,
          deletedAt: deletedAt,
        );

  /// Returns a shallow copy of this [Classroom]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Classroom copyWith({
    Object? id = _Undefined,
    int? organizationId,
    String? name,
    Object? description = _Undefined,
    Object? ageGroupMin = _Undefined,
    Object? ageGroupMax = _Undefined,
    int? capacity,
    Object? color = _Undefined,
    Object? photoUrl = _Undefined,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? deletedAt = _Undefined,
  }) {
    return Classroom(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      ageGroupMin: ageGroupMin is int? ? ageGroupMin : this.ageGroupMin,
      ageGroupMax: ageGroupMax is int? ? ageGroupMax : this.ageGroupMax,
      capacity: capacity ?? this.capacity,
      color: color is String? ? color : this.color,
      photoUrl: photoUrl is String? ? photoUrl : this.photoUrl,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt is DateTime? ? deletedAt : this.deletedAt,
    );
  }
}

class ClassroomTable extends _i1.Table<int?> {
  ClassroomTable({super.tableRelation}) : super(tableName: 'classroom') {
    organizationId = _i1.ColumnInt(
      'organizationId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    ageGroupMin = _i1.ColumnInt(
      'ageGroupMin',
      this,
    );
    ageGroupMax = _i1.ColumnInt(
      'ageGroupMax',
      this,
    );
    capacity = _i1.ColumnInt(
      'capacity',
      this,
    );
    color = _i1.ColumnString(
      'color',
      this,
    );
    photoUrl = _i1.ColumnString(
      'photoUrl',
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
    deletedAt = _i1.ColumnDateTime(
      'deletedAt',
      this,
    );
  }

  late final _i1.ColumnInt organizationId;

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnInt ageGroupMin;

  late final _i1.ColumnInt ageGroupMax;

  late final _i1.ColumnInt capacity;

  late final _i1.ColumnString color;

  late final _i1.ColumnString photoUrl;

  late final _i1.ColumnString status;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnDateTime deletedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        organizationId,
        name,
        description,
        ageGroupMin,
        ageGroupMax,
        capacity,
        color,
        photoUrl,
        status,
        createdAt,
        updatedAt,
        deletedAt,
      ];
}

class ClassroomInclude extends _i1.IncludeObject {
  ClassroomInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Classroom.t;
}

class ClassroomIncludeList extends _i1.IncludeList {
  ClassroomIncludeList._({
    _i1.WhereExpressionBuilder<ClassroomTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Classroom.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Classroom.t;
}

class ClassroomRepository {
  const ClassroomRepository._();

  /// Returns a list of [Classroom]s matching the given query parameters.
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
  Future<List<Classroom>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClassroomTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ClassroomTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClassroomTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Classroom>(
      where: where?.call(Classroom.t),
      orderBy: orderBy?.call(Classroom.t),
      orderByList: orderByList?.call(Classroom.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Classroom] matching the given query parameters.
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
  Future<Classroom?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClassroomTable>? where,
    int? offset,
    _i1.OrderByBuilder<ClassroomTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClassroomTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Classroom>(
      where: where?.call(Classroom.t),
      orderBy: orderBy?.call(Classroom.t),
      orderByList: orderByList?.call(Classroom.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Classroom] by its [id] or null if no such row exists.
  Future<Classroom?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Classroom>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Classroom]s in the list and returns the inserted rows.
  ///
  /// The returned [Classroom]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Classroom>> insert(
    _i1.Session session,
    List<Classroom> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Classroom>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Classroom] and returns the inserted row.
  ///
  /// The returned [Classroom] will have its `id` field set.
  Future<Classroom> insertRow(
    _i1.Session session,
    Classroom row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Classroom>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Classroom]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Classroom>> update(
    _i1.Session session,
    List<Classroom> rows, {
    _i1.ColumnSelections<ClassroomTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Classroom>(
      rows,
      columns: columns?.call(Classroom.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Classroom]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Classroom> updateRow(
    _i1.Session session,
    Classroom row, {
    _i1.ColumnSelections<ClassroomTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Classroom>(
      row,
      columns: columns?.call(Classroom.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Classroom]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Classroom>> delete(
    _i1.Session session,
    List<Classroom> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Classroom>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Classroom].
  Future<Classroom> deleteRow(
    _i1.Session session,
    Classroom row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Classroom>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Classroom>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ClassroomTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Classroom>(
      where: where(Classroom.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClassroomTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Classroom>(
      where: where?.call(Classroom.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
