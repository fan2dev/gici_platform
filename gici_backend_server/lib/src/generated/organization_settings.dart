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

abstract class OrganizationSettings
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  OrganizationSettings._({
    this.id,
    required this.organizationId,
    required this.defaultLanguage,
    required this.timezone,
    required this.dateFormat,
    required this.timeFormat,
    required this.workingHoursStart,
    required this.workingHoursEnd,
    required this.maxChildrenPerClassroom,
    required this.earlyCheckInMinutes,
    required this.lateCheckOutMinutes,
    required this.guardianPhotoUploadEnabled,
    required this.chatEnabled,
    required this.pushNotificationsEnabled,
    required this.requireGuardianUploadApproval,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrganizationSettings({
    int? id,
    required int organizationId,
    required String defaultLanguage,
    required String timezone,
    required String dateFormat,
    required String timeFormat,
    required String workingHoursStart,
    required String workingHoursEnd,
    required int maxChildrenPerClassroom,
    required int earlyCheckInMinutes,
    required int lateCheckOutMinutes,
    required bool guardianPhotoUploadEnabled,
    required bool chatEnabled,
    required bool pushNotificationsEnabled,
    required bool requireGuardianUploadApproval,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _OrganizationSettingsImpl;

  factory OrganizationSettings.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return OrganizationSettings(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      defaultLanguage: jsonSerialization['defaultLanguage'] as String,
      timezone: jsonSerialization['timezone'] as String,
      dateFormat: jsonSerialization['dateFormat'] as String,
      timeFormat: jsonSerialization['timeFormat'] as String,
      workingHoursStart: jsonSerialization['workingHoursStart'] as String,
      workingHoursEnd: jsonSerialization['workingHoursEnd'] as String,
      maxChildrenPerClassroom:
          jsonSerialization['maxChildrenPerClassroom'] as int,
      earlyCheckInMinutes: jsonSerialization['earlyCheckInMinutes'] as int,
      lateCheckOutMinutes: jsonSerialization['lateCheckOutMinutes'] as int,
      guardianPhotoUploadEnabled:
          jsonSerialization['guardianPhotoUploadEnabled'] as bool,
      chatEnabled: jsonSerialization['chatEnabled'] as bool,
      pushNotificationsEnabled:
          jsonSerialization['pushNotificationsEnabled'] as bool,
      requireGuardianUploadApproval:
          jsonSerialization['requireGuardianUploadApproval'] as bool,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = OrganizationSettingsTable();

  static const db = OrganizationSettingsRepository._();

  @override
  int? id;

  int organizationId;

  String defaultLanguage;

  String timezone;

  String dateFormat;

  String timeFormat;

  String workingHoursStart;

  String workingHoursEnd;

  int maxChildrenPerClassroom;

  int earlyCheckInMinutes;

  int lateCheckOutMinutes;

  bool guardianPhotoUploadEnabled;

  bool chatEnabled;

  bool pushNotificationsEnabled;

  bool requireGuardianUploadApproval;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [OrganizationSettings]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OrganizationSettings copyWith({
    int? id,
    int? organizationId,
    String? defaultLanguage,
    String? timezone,
    String? dateFormat,
    String? timeFormat,
    String? workingHoursStart,
    String? workingHoursEnd,
    int? maxChildrenPerClassroom,
    int? earlyCheckInMinutes,
    int? lateCheckOutMinutes,
    bool? guardianPhotoUploadEnabled,
    bool? chatEnabled,
    bool? pushNotificationsEnabled,
    bool? requireGuardianUploadApproval,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'organizationId': organizationId,
      'defaultLanguage': defaultLanguage,
      'timezone': timezone,
      'dateFormat': dateFormat,
      'timeFormat': timeFormat,
      'workingHoursStart': workingHoursStart,
      'workingHoursEnd': workingHoursEnd,
      'maxChildrenPerClassroom': maxChildrenPerClassroom,
      'earlyCheckInMinutes': earlyCheckInMinutes,
      'lateCheckOutMinutes': lateCheckOutMinutes,
      'guardianPhotoUploadEnabled': guardianPhotoUploadEnabled,
      'chatEnabled': chatEnabled,
      'pushNotificationsEnabled': pushNotificationsEnabled,
      'requireGuardianUploadApproval': requireGuardianUploadApproval,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'organizationId': organizationId,
      'defaultLanguage': defaultLanguage,
      'timezone': timezone,
      'dateFormat': dateFormat,
      'timeFormat': timeFormat,
      'workingHoursStart': workingHoursStart,
      'workingHoursEnd': workingHoursEnd,
      'maxChildrenPerClassroom': maxChildrenPerClassroom,
      'earlyCheckInMinutes': earlyCheckInMinutes,
      'lateCheckOutMinutes': lateCheckOutMinutes,
      'guardianPhotoUploadEnabled': guardianPhotoUploadEnabled,
      'chatEnabled': chatEnabled,
      'pushNotificationsEnabled': pushNotificationsEnabled,
      'requireGuardianUploadApproval': requireGuardianUploadApproval,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static OrganizationSettingsInclude include() {
    return OrganizationSettingsInclude._();
  }

  static OrganizationSettingsIncludeList includeList({
    _i1.WhereExpressionBuilder<OrganizationSettingsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrganizationSettingsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrganizationSettingsTable>? orderByList,
    OrganizationSettingsInclude? include,
  }) {
    return OrganizationSettingsIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OrganizationSettings.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(OrganizationSettings.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OrganizationSettingsImpl extends OrganizationSettings {
  _OrganizationSettingsImpl({
    int? id,
    required int organizationId,
    required String defaultLanguage,
    required String timezone,
    required String dateFormat,
    required String timeFormat,
    required String workingHoursStart,
    required String workingHoursEnd,
    required int maxChildrenPerClassroom,
    required int earlyCheckInMinutes,
    required int lateCheckOutMinutes,
    required bool guardianPhotoUploadEnabled,
    required bool chatEnabled,
    required bool pushNotificationsEnabled,
    required bool requireGuardianUploadApproval,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          defaultLanguage: defaultLanguage,
          timezone: timezone,
          dateFormat: dateFormat,
          timeFormat: timeFormat,
          workingHoursStart: workingHoursStart,
          workingHoursEnd: workingHoursEnd,
          maxChildrenPerClassroom: maxChildrenPerClassroom,
          earlyCheckInMinutes: earlyCheckInMinutes,
          lateCheckOutMinutes: lateCheckOutMinutes,
          guardianPhotoUploadEnabled: guardianPhotoUploadEnabled,
          chatEnabled: chatEnabled,
          pushNotificationsEnabled: pushNotificationsEnabled,
          requireGuardianUploadApproval: requireGuardianUploadApproval,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [OrganizationSettings]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OrganizationSettings copyWith({
    Object? id = _Undefined,
    int? organizationId,
    String? defaultLanguage,
    String? timezone,
    String? dateFormat,
    String? timeFormat,
    String? workingHoursStart,
    String? workingHoursEnd,
    int? maxChildrenPerClassroom,
    int? earlyCheckInMinutes,
    int? lateCheckOutMinutes,
    bool? guardianPhotoUploadEnabled,
    bool? chatEnabled,
    bool? pushNotificationsEnabled,
    bool? requireGuardianUploadApproval,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return OrganizationSettings(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      defaultLanguage: defaultLanguage ?? this.defaultLanguage,
      timezone: timezone ?? this.timezone,
      dateFormat: dateFormat ?? this.dateFormat,
      timeFormat: timeFormat ?? this.timeFormat,
      workingHoursStart: workingHoursStart ?? this.workingHoursStart,
      workingHoursEnd: workingHoursEnd ?? this.workingHoursEnd,
      maxChildrenPerClassroom:
          maxChildrenPerClassroom ?? this.maxChildrenPerClassroom,
      earlyCheckInMinutes: earlyCheckInMinutes ?? this.earlyCheckInMinutes,
      lateCheckOutMinutes: lateCheckOutMinutes ?? this.lateCheckOutMinutes,
      guardianPhotoUploadEnabled:
          guardianPhotoUploadEnabled ?? this.guardianPhotoUploadEnabled,
      chatEnabled: chatEnabled ?? this.chatEnabled,
      pushNotificationsEnabled:
          pushNotificationsEnabled ?? this.pushNotificationsEnabled,
      requireGuardianUploadApproval:
          requireGuardianUploadApproval ?? this.requireGuardianUploadApproval,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class OrganizationSettingsTable extends _i1.Table<int?> {
  OrganizationSettingsTable({super.tableRelation})
      : super(tableName: 'organization_settings') {
    organizationId = _i1.ColumnInt(
      'organizationId',
      this,
    );
    defaultLanguage = _i1.ColumnString(
      'defaultLanguage',
      this,
    );
    timezone = _i1.ColumnString(
      'timezone',
      this,
    );
    dateFormat = _i1.ColumnString(
      'dateFormat',
      this,
    );
    timeFormat = _i1.ColumnString(
      'timeFormat',
      this,
    );
    workingHoursStart = _i1.ColumnString(
      'workingHoursStart',
      this,
    );
    workingHoursEnd = _i1.ColumnString(
      'workingHoursEnd',
      this,
    );
    maxChildrenPerClassroom = _i1.ColumnInt(
      'maxChildrenPerClassroom',
      this,
    );
    earlyCheckInMinutes = _i1.ColumnInt(
      'earlyCheckInMinutes',
      this,
    );
    lateCheckOutMinutes = _i1.ColumnInt(
      'lateCheckOutMinutes',
      this,
    );
    guardianPhotoUploadEnabled = _i1.ColumnBool(
      'guardianPhotoUploadEnabled',
      this,
    );
    chatEnabled = _i1.ColumnBool(
      'chatEnabled',
      this,
    );
    pushNotificationsEnabled = _i1.ColumnBool(
      'pushNotificationsEnabled',
      this,
    );
    requireGuardianUploadApproval = _i1.ColumnBool(
      'requireGuardianUploadApproval',
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

  late final _i1.ColumnString defaultLanguage;

  late final _i1.ColumnString timezone;

  late final _i1.ColumnString dateFormat;

  late final _i1.ColumnString timeFormat;

  late final _i1.ColumnString workingHoursStart;

  late final _i1.ColumnString workingHoursEnd;

  late final _i1.ColumnInt maxChildrenPerClassroom;

  late final _i1.ColumnInt earlyCheckInMinutes;

  late final _i1.ColumnInt lateCheckOutMinutes;

  late final _i1.ColumnBool guardianPhotoUploadEnabled;

  late final _i1.ColumnBool chatEnabled;

  late final _i1.ColumnBool pushNotificationsEnabled;

  late final _i1.ColumnBool requireGuardianUploadApproval;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        organizationId,
        defaultLanguage,
        timezone,
        dateFormat,
        timeFormat,
        workingHoursStart,
        workingHoursEnd,
        maxChildrenPerClassroom,
        earlyCheckInMinutes,
        lateCheckOutMinutes,
        guardianPhotoUploadEnabled,
        chatEnabled,
        pushNotificationsEnabled,
        requireGuardianUploadApproval,
        createdAt,
        updatedAt,
      ];
}

class OrganizationSettingsInclude extends _i1.IncludeObject {
  OrganizationSettingsInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => OrganizationSettings.t;
}

class OrganizationSettingsIncludeList extends _i1.IncludeList {
  OrganizationSettingsIncludeList._({
    _i1.WhereExpressionBuilder<OrganizationSettingsTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(OrganizationSettings.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => OrganizationSettings.t;
}

class OrganizationSettingsRepository {
  const OrganizationSettingsRepository._();

  /// Returns a list of [OrganizationSettings]s matching the given query parameters.
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
  Future<List<OrganizationSettings>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OrganizationSettingsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrganizationSettingsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrganizationSettingsTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<OrganizationSettings>(
      where: where?.call(OrganizationSettings.t),
      orderBy: orderBy?.call(OrganizationSettings.t),
      orderByList: orderByList?.call(OrganizationSettings.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [OrganizationSettings] matching the given query parameters.
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
  Future<OrganizationSettings?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OrganizationSettingsTable>? where,
    int? offset,
    _i1.OrderByBuilder<OrganizationSettingsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrganizationSettingsTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<OrganizationSettings>(
      where: where?.call(OrganizationSettings.t),
      orderBy: orderBy?.call(OrganizationSettings.t),
      orderByList: orderByList?.call(OrganizationSettings.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [OrganizationSettings] by its [id] or null if no such row exists.
  Future<OrganizationSettings?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<OrganizationSettings>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [OrganizationSettings]s in the list and returns the inserted rows.
  ///
  /// The returned [OrganizationSettings]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<OrganizationSettings>> insert(
    _i1.Session session,
    List<OrganizationSettings> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<OrganizationSettings>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [OrganizationSettings] and returns the inserted row.
  ///
  /// The returned [OrganizationSettings] will have its `id` field set.
  Future<OrganizationSettings> insertRow(
    _i1.Session session,
    OrganizationSettings row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<OrganizationSettings>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [OrganizationSettings]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<OrganizationSettings>> update(
    _i1.Session session,
    List<OrganizationSettings> rows, {
    _i1.ColumnSelections<OrganizationSettingsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<OrganizationSettings>(
      rows,
      columns: columns?.call(OrganizationSettings.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OrganizationSettings]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<OrganizationSettings> updateRow(
    _i1.Session session,
    OrganizationSettings row, {
    _i1.ColumnSelections<OrganizationSettingsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<OrganizationSettings>(
      row,
      columns: columns?.call(OrganizationSettings.t),
      transaction: transaction,
    );
  }

  /// Deletes all [OrganizationSettings]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<OrganizationSettings>> delete(
    _i1.Session session,
    List<OrganizationSettings> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<OrganizationSettings>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [OrganizationSettings].
  Future<OrganizationSettings> deleteRow(
    _i1.Session session,
    OrganizationSettings row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<OrganizationSettings>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<OrganizationSettings>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<OrganizationSettingsTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<OrganizationSettings>(
      where: where(OrganizationSettings.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OrganizationSettingsTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<OrganizationSettings>(
      where: where?.call(OrganizationSettings.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
