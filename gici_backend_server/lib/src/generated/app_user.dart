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

abstract class AppUser
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  AppUser._({
    this.id,
    this.serverpodUserId,
    this.organizationId,
    required this.email,
    required this.passwordHash,
    required this.firstName,
    required this.lastName,
    this.phone,
    this.avatarUrl,
    this.dni,
    this.address,
    this.gender,
    required this.role,
    required this.isActive,
    required this.emailVerified,
    required this.phoneVerified,
    this.lastLoginAt,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory AppUser({
    _i1.UuidValue? id,
    int? serverpodUserId,
    _i1.UuidValue? organizationId,
    required String email,
    required String passwordHash,
    required String firstName,
    required String lastName,
    String? phone,
    String? avatarUrl,
    String? dni,
    String? address,
    String? gender,
    required String role,
    required bool isActive,
    required bool emailVerified,
    required bool phoneVerified,
    DateTime? lastLoginAt,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) = _AppUserImpl;

  factory AppUser.fromJson(Map<String, dynamic> jsonSerialization) {
    return AppUser(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      serverpodUserId: jsonSerialization['serverpodUserId'] as int?,
      organizationId: jsonSerialization['organizationId'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(
              jsonSerialization['organizationId']),
      email: jsonSerialization['email'] as String,
      passwordHash: jsonSerialization['passwordHash'] as String,
      firstName: jsonSerialization['firstName'] as String,
      lastName: jsonSerialization['lastName'] as String,
      phone: jsonSerialization['phone'] as String?,
      avatarUrl: jsonSerialization['avatarUrl'] as String?,
      dni: jsonSerialization['dni'] as String?,
      address: jsonSerialization['address'] as String?,
      gender: jsonSerialization['gender'] as String?,
      role: jsonSerialization['role'] as String,
      isActive: jsonSerialization['isActive'] as bool,
      emailVerified: jsonSerialization['emailVerified'] as bool,
      phoneVerified: jsonSerialization['phoneVerified'] as bool,
      lastLoginAt: jsonSerialization['lastLoginAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastLoginAt']),
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      deletedAt: jsonSerialization['deletedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['deletedAt']),
    );
  }

  static final t = AppUserTable();

  static const db = AppUserRepository._();

  @override
  _i1.UuidValue? id;

  int? serverpodUserId;

  _i1.UuidValue? organizationId;

  String email;

  String passwordHash;

  String firstName;

  String lastName;

  String? phone;

  String? avatarUrl;

  String? dni;

  String? address;

  String? gender;

  String role;

  bool isActive;

  bool emailVerified;

  bool phoneVerified;

  DateTime? lastLoginAt;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime? deletedAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [AppUser]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AppUser copyWith({
    _i1.UuidValue? id,
    int? serverpodUserId,
    _i1.UuidValue? organizationId,
    String? email,
    String? passwordHash,
    String? firstName,
    String? lastName,
    String? phone,
    String? avatarUrl,
    String? dni,
    String? address,
    String? gender,
    String? role,
    bool? isActive,
    bool? emailVerified,
    bool? phoneVerified,
    DateTime? lastLoginAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id?.toJson(),
      if (serverpodUserId != null) 'serverpodUserId': serverpodUserId,
      if (organizationId != null) 'organizationId': organizationId?.toJson(),
      'email': email,
      'passwordHash': passwordHash,
      'firstName': firstName,
      'lastName': lastName,
      if (phone != null) 'phone': phone,
      if (avatarUrl != null) 'avatarUrl': avatarUrl,
      if (dni != null) 'dni': dni,
      if (address != null) 'address': address,
      if (gender != null) 'gender': gender,
      'role': role,
      'isActive': isActive,
      'emailVerified': emailVerified,
      'phoneVerified': phoneVerified,
      if (lastLoginAt != null) 'lastLoginAt': lastLoginAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (deletedAt != null) 'deletedAt': deletedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id?.toJson(),
      if (serverpodUserId != null) 'serverpodUserId': serverpodUserId,
      if (organizationId != null) 'organizationId': organizationId?.toJson(),
      'email': email,
      'passwordHash': passwordHash,
      'firstName': firstName,
      'lastName': lastName,
      if (phone != null) 'phone': phone,
      if (avatarUrl != null) 'avatarUrl': avatarUrl,
      if (dni != null) 'dni': dni,
      if (address != null) 'address': address,
      if (gender != null) 'gender': gender,
      'role': role,
      'isActive': isActive,
      'emailVerified': emailVerified,
      'phoneVerified': phoneVerified,
      if (lastLoginAt != null) 'lastLoginAt': lastLoginAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (deletedAt != null) 'deletedAt': deletedAt?.toJson(),
    };
  }

  static AppUserInclude include() {
    return AppUserInclude._();
  }

  static AppUserIncludeList includeList({
    _i1.WhereExpressionBuilder<AppUserTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AppUserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AppUserTable>? orderByList,
    AppUserInclude? include,
  }) {
    return AppUserIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AppUser.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AppUser.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AppUserImpl extends AppUser {
  _AppUserImpl({
    _i1.UuidValue? id,
    int? serverpodUserId,
    _i1.UuidValue? organizationId,
    required String email,
    required String passwordHash,
    required String firstName,
    required String lastName,
    String? phone,
    String? avatarUrl,
    String? dni,
    String? address,
    String? gender,
    required String role,
    required bool isActive,
    required bool emailVerified,
    required bool phoneVerified,
    DateTime? lastLoginAt,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) : super._(
          id: id,
          serverpodUserId: serverpodUserId,
          organizationId: organizationId,
          email: email,
          passwordHash: passwordHash,
          firstName: firstName,
          lastName: lastName,
          phone: phone,
          avatarUrl: avatarUrl,
          dni: dni,
          address: address,
          gender: gender,
          role: role,
          isActive: isActive,
          emailVerified: emailVerified,
          phoneVerified: phoneVerified,
          lastLoginAt: lastLoginAt,
          createdAt: createdAt,
          updatedAt: updatedAt,
          deletedAt: deletedAt,
        );

  /// Returns a shallow copy of this [AppUser]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AppUser copyWith({
    Object? id = _Undefined,
    Object? serverpodUserId = _Undefined,
    Object? organizationId = _Undefined,
    String? email,
    String? passwordHash,
    String? firstName,
    String? lastName,
    Object? phone = _Undefined,
    Object? avatarUrl = _Undefined,
    Object? dni = _Undefined,
    Object? address = _Undefined,
    Object? gender = _Undefined,
    String? role,
    bool? isActive,
    bool? emailVerified,
    bool? phoneVerified,
    Object? lastLoginAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? deletedAt = _Undefined,
  }) {
    return AppUser(
      id: id is _i1.UuidValue? ? id : this.id,
      serverpodUserId:
          serverpodUserId is int? ? serverpodUserId : this.serverpodUserId,
      organizationId: organizationId is _i1.UuidValue?
          ? organizationId
          : this.organizationId,
      email: email ?? this.email,
      passwordHash: passwordHash ?? this.passwordHash,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone is String? ? phone : this.phone,
      avatarUrl: avatarUrl is String? ? avatarUrl : this.avatarUrl,
      dni: dni is String? ? dni : this.dni,
      address: address is String? ? address : this.address,
      gender: gender is String? ? gender : this.gender,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      emailVerified: emailVerified ?? this.emailVerified,
      phoneVerified: phoneVerified ?? this.phoneVerified,
      lastLoginAt: lastLoginAt is DateTime? ? lastLoginAt : this.lastLoginAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt is DateTime? ? deletedAt : this.deletedAt,
    );
  }
}

class AppUserTable extends _i1.Table<_i1.UuidValue?> {
  AppUserTable({super.tableRelation}) : super(tableName: 'app_user') {
    serverpodUserId = _i1.ColumnInt(
      'serverpodUserId',
      this,
    );
    organizationId = _i1.ColumnUuid(
      'organizationId',
      this,
    );
    email = _i1.ColumnString(
      'email',
      this,
    );
    passwordHash = _i1.ColumnString(
      'passwordHash',
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
    phone = _i1.ColumnString(
      'phone',
      this,
    );
    avatarUrl = _i1.ColumnString(
      'avatarUrl',
      this,
    );
    dni = _i1.ColumnString(
      'dni',
      this,
    );
    address = _i1.ColumnString(
      'address',
      this,
    );
    gender = _i1.ColumnString(
      'gender',
      this,
    );
    role = _i1.ColumnString(
      'role',
      this,
    );
    isActive = _i1.ColumnBool(
      'isActive',
      this,
    );
    emailVerified = _i1.ColumnBool(
      'emailVerified',
      this,
    );
    phoneVerified = _i1.ColumnBool(
      'phoneVerified',
      this,
    );
    lastLoginAt = _i1.ColumnDateTime(
      'lastLoginAt',
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

  late final _i1.ColumnInt serverpodUserId;

  late final _i1.ColumnUuid organizationId;

  late final _i1.ColumnString email;

  late final _i1.ColumnString passwordHash;

  late final _i1.ColumnString firstName;

  late final _i1.ColumnString lastName;

  late final _i1.ColumnString phone;

  late final _i1.ColumnString avatarUrl;

  late final _i1.ColumnString dni;

  late final _i1.ColumnString address;

  late final _i1.ColumnString gender;

  late final _i1.ColumnString role;

  late final _i1.ColumnBool isActive;

  late final _i1.ColumnBool emailVerified;

  late final _i1.ColumnBool phoneVerified;

  late final _i1.ColumnDateTime lastLoginAt;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnDateTime deletedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        serverpodUserId,
        organizationId,
        email,
        passwordHash,
        firstName,
        lastName,
        phone,
        avatarUrl,
        dni,
        address,
        gender,
        role,
        isActive,
        emailVerified,
        phoneVerified,
        lastLoginAt,
        createdAt,
        updatedAt,
        deletedAt,
      ];
}

class AppUserInclude extends _i1.IncludeObject {
  AppUserInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => AppUser.t;
}

class AppUserIncludeList extends _i1.IncludeList {
  AppUserIncludeList._({
    _i1.WhereExpressionBuilder<AppUserTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AppUser.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => AppUser.t;
}

class AppUserRepository {
  const AppUserRepository._();

  /// Returns a list of [AppUser]s matching the given query parameters.
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
  Future<List<AppUser>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AppUserTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AppUserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AppUserTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<AppUser>(
      where: where?.call(AppUser.t),
      orderBy: orderBy?.call(AppUser.t),
      orderByList: orderByList?.call(AppUser.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [AppUser] matching the given query parameters.
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
  Future<AppUser?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AppUserTable>? where,
    int? offset,
    _i1.OrderByBuilder<AppUserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AppUserTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<AppUser>(
      where: where?.call(AppUser.t),
      orderBy: orderBy?.call(AppUser.t),
      orderByList: orderByList?.call(AppUser.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [AppUser] by its [id] or null if no such row exists.
  Future<AppUser?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<AppUser>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [AppUser]s in the list and returns the inserted rows.
  ///
  /// The returned [AppUser]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<AppUser>> insert(
    _i1.Session session,
    List<AppUser> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<AppUser>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [AppUser] and returns the inserted row.
  ///
  /// The returned [AppUser] will have its `id` field set.
  Future<AppUser> insertRow(
    _i1.Session session,
    AppUser row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AppUser>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AppUser]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AppUser>> update(
    _i1.Session session,
    List<AppUser> rows, {
    _i1.ColumnSelections<AppUserTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AppUser>(
      rows,
      columns: columns?.call(AppUser.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AppUser]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AppUser> updateRow(
    _i1.Session session,
    AppUser row, {
    _i1.ColumnSelections<AppUserTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AppUser>(
      row,
      columns: columns?.call(AppUser.t),
      transaction: transaction,
    );
  }

  /// Deletes all [AppUser]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AppUser>> delete(
    _i1.Session session,
    List<AppUser> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AppUser>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AppUser].
  Future<AppUser> deleteRow(
    _i1.Session session,
    AppUser row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AppUser>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AppUser>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<AppUserTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AppUser>(
      where: where(AppUser.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AppUserTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AppUser>(
      where: where?.call(AppUser.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
