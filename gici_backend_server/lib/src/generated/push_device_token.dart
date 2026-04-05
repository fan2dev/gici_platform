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

abstract class PushDeviceToken
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  PushDeviceToken._({
    this.id,
    required this.organizationId,
    required this.userId,
    required this.token,
    required this.platform,
    this.deviceId,
    this.deviceModel,
    this.appVersion,
    required this.isActive,
    required this.lastUsedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PushDeviceToken({
    int? id,
    required int organizationId,
    required int userId,
    required String token,
    required String platform,
    String? deviceId,
    String? deviceModel,
    String? appVersion,
    required bool isActive,
    required DateTime lastUsedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _PushDeviceTokenImpl;

  factory PushDeviceToken.fromJson(Map<String, dynamic> jsonSerialization) {
    return PushDeviceToken(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      userId: jsonSerialization['userId'] as int,
      token: jsonSerialization['token'] as String,
      platform: jsonSerialization['platform'] as String,
      deviceId: jsonSerialization['deviceId'] as String?,
      deviceModel: jsonSerialization['deviceModel'] as String?,
      appVersion: jsonSerialization['appVersion'] as String?,
      isActive: jsonSerialization['isActive'] as bool,
      lastUsedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['lastUsedAt']),
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = PushDeviceTokenTable();

  static const db = PushDeviceTokenRepository._();

  @override
  int? id;

  int organizationId;

  int userId;

  String token;

  String platform;

  String? deviceId;

  String? deviceModel;

  String? appVersion;

  bool isActive;

  DateTime lastUsedAt;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [PushDeviceToken]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PushDeviceToken copyWith({
    int? id,
    int? organizationId,
    int? userId,
    String? token,
    String? platform,
    String? deviceId,
    String? deviceModel,
    String? appVersion,
    bool? isActive,
    DateTime? lastUsedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'organizationId': organizationId,
      'userId': userId,
      'token': token,
      'platform': platform,
      if (deviceId != null) 'deviceId': deviceId,
      if (deviceModel != null) 'deviceModel': deviceModel,
      if (appVersion != null) 'appVersion': appVersion,
      'isActive': isActive,
      'lastUsedAt': lastUsedAt.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'organizationId': organizationId,
      'userId': userId,
      'token': token,
      'platform': platform,
      if (deviceId != null) 'deviceId': deviceId,
      if (deviceModel != null) 'deviceModel': deviceModel,
      if (appVersion != null) 'appVersion': appVersion,
      'isActive': isActive,
      'lastUsedAt': lastUsedAt.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static PushDeviceTokenInclude include() {
    return PushDeviceTokenInclude._();
  }

  static PushDeviceTokenIncludeList includeList({
    _i1.WhereExpressionBuilder<PushDeviceTokenTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PushDeviceTokenTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PushDeviceTokenTable>? orderByList,
    PushDeviceTokenInclude? include,
  }) {
    return PushDeviceTokenIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PushDeviceToken.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(PushDeviceToken.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PushDeviceTokenImpl extends PushDeviceToken {
  _PushDeviceTokenImpl({
    int? id,
    required int organizationId,
    required int userId,
    required String token,
    required String platform,
    String? deviceId,
    String? deviceModel,
    String? appVersion,
    required bool isActive,
    required DateTime lastUsedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          userId: userId,
          token: token,
          platform: platform,
          deviceId: deviceId,
          deviceModel: deviceModel,
          appVersion: appVersion,
          isActive: isActive,
          lastUsedAt: lastUsedAt,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [PushDeviceToken]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PushDeviceToken copyWith({
    Object? id = _Undefined,
    int? organizationId,
    int? userId,
    String? token,
    String? platform,
    Object? deviceId = _Undefined,
    Object? deviceModel = _Undefined,
    Object? appVersion = _Undefined,
    bool? isActive,
    DateTime? lastUsedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PushDeviceToken(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      userId: userId ?? this.userId,
      token: token ?? this.token,
      platform: platform ?? this.platform,
      deviceId: deviceId is String? ? deviceId : this.deviceId,
      deviceModel: deviceModel is String? ? deviceModel : this.deviceModel,
      appVersion: appVersion is String? ? appVersion : this.appVersion,
      isActive: isActive ?? this.isActive,
      lastUsedAt: lastUsedAt ?? this.lastUsedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class PushDeviceTokenTable extends _i1.Table<int?> {
  PushDeviceTokenTable({super.tableRelation})
      : super(tableName: 'push_device_token') {
    organizationId = _i1.ColumnInt(
      'organizationId',
      this,
    );
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    token = _i1.ColumnString(
      'token',
      this,
    );
    platform = _i1.ColumnString(
      'platform',
      this,
    );
    deviceId = _i1.ColumnString(
      'deviceId',
      this,
    );
    deviceModel = _i1.ColumnString(
      'deviceModel',
      this,
    );
    appVersion = _i1.ColumnString(
      'appVersion',
      this,
    );
    isActive = _i1.ColumnBool(
      'isActive',
      this,
    );
    lastUsedAt = _i1.ColumnDateTime(
      'lastUsedAt',
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

  late final _i1.ColumnString token;

  late final _i1.ColumnString platform;

  late final _i1.ColumnString deviceId;

  late final _i1.ColumnString deviceModel;

  late final _i1.ColumnString appVersion;

  late final _i1.ColumnBool isActive;

  late final _i1.ColumnDateTime lastUsedAt;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        organizationId,
        userId,
        token,
        platform,
        deviceId,
        deviceModel,
        appVersion,
        isActive,
        lastUsedAt,
        createdAt,
        updatedAt,
      ];
}

class PushDeviceTokenInclude extends _i1.IncludeObject {
  PushDeviceTokenInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => PushDeviceToken.t;
}

class PushDeviceTokenIncludeList extends _i1.IncludeList {
  PushDeviceTokenIncludeList._({
    _i1.WhereExpressionBuilder<PushDeviceTokenTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PushDeviceToken.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => PushDeviceToken.t;
}

class PushDeviceTokenRepository {
  const PushDeviceTokenRepository._();

  /// Returns a list of [PushDeviceToken]s matching the given query parameters.
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
  Future<List<PushDeviceToken>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PushDeviceTokenTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PushDeviceTokenTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PushDeviceTokenTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<PushDeviceToken>(
      where: where?.call(PushDeviceToken.t),
      orderBy: orderBy?.call(PushDeviceToken.t),
      orderByList: orderByList?.call(PushDeviceToken.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [PushDeviceToken] matching the given query parameters.
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
  Future<PushDeviceToken?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PushDeviceTokenTable>? where,
    int? offset,
    _i1.OrderByBuilder<PushDeviceTokenTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PushDeviceTokenTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<PushDeviceToken>(
      where: where?.call(PushDeviceToken.t),
      orderBy: orderBy?.call(PushDeviceToken.t),
      orderByList: orderByList?.call(PushDeviceToken.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [PushDeviceToken] by its [id] or null if no such row exists.
  Future<PushDeviceToken?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<PushDeviceToken>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [PushDeviceToken]s in the list and returns the inserted rows.
  ///
  /// The returned [PushDeviceToken]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<PushDeviceToken>> insert(
    _i1.Session session,
    List<PushDeviceToken> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<PushDeviceToken>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [PushDeviceToken] and returns the inserted row.
  ///
  /// The returned [PushDeviceToken] will have its `id` field set.
  Future<PushDeviceToken> insertRow(
    _i1.Session session,
    PushDeviceToken row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<PushDeviceToken>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [PushDeviceToken]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<PushDeviceToken>> update(
    _i1.Session session,
    List<PushDeviceToken> rows, {
    _i1.ColumnSelections<PushDeviceTokenTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<PushDeviceToken>(
      rows,
      columns: columns?.call(PushDeviceToken.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PushDeviceToken]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PushDeviceToken> updateRow(
    _i1.Session session,
    PushDeviceToken row, {
    _i1.ColumnSelections<PushDeviceTokenTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<PushDeviceToken>(
      row,
      columns: columns?.call(PushDeviceToken.t),
      transaction: transaction,
    );
  }

  /// Deletes all [PushDeviceToken]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<PushDeviceToken>> delete(
    _i1.Session session,
    List<PushDeviceToken> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<PushDeviceToken>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [PushDeviceToken].
  Future<PushDeviceToken> deleteRow(
    _i1.Session session,
    PushDeviceToken row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PushDeviceToken>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<PushDeviceToken>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PushDeviceTokenTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<PushDeviceToken>(
      where: where(PushDeviceToken.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PushDeviceTokenTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<PushDeviceToken>(
      where: where?.call(PushDeviceToken.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
