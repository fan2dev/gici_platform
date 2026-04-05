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

abstract class Gallery
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  Gallery._({
    this.id,
    required this.organizationId,
    required this.title,
    this.description,
    required this.audienceType,
    this.audienceClassroomId,
    this.audienceChildId,
    required this.createdByUserId,
    required this.isPublished,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Gallery({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    required String title,
    String? description,
    required String audienceType,
    _i1.UuidValue? audienceClassroomId,
    _i1.UuidValue? audienceChildId,
    required _i1.UuidValue createdByUserId,
    required bool isPublished,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) = _GalleryImpl;

  factory Gallery.fromJson(Map<String, dynamic> jsonSerialization) {
    return Gallery(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      organizationId: _i1.UuidValueJsonExtension.fromJson(
          jsonSerialization['organizationId']),
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String?,
      audienceType: jsonSerialization['audienceType'] as String,
      audienceClassroomId: jsonSerialization['audienceClassroomId'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(
              jsonSerialization['audienceClassroomId']),
      audienceChildId: jsonSerialization['audienceChildId'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(
              jsonSerialization['audienceChildId']),
      createdByUserId: _i1.UuidValueJsonExtension.fromJson(
          jsonSerialization['createdByUserId']),
      isPublished: jsonSerialization['isPublished'] as bool,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      deletedAt: jsonSerialization['deletedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['deletedAt']),
    );
  }

  static final t = GalleryTable();

  static const db = GalleryRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue organizationId;

  String title;

  String? description;

  String audienceType;

  _i1.UuidValue? audienceClassroomId;

  _i1.UuidValue? audienceChildId;

  _i1.UuidValue createdByUserId;

  bool isPublished;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime? deletedAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [Gallery]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Gallery copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? organizationId,
    String? title,
    String? description,
    String? audienceType,
    _i1.UuidValue? audienceClassroomId,
    _i1.UuidValue? audienceChildId,
    _i1.UuidValue? createdByUserId,
    bool? isPublished,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      'title': title,
      if (description != null) 'description': description,
      'audienceType': audienceType,
      if (audienceClassroomId != null)
        'audienceClassroomId': audienceClassroomId?.toJson(),
      if (audienceChildId != null) 'audienceChildId': audienceChildId?.toJson(),
      'createdByUserId': createdByUserId.toJson(),
      'isPublished': isPublished,
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
      'title': title,
      if (description != null) 'description': description,
      'audienceType': audienceType,
      if (audienceClassroomId != null)
        'audienceClassroomId': audienceClassroomId?.toJson(),
      if (audienceChildId != null) 'audienceChildId': audienceChildId?.toJson(),
      'createdByUserId': createdByUserId.toJson(),
      'isPublished': isPublished,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (deletedAt != null) 'deletedAt': deletedAt?.toJson(),
    };
  }

  static GalleryInclude include() {
    return GalleryInclude._();
  }

  static GalleryIncludeList includeList({
    _i1.WhereExpressionBuilder<GalleryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<GalleryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<GalleryTable>? orderByList,
    GalleryInclude? include,
  }) {
    return GalleryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Gallery.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Gallery.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _GalleryImpl extends Gallery {
  _GalleryImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    required String title,
    String? description,
    required String audienceType,
    _i1.UuidValue? audienceClassroomId,
    _i1.UuidValue? audienceChildId,
    required _i1.UuidValue createdByUserId,
    required bool isPublished,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          title: title,
          description: description,
          audienceType: audienceType,
          audienceClassroomId: audienceClassroomId,
          audienceChildId: audienceChildId,
          createdByUserId: createdByUserId,
          isPublished: isPublished,
          createdAt: createdAt,
          updatedAt: updatedAt,
          deletedAt: deletedAt,
        );

  /// Returns a shallow copy of this [Gallery]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Gallery copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? organizationId,
    String? title,
    Object? description = _Undefined,
    String? audienceType,
    Object? audienceClassroomId = _Undefined,
    Object? audienceChildId = _Undefined,
    _i1.UuidValue? createdByUserId,
    bool? isPublished,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? deletedAt = _Undefined,
  }) {
    return Gallery(
      id: id is _i1.UuidValue? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      title: title ?? this.title,
      description: description is String? ? description : this.description,
      audienceType: audienceType ?? this.audienceType,
      audienceClassroomId: audienceClassroomId is _i1.UuidValue?
          ? audienceClassroomId
          : this.audienceClassroomId,
      audienceChildId: audienceChildId is _i1.UuidValue?
          ? audienceChildId
          : this.audienceChildId,
      createdByUserId: createdByUserId ?? this.createdByUserId,
      isPublished: isPublished ?? this.isPublished,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt is DateTime? ? deletedAt : this.deletedAt,
    );
  }
}

class GalleryTable extends _i1.Table<_i1.UuidValue?> {
  GalleryTable({super.tableRelation}) : super(tableName: 'gallery') {
    organizationId = _i1.ColumnUuid(
      'organizationId',
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
    audienceType = _i1.ColumnString(
      'audienceType',
      this,
    );
    audienceClassroomId = _i1.ColumnUuid(
      'audienceClassroomId',
      this,
    );
    audienceChildId = _i1.ColumnUuid(
      'audienceChildId',
      this,
    );
    createdByUserId = _i1.ColumnUuid(
      'createdByUserId',
      this,
    );
    isPublished = _i1.ColumnBool(
      'isPublished',
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

  late final _i1.ColumnString title;

  late final _i1.ColumnString description;

  late final _i1.ColumnString audienceType;

  late final _i1.ColumnUuid audienceClassroomId;

  late final _i1.ColumnUuid audienceChildId;

  late final _i1.ColumnUuid createdByUserId;

  late final _i1.ColumnBool isPublished;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnDateTime deletedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        organizationId,
        title,
        description,
        audienceType,
        audienceClassroomId,
        audienceChildId,
        createdByUserId,
        isPublished,
        createdAt,
        updatedAt,
        deletedAt,
      ];
}

class GalleryInclude extends _i1.IncludeObject {
  GalleryInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => Gallery.t;
}

class GalleryIncludeList extends _i1.IncludeList {
  GalleryIncludeList._({
    _i1.WhereExpressionBuilder<GalleryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Gallery.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => Gallery.t;
}

class GalleryRepository {
  const GalleryRepository._();

  /// Returns a list of [Gallery]s matching the given query parameters.
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
  Future<List<Gallery>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<GalleryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<GalleryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<GalleryTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Gallery>(
      where: where?.call(Gallery.t),
      orderBy: orderBy?.call(Gallery.t),
      orderByList: orderByList?.call(Gallery.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Gallery] matching the given query parameters.
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
  Future<Gallery?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<GalleryTable>? where,
    int? offset,
    _i1.OrderByBuilder<GalleryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<GalleryTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Gallery>(
      where: where?.call(Gallery.t),
      orderBy: orderBy?.call(Gallery.t),
      orderByList: orderByList?.call(Gallery.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Gallery] by its [id] or null if no such row exists.
  Future<Gallery?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Gallery>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Gallery]s in the list and returns the inserted rows.
  ///
  /// The returned [Gallery]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Gallery>> insert(
    _i1.Session session,
    List<Gallery> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Gallery>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Gallery] and returns the inserted row.
  ///
  /// The returned [Gallery] will have its `id` field set.
  Future<Gallery> insertRow(
    _i1.Session session,
    Gallery row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Gallery>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Gallery]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Gallery>> update(
    _i1.Session session,
    List<Gallery> rows, {
    _i1.ColumnSelections<GalleryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Gallery>(
      rows,
      columns: columns?.call(Gallery.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Gallery]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Gallery> updateRow(
    _i1.Session session,
    Gallery row, {
    _i1.ColumnSelections<GalleryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Gallery>(
      row,
      columns: columns?.call(Gallery.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Gallery]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Gallery>> delete(
    _i1.Session session,
    List<Gallery> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Gallery>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Gallery].
  Future<Gallery> deleteRow(
    _i1.Session session,
    Gallery row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Gallery>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Gallery>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<GalleryTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Gallery>(
      where: where(Gallery.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<GalleryTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Gallery>(
      where: where?.call(Gallery.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
