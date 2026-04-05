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

abstract class ChatConversation
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ChatConversation._({
    this.id,
    required this.organizationId,
    this.title,
    required this.conversationType,
    this.relatedChildId,
    this.relatedClassroomId,
    required this.createdByUserId,
    required this.isArchived,
    this.lastMessageAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChatConversation({
    int? id,
    required int organizationId,
    String? title,
    required String conversationType,
    int? relatedChildId,
    int? relatedClassroomId,
    required int createdByUserId,
    required bool isArchived,
    DateTime? lastMessageAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ChatConversationImpl;

  factory ChatConversation.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChatConversation(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      title: jsonSerialization['title'] as String?,
      conversationType: jsonSerialization['conversationType'] as String,
      relatedChildId: jsonSerialization['relatedChildId'] as int?,
      relatedClassroomId: jsonSerialization['relatedClassroomId'] as int?,
      createdByUserId: jsonSerialization['createdByUserId'] as int,
      isArchived: jsonSerialization['isArchived'] as bool,
      lastMessageAt: jsonSerialization['lastMessageAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastMessageAt']),
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = ChatConversationTable();

  static const db = ChatConversationRepository._();

  @override
  int? id;

  int organizationId;

  String? title;

  String conversationType;

  int? relatedChildId;

  int? relatedClassroomId;

  int createdByUserId;

  bool isArchived;

  DateTime? lastMessageAt;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ChatConversation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ChatConversation copyWith({
    int? id,
    int? organizationId,
    String? title,
    String? conversationType,
    int? relatedChildId,
    int? relatedClassroomId,
    int? createdByUserId,
    bool? isArchived,
    DateTime? lastMessageAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'organizationId': organizationId,
      if (title != null) 'title': title,
      'conversationType': conversationType,
      if (relatedChildId != null) 'relatedChildId': relatedChildId,
      if (relatedClassroomId != null) 'relatedClassroomId': relatedClassroomId,
      'createdByUserId': createdByUserId,
      'isArchived': isArchived,
      if (lastMessageAt != null) 'lastMessageAt': lastMessageAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'organizationId': organizationId,
      if (title != null) 'title': title,
      'conversationType': conversationType,
      if (relatedChildId != null) 'relatedChildId': relatedChildId,
      if (relatedClassroomId != null) 'relatedClassroomId': relatedClassroomId,
      'createdByUserId': createdByUserId,
      'isArchived': isArchived,
      if (lastMessageAt != null) 'lastMessageAt': lastMessageAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static ChatConversationInclude include() {
    return ChatConversationInclude._();
  }

  static ChatConversationIncludeList includeList({
    _i1.WhereExpressionBuilder<ChatConversationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChatConversationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChatConversationTable>? orderByList,
    ChatConversationInclude? include,
  }) {
    return ChatConversationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ChatConversation.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ChatConversation.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChatConversationImpl extends ChatConversation {
  _ChatConversationImpl({
    int? id,
    required int organizationId,
    String? title,
    required String conversationType,
    int? relatedChildId,
    int? relatedClassroomId,
    required int createdByUserId,
    required bool isArchived,
    DateTime? lastMessageAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          title: title,
          conversationType: conversationType,
          relatedChildId: relatedChildId,
          relatedClassroomId: relatedClassroomId,
          createdByUserId: createdByUserId,
          isArchived: isArchived,
          lastMessageAt: lastMessageAt,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [ChatConversation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ChatConversation copyWith({
    Object? id = _Undefined,
    int? organizationId,
    Object? title = _Undefined,
    String? conversationType,
    Object? relatedChildId = _Undefined,
    Object? relatedClassroomId = _Undefined,
    int? createdByUserId,
    bool? isArchived,
    Object? lastMessageAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ChatConversation(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      title: title is String? ? title : this.title,
      conversationType: conversationType ?? this.conversationType,
      relatedChildId:
          relatedChildId is int? ? relatedChildId : this.relatedChildId,
      relatedClassroomId: relatedClassroomId is int?
          ? relatedClassroomId
          : this.relatedClassroomId,
      createdByUserId: createdByUserId ?? this.createdByUserId,
      isArchived: isArchived ?? this.isArchived,
      lastMessageAt:
          lastMessageAt is DateTime? ? lastMessageAt : this.lastMessageAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ChatConversationTable extends _i1.Table<int?> {
  ChatConversationTable({super.tableRelation})
      : super(tableName: 'chat_conversation') {
    organizationId = _i1.ColumnInt(
      'organizationId',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    conversationType = _i1.ColumnString(
      'conversationType',
      this,
    );
    relatedChildId = _i1.ColumnInt(
      'relatedChildId',
      this,
    );
    relatedClassroomId = _i1.ColumnInt(
      'relatedClassroomId',
      this,
    );
    createdByUserId = _i1.ColumnInt(
      'createdByUserId',
      this,
    );
    isArchived = _i1.ColumnBool(
      'isArchived',
      this,
    );
    lastMessageAt = _i1.ColumnDateTime(
      'lastMessageAt',
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

  late final _i1.ColumnString title;

  late final _i1.ColumnString conversationType;

  late final _i1.ColumnInt relatedChildId;

  late final _i1.ColumnInt relatedClassroomId;

  late final _i1.ColumnInt createdByUserId;

  late final _i1.ColumnBool isArchived;

  late final _i1.ColumnDateTime lastMessageAt;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        organizationId,
        title,
        conversationType,
        relatedChildId,
        relatedClassroomId,
        createdByUserId,
        isArchived,
        lastMessageAt,
        createdAt,
        updatedAt,
      ];
}

class ChatConversationInclude extends _i1.IncludeObject {
  ChatConversationInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ChatConversation.t;
}

class ChatConversationIncludeList extends _i1.IncludeList {
  ChatConversationIncludeList._({
    _i1.WhereExpressionBuilder<ChatConversationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ChatConversation.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ChatConversation.t;
}

class ChatConversationRepository {
  const ChatConversationRepository._();

  /// Returns a list of [ChatConversation]s matching the given query parameters.
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
  Future<List<ChatConversation>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ChatConversationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChatConversationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChatConversationTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<ChatConversation>(
      where: where?.call(ChatConversation.t),
      orderBy: orderBy?.call(ChatConversation.t),
      orderByList: orderByList?.call(ChatConversation.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [ChatConversation] matching the given query parameters.
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
  Future<ChatConversation?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ChatConversationTable>? where,
    int? offset,
    _i1.OrderByBuilder<ChatConversationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChatConversationTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<ChatConversation>(
      where: where?.call(ChatConversation.t),
      orderBy: orderBy?.call(ChatConversation.t),
      orderByList: orderByList?.call(ChatConversation.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [ChatConversation] by its [id] or null if no such row exists.
  Future<ChatConversation?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<ChatConversation>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [ChatConversation]s in the list and returns the inserted rows.
  ///
  /// The returned [ChatConversation]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ChatConversation>> insert(
    _i1.Session session,
    List<ChatConversation> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ChatConversation>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ChatConversation] and returns the inserted row.
  ///
  /// The returned [ChatConversation] will have its `id` field set.
  Future<ChatConversation> insertRow(
    _i1.Session session,
    ChatConversation row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ChatConversation>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ChatConversation]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ChatConversation>> update(
    _i1.Session session,
    List<ChatConversation> rows, {
    _i1.ColumnSelections<ChatConversationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ChatConversation>(
      rows,
      columns: columns?.call(ChatConversation.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ChatConversation]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ChatConversation> updateRow(
    _i1.Session session,
    ChatConversation row, {
    _i1.ColumnSelections<ChatConversationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ChatConversation>(
      row,
      columns: columns?.call(ChatConversation.t),
      transaction: transaction,
    );
  }

  /// Deletes all [ChatConversation]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ChatConversation>> delete(
    _i1.Session session,
    List<ChatConversation> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ChatConversation>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ChatConversation].
  Future<ChatConversation> deleteRow(
    _i1.Session session,
    ChatConversation row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ChatConversation>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ChatConversation>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ChatConversationTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ChatConversation>(
      where: where(ChatConversation.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ChatConversationTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ChatConversation>(
      where: where?.call(ChatConversation.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
