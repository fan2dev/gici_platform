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

abstract class Child
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  Child._({
    this.id,
    required this.organizationId,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    this.gender,
    this.photoUrl,
    this.medicalNotes,
    this.dietaryNotes,
    this.allergies,
    this.emergencyContactName,
    this.emergencyContactPhone,
    this.enrollmentDate,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Child({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
    String? gender,
    String? photoUrl,
    String? medicalNotes,
    String? dietaryNotes,
    String? allergies,
    String? emergencyContactName,
    String? emergencyContactPhone,
    DateTime? enrollmentDate,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) = _ChildImpl;

  factory Child.fromJson(Map<String, dynamic> jsonSerialization) {
    return Child(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      organizationId: _i1.UuidValueJsonExtension.fromJson(
          jsonSerialization['organizationId']),
      firstName: jsonSerialization['firstName'] as String,
      lastName: jsonSerialization['lastName'] as String,
      dateOfBirth:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['dateOfBirth']),
      gender: jsonSerialization['gender'] as String?,
      photoUrl: jsonSerialization['photoUrl'] as String?,
      medicalNotes: jsonSerialization['medicalNotes'] as String?,
      dietaryNotes: jsonSerialization['dietaryNotes'] as String?,
      allergies: jsonSerialization['allergies'] as String?,
      emergencyContactName:
          jsonSerialization['emergencyContactName'] as String?,
      emergencyContactPhone:
          jsonSerialization['emergencyContactPhone'] as String?,
      enrollmentDate: jsonSerialization['enrollmentDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['enrollmentDate']),
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

  static final t = ChildTable();

  static const db = ChildRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue organizationId;

  String firstName;

  String lastName;

  DateTime dateOfBirth;

  String? gender;

  String? photoUrl;

  String? medicalNotes;

  String? dietaryNotes;

  String? allergies;

  String? emergencyContactName;

  String? emergencyContactPhone;

  DateTime? enrollmentDate;

  String status;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime? deletedAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [Child]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Child copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? organizationId,
    String? firstName,
    String? lastName,
    DateTime? dateOfBirth,
    String? gender,
    String? photoUrl,
    String? medicalNotes,
    String? dietaryNotes,
    String? allergies,
    String? emergencyContactName,
    String? emergencyContactPhone,
    DateTime? enrollmentDate,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      'firstName': firstName,
      'lastName': lastName,
      'dateOfBirth': dateOfBirth.toJson(),
      if (gender != null) 'gender': gender,
      if (photoUrl != null) 'photoUrl': photoUrl,
      if (medicalNotes != null) 'medicalNotes': medicalNotes,
      if (dietaryNotes != null) 'dietaryNotes': dietaryNotes,
      if (allergies != null) 'allergies': allergies,
      if (emergencyContactName != null)
        'emergencyContactName': emergencyContactName,
      if (emergencyContactPhone != null)
        'emergencyContactPhone': emergencyContactPhone,
      if (enrollmentDate != null) 'enrollmentDate': enrollmentDate?.toJson(),
      'status': status,
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
      'firstName': firstName,
      'lastName': lastName,
      'dateOfBirth': dateOfBirth.toJson(),
      if (gender != null) 'gender': gender,
      if (photoUrl != null) 'photoUrl': photoUrl,
      if (medicalNotes != null) 'medicalNotes': medicalNotes,
      if (dietaryNotes != null) 'dietaryNotes': dietaryNotes,
      if (allergies != null) 'allergies': allergies,
      if (emergencyContactName != null)
        'emergencyContactName': emergencyContactName,
      if (emergencyContactPhone != null)
        'emergencyContactPhone': emergencyContactPhone,
      if (enrollmentDate != null) 'enrollmentDate': enrollmentDate?.toJson(),
      'status': status,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (deletedAt != null) 'deletedAt': deletedAt?.toJson(),
    };
  }

  static ChildInclude include() {
    return ChildInclude._();
  }

  static ChildIncludeList includeList({
    _i1.WhereExpressionBuilder<ChildTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChildTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChildTable>? orderByList,
    ChildInclude? include,
  }) {
    return ChildIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Child.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Child.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChildImpl extends Child {
  _ChildImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
    String? gender,
    String? photoUrl,
    String? medicalNotes,
    String? dietaryNotes,
    String? allergies,
    String? emergencyContactName,
    String? emergencyContactPhone,
    DateTime? enrollmentDate,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          firstName: firstName,
          lastName: lastName,
          dateOfBirth: dateOfBirth,
          gender: gender,
          photoUrl: photoUrl,
          medicalNotes: medicalNotes,
          dietaryNotes: dietaryNotes,
          allergies: allergies,
          emergencyContactName: emergencyContactName,
          emergencyContactPhone: emergencyContactPhone,
          enrollmentDate: enrollmentDate,
          status: status,
          createdAt: createdAt,
          updatedAt: updatedAt,
          deletedAt: deletedAt,
        );

  /// Returns a shallow copy of this [Child]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Child copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? organizationId,
    String? firstName,
    String? lastName,
    DateTime? dateOfBirth,
    Object? gender = _Undefined,
    Object? photoUrl = _Undefined,
    Object? medicalNotes = _Undefined,
    Object? dietaryNotes = _Undefined,
    Object? allergies = _Undefined,
    Object? emergencyContactName = _Undefined,
    Object? emergencyContactPhone = _Undefined,
    Object? enrollmentDate = _Undefined,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? deletedAt = _Undefined,
  }) {
    return Child(
      id: id is _i1.UuidValue? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender is String? ? gender : this.gender,
      photoUrl: photoUrl is String? ? photoUrl : this.photoUrl,
      medicalNotes: medicalNotes is String? ? medicalNotes : this.medicalNotes,
      dietaryNotes: dietaryNotes is String? ? dietaryNotes : this.dietaryNotes,
      allergies: allergies is String? ? allergies : this.allergies,
      emergencyContactName: emergencyContactName is String?
          ? emergencyContactName
          : this.emergencyContactName,
      emergencyContactPhone: emergencyContactPhone is String?
          ? emergencyContactPhone
          : this.emergencyContactPhone,
      enrollmentDate:
          enrollmentDate is DateTime? ? enrollmentDate : this.enrollmentDate,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt is DateTime? ? deletedAt : this.deletedAt,
    );
  }
}

class ChildTable extends _i1.Table<_i1.UuidValue?> {
  ChildTable({super.tableRelation}) : super(tableName: 'child') {
    organizationId = _i1.ColumnUuid(
      'organizationId',
      this,
    );
    firstName = _i1.ColumnString(
      'firstName',
      this,
    );
    lastName = _i1.ColumnString(
      'lastName',
      this,
    );
    dateOfBirth = _i1.ColumnDateTime(
      'dateOfBirth',
      this,
    );
    gender = _i1.ColumnString(
      'gender',
      this,
    );
    photoUrl = _i1.ColumnString(
      'photoUrl',
      this,
    );
    medicalNotes = _i1.ColumnString(
      'medicalNotes',
      this,
    );
    dietaryNotes = _i1.ColumnString(
      'dietaryNotes',
      this,
    );
    allergies = _i1.ColumnString(
      'allergies',
      this,
    );
    emergencyContactName = _i1.ColumnString(
      'emergencyContactName',
      this,
    );
    emergencyContactPhone = _i1.ColumnString(
      'emergencyContactPhone',
      this,
    );
    enrollmentDate = _i1.ColumnDateTime(
      'enrollmentDate',
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

  late final _i1.ColumnUuid organizationId;

  late final _i1.ColumnString firstName;

  late final _i1.ColumnString lastName;

  late final _i1.ColumnDateTime dateOfBirth;

  late final _i1.ColumnString gender;

  late final _i1.ColumnString photoUrl;

  late final _i1.ColumnString medicalNotes;

  late final _i1.ColumnString dietaryNotes;

  late final _i1.ColumnString allergies;

  late final _i1.ColumnString emergencyContactName;

  late final _i1.ColumnString emergencyContactPhone;

  late final _i1.ColumnDateTime enrollmentDate;

  late final _i1.ColumnString status;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnDateTime deletedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        organizationId,
        firstName,
        lastName,
        dateOfBirth,
        gender,
        photoUrl,
        medicalNotes,
        dietaryNotes,
        allergies,
        emergencyContactName,
        emergencyContactPhone,
        enrollmentDate,
        status,
        createdAt,
        updatedAt,
        deletedAt,
      ];
}

class ChildInclude extends _i1.IncludeObject {
  ChildInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => Child.t;
}

class ChildIncludeList extends _i1.IncludeList {
  ChildIncludeList._({
    _i1.WhereExpressionBuilder<ChildTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Child.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => Child.t;
}

class ChildRepository {
  const ChildRepository._();

  /// Returns a list of [Child]s matching the given query parameters.
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
  Future<List<Child>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ChildTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChildTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChildTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Child>(
      where: where?.call(Child.t),
      orderBy: orderBy?.call(Child.t),
      orderByList: orderByList?.call(Child.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Child] matching the given query parameters.
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
  Future<Child?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ChildTable>? where,
    int? offset,
    _i1.OrderByBuilder<ChildTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChildTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Child>(
      where: where?.call(Child.t),
      orderBy: orderBy?.call(Child.t),
      orderByList: orderByList?.call(Child.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Child] by its [id] or null if no such row exists.
  Future<Child?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Child>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Child]s in the list and returns the inserted rows.
  ///
  /// The returned [Child]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Child>> insert(
    _i1.Session session,
    List<Child> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Child>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Child] and returns the inserted row.
  ///
  /// The returned [Child] will have its `id` field set.
  Future<Child> insertRow(
    _i1.Session session,
    Child row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Child>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Child]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Child>> update(
    _i1.Session session,
    List<Child> rows, {
    _i1.ColumnSelections<ChildTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Child>(
      rows,
      columns: columns?.call(Child.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Child]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Child> updateRow(
    _i1.Session session,
    Child row, {
    _i1.ColumnSelections<ChildTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Child>(
      row,
      columns: columns?.call(Child.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Child]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Child>> delete(
    _i1.Session session,
    List<Child> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Child>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Child].
  Future<Child> deleteRow(
    _i1.Session session,
    Child row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Child>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Child>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ChildTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Child>(
      where: where(Child.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ChildTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Child>(
      where: where?.call(Child.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
