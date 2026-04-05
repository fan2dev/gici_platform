/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_local_identifiers

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_test/serverpod_test.dart' as _i1;
import 'package:serverpod/serverpod.dart' as _i2;
import 'dart:async' as _i3;
import 'package:gici_backend_server/src/generated/auth_session.dart' as _i4;
import 'package:gici_backend_server/src/generated/chat_conversation.dart'
    as _i5;
import 'package:uuid/uuid_value.dart' as _i6;
import 'package:gici_backend_server/src/generated/chat_message.dart' as _i7;
import 'package:gici_backend_server/src/generated/child.dart' as _i8;
import 'package:gici_backend_server/src/generated/child_profile_overview.dart'
    as _i9;
import 'package:gici_backend_server/src/generated/child_timeline_item.dart'
    as _i10;
import 'package:gici_backend_server/src/generated/classroom.dart' as _i11;
import 'package:gici_backend_server/src/generated/classroom_assignment.dart'
    as _i12;
import 'package:gici_backend_server/src/generated/data_change_request.dart'
    as _i13;
import 'package:gici_backend_server/src/generated/organization_document.dart'
    as _i14;
import 'package:gici_backend_server/src/generated/child_document.dart' as _i15;
import 'package:gici_backend_server/src/generated/user_onboarding_state.dart'
    as _i16;
import 'package:gici_backend_server/src/generated/organization.dart' as _i17;
import 'package:gici_backend_server/src/generated/menu_entry.dart' as _i18;
import 'package:gici_backend_server/src/generated/gallery.dart' as _i19;
import 'package:gici_backend_server/src/generated/gallery_item.dart' as _i20;
import 'package:gici_backend_server/src/generated/meal_entry.dart' as _i21;
import 'package:gici_backend_server/src/generated/nap_entry.dart' as _i22;
import 'package:gici_backend_server/src/generated/bowel_movement_entry.dart'
    as _i23;
import 'package:gici_backend_server/src/generated/child_daily_habits.dart'
    as _i24;
import 'package:gici_backend_server/src/generated/push_device_token.dart'
    as _i25;
import 'package:gici_backend_server/src/generated/notification_record.dart'
    as _i26;
import 'package:gici_backend_server/src/generated/pedagogical_report.dart'
    as _i27;
import 'package:gici_backend_server/src/generated/time_entry.dart' as _i28;
import 'package:gici_backend_server/src/generated/protocol.dart';
import 'package:gici_backend_server/src/generated/endpoints.dart';
export 'package:serverpod_test/serverpod_test_public_exports.dart';

/// Creates a new test group that takes a callback that can be used to write tests.
/// The callback has two parameters: `sessionBuilder` and `endpoints`.
/// `sessionBuilder` is used to build a `Session` object that represents the server state during an endpoint call and is used to set up scenarios.
/// `endpoints` contains all your Serverpod endpoints and lets you call them:
/// ```dart
/// withServerpod('Given Example endpoint', (sessionBuilder, endpoints) {
///   test('when calling `hello` then should return greeting', () async {
///     final greeting = await endpoints.example.hello(sessionBuilder, 'Michael');
///     expect(greeting, 'Hello Michael');
///   });
/// });
/// ```
///
/// **Configuration options**
///
/// [applyMigrations] Whether pending migrations should be applied when starting Serverpod. Defaults to `true`
///
/// [enableSessionLogging] Whether session logging should be enabled. Defaults to `false`
///
/// [rollbackDatabase] Options for when to rollback the database during the test lifecycle.
/// By default `withServerpod` does all database operations inside a transaction that is rolled back after each `test` case.
/// Just like the following enum describes, the behavior of the automatic rollbacks can be configured:
/// ```dart
/// /// Options for when to rollback the database during the test lifecycle.
/// enum RollbackDatabase {
///   /// After each test. This is the default.
///   afterEach,
///
///   /// After all tests.
///   afterAll,
///
///   /// Disable rolling back the database.
///   disabled,
/// }
/// ```
///
/// [runMode] The run mode that Serverpod should be running in. Defaults to `test`.
///
/// [serverpodLoggingMode] The logging mode used when creating Serverpod. Defaults to `ServerpodLoggingMode.normal`
///
/// [serverpodStartTimeout] The timeout to use when starting Serverpod, which connects to the database among other things. Defaults to `Duration(seconds: 30)`.
///
/// [testGroupTagsOverride] By default Serverpod test tools tags the `withServerpod` test group with `"integration"`.
/// This is to provide a simple way to only run unit or integration tests.
/// This property allows this tag to be overridden to something else. Defaults to `['integration']`.
///
/// [experimentalFeatures] Optionally specify experimental features. See [Serverpod] for more information.
@_i1.isTestGroup
void withServerpod(
  String testGroupName,
  _i1.TestClosure<TestEndpoints> testClosure, {
  bool? applyMigrations,
  bool? enableSessionLogging,
  _i2.ExperimentalFeatures? experimentalFeatures,
  _i1.RollbackDatabase? rollbackDatabase,
  String? runMode,
  _i2.RuntimeParametersListBuilder? runtimeParametersBuilder,
  _i2.ServerpodLoggingMode? serverpodLoggingMode,
  Duration? serverpodStartTimeout,
  List<String>? testGroupTagsOverride,
}) {
  _i1.buildWithServerpod<_InternalTestEndpoints>(
    testGroupName,
    _i1.TestServerpod(
      testEndpoints: _InternalTestEndpoints(),
      endpoints: Endpoints(),
      serializationManager: Protocol(),
      runMode: runMode,
      applyMigrations: applyMigrations,
      isDatabaseEnabled: true,
      serverpodLoggingMode: serverpodLoggingMode,
      experimentalFeatures: experimentalFeatures,
      runtimeParametersBuilder: runtimeParametersBuilder,
    ),
    maybeRollbackDatabase: rollbackDatabase,
    maybeEnableSessionLogging: enableSessionLogging,
    maybeTestGroupTagsOverride: testGroupTagsOverride,
    maybeServerpodStartTimeout: serverpodStartTimeout,
  )(testClosure);
}

class TestEndpoints {
  late final _AuthEndpoint auth;

  late final _BootstrapEndpoint bootstrap;

  late final _ChatEndpoint chat;

  late final _ChildEndpoint child;

  late final _ChildTimelineEndpoint childTimeline;

  late final _ClassroomEndpoint classroom;

  late final _DataChangeRequestEndpoint dataChangeRequest;

  late final _DocumentEndpoint document;

  late final _ExperienceEndpoint experience;

  late final _GalleryEndpoint gallery;

  late final _HabitEndpoint habit;

  late final _NotificationEndpoint notification;

  late final _OrganizationEndpoint organization;

  late final _PedagogicalReportEndpoint pedagogicalReport;

  late final _TimeTrackingEndpoint timeTracking;
}

class _InternalTestEndpoints extends TestEndpoints
    implements _i1.InternalTestEndpoints {
  @override
  void initialize(
    _i2.SerializationManager serializationManager,
    _i2.EndpointDispatch endpoints,
  ) {
    auth = _AuthEndpoint(
      endpoints,
      serializationManager,
    );
    bootstrap = _BootstrapEndpoint(
      endpoints,
      serializationManager,
    );
    chat = _ChatEndpoint(
      endpoints,
      serializationManager,
    );
    child = _ChildEndpoint(
      endpoints,
      serializationManager,
    );
    childTimeline = _ChildTimelineEndpoint(
      endpoints,
      serializationManager,
    );
    classroom = _ClassroomEndpoint(
      endpoints,
      serializationManager,
    );
    dataChangeRequest = _DataChangeRequestEndpoint(
      endpoints,
      serializationManager,
    );
    document = _DocumentEndpoint(
      endpoints,
      serializationManager,
    );
    experience = _ExperienceEndpoint(
      endpoints,
      serializationManager,
    );
    gallery = _GalleryEndpoint(
      endpoints,
      serializationManager,
    );
    habit = _HabitEndpoint(
      endpoints,
      serializationManager,
    );
    notification = _NotificationEndpoint(
      endpoints,
      serializationManager,
    );
    organization = _OrganizationEndpoint(
      endpoints,
      serializationManager,
    );
    pedagogicalReport = _PedagogicalReportEndpoint(
      endpoints,
      serializationManager,
    );
    timeTracking = _TimeTrackingEndpoint(
      endpoints,
      serializationManager,
    );
  }
}

class _AuthEndpoint {
  _AuthEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i4.AuthSession> signInWithEmailPassword(
    _i1.TestSessionBuilder sessionBuilder, {
    required String email,
    required String password,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'auth',
        method: 'signInWithEmailPassword',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'auth',
          methodName: 'signInWithEmailPassword',
          parameters: _i1.testObjectToJson({
            'email': email,
            'password': password,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i4.AuthSession>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i4.AuthSession?> me(_i1.TestSessionBuilder sessionBuilder) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'auth',
        method: 'me',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'auth',
          methodName: 'me',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i4.AuthSession?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> requestPasswordReset(
    _i1.TestSessionBuilder sessionBuilder, {
    required String email,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'auth',
        method: 'requestPasswordReset',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'auth',
          methodName: 'requestPasswordReset',
          parameters: _i1.testObjectToJson({'email': email}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> resetPassword(
    _i1.TestSessionBuilder sessionBuilder, {
    required String email,
    required String code,
    required String newPassword,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'auth',
        method: 'resetPassword',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'auth',
          methodName: 'resetPassword',
          parameters: _i1.testObjectToJson({
            'email': email,
            'code': code,
            'newPassword': newPassword,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _BootstrapEndpoint {
  _BootstrapEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<String> seedDemoData(
    _i1.TestSessionBuilder sessionBuilder, {
    required String bootstrapKey,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'bootstrap',
        method: 'seedDemoData',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'bootstrap',
          methodName: 'seedDemoData',
          parameters: _i1.testObjectToJson({'bootstrapKey': bootstrapKey}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _ChatEndpoint {
  _ChatEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i5.ChatConversation>> listConversations(
    _i1.TestSessionBuilder sessionBuilder, {
    required int page,
    required int pageSize,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'chat',
        method: 'listConversations',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'chat',
          methodName: 'listConversations',
          parameters: _i1.testObjectToJson({
            'page': page,
            'pageSize': pageSize,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i5.ChatConversation>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i5.ChatConversation> getConversation(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i6.UuidValue conversationId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'chat',
        method: 'getConversation',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'chat',
          methodName: 'getConversation',
          parameters: _i1.testObjectToJson({'conversationId': conversationId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i5.ChatConversation>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i5.ChatConversation> createConversation(
    _i1.TestSessionBuilder sessionBuilder, {
    required String conversationType,
    String? title,
    _i6.UuidValue? relatedChildId,
    _i6.UuidValue? relatedClassroomId,
    required List<_i6.UuidValue> participantUserIds,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'chat',
        method: 'createConversation',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'chat',
          methodName: 'createConversation',
          parameters: _i1.testObjectToJson({
            'conversationType': conversationType,
            'title': title,
            'relatedChildId': relatedChildId,
            'relatedClassroomId': relatedClassroomId,
            'participantUserIds': participantUserIds,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i5.ChatConversation>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i7.ChatMessage> sendMessage(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i6.UuidValue conversationId,
    required String content,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'chat',
        method: 'sendMessage',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'chat',
          methodName: 'sendMessage',
          parameters: _i1.testObjectToJson({
            'conversationId': conversationId,
            'content': content,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i7.ChatMessage>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i7.ChatMessage>> listMessages(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i6.UuidValue conversationId,
    required int page,
    required int pageSize,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'chat',
        method: 'listMessages',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'chat',
          methodName: 'listMessages',
          parameters: _i1.testObjectToJson({
            'conversationId': conversationId,
            'page': page,
            'pageSize': pageSize,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i7.ChatMessage>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<void> markConversationRead(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i6.UuidValue conversationId,
    _i6.UuidValue? lastReadMessageId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'chat',
        method: 'markConversationRead',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'chat',
          methodName: 'markConversationRead',
          parameters: _i1.testObjectToJson({
            'conversationId': conversationId,
            'lastReadMessageId': lastReadMessageId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, int>> unreadCounts(
      _i1.TestSessionBuilder sessionBuilder) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'chat',
        method: 'unreadCounts',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'chat',
          methodName: 'unreadCounts',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<Map<String, int>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _ChildEndpoint {
  _ChildEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i8.Child>> listChildren(
    _i1.TestSessionBuilder sessionBuilder, {
    required int page,
    required int pageSize,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'child',
        method: 'listChildren',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'child',
          methodName: 'listChildren',
          parameters: _i1.testObjectToJson({
            'page': page,
            'pageSize': pageSize,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i8.Child>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i8.Child> createChild(
    _i1.TestSessionBuilder sessionBuilder, {
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'child',
        method: 'createChild',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'child',
          methodName: 'createChild',
          parameters: _i1.testObjectToJson({
            'firstName': firstName,
            'lastName': lastName,
            'dateOfBirth': dateOfBirth,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i8.Child>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i8.Child> getChild(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i6.UuidValue childId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'child',
        method: 'getChild',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'child',
          methodName: 'getChild',
          parameters: _i1.testObjectToJson({'childId': childId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i8.Child>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i8.Child> updateChild(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i6.UuidValue childId,
    String? firstName,
    String? lastName,
    DateTime? dateOfBirth,
    String? status,
    String? medicalNotes,
    String? dietaryNotes,
    String? allergies,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'child',
        method: 'updateChild',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'child',
          methodName: 'updateChild',
          parameters: _i1.testObjectToJson({
            'childId': childId,
            'firstName': firstName,
            'lastName': lastName,
            'dateOfBirth': dateOfBirth,
            'status': status,
            'medicalNotes': medicalNotes,
            'dietaryNotes': dietaryNotes,
            'allergies': allergies,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i8.Child>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i9.ChildProfileOverview> getChildProfileOverview(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i6.UuidValue childId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'child',
        method: 'getChildProfileOverview',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'child',
          methodName: 'getChildProfileOverview',
          parameters: _i1.testObjectToJson({'childId': childId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i9.ChildProfileOverview>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _ChildTimelineEndpoint {
  _ChildTimelineEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i10.ChildTimelineItem>> getChildTimeline(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i6.UuidValue childId,
    required int page,
    required int pageSize,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'childTimeline',
        method: 'getChildTimeline',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'childTimeline',
          methodName: 'getChildTimeline',
          parameters: _i1.testObjectToJson({
            'childId': childId,
            'page': page,
            'pageSize': pageSize,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i10.ChildTimelineItem>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _ClassroomEndpoint {
  _ClassroomEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i11.Classroom>> listClassrooms(
    _i1.TestSessionBuilder sessionBuilder, {
    required int page,
    required int pageSize,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'classroom',
        method: 'listClassrooms',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'classroom',
          methodName: 'listClassrooms',
          parameters: _i1.testObjectToJson({
            'page': page,
            'pageSize': pageSize,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i11.Classroom>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i11.Classroom> createClassroom(
    _i1.TestSessionBuilder sessionBuilder, {
    required String name,
    String? description,
    int? ageGroupMin,
    int? ageGroupMax,
    required int capacity,
    String? color,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'classroom',
        method: 'createClassroom',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'classroom',
          methodName: 'createClassroom',
          parameters: _i1.testObjectToJson({
            'name': name,
            'description': description,
            'ageGroupMin': ageGroupMin,
            'ageGroupMax': ageGroupMax,
            'capacity': capacity,
            'color': color,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i11.Classroom>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i11.Classroom> updateClassroom(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i6.UuidValue classroomId,
    String? name,
    String? description,
    int? ageGroupMin,
    int? ageGroupMax,
    int? capacity,
    String? color,
    String? status,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'classroom',
        method: 'updateClassroom',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'classroom',
          methodName: 'updateClassroom',
          parameters: _i1.testObjectToJson({
            'classroomId': classroomId,
            'name': name,
            'description': description,
            'ageGroupMin': ageGroupMin,
            'ageGroupMax': ageGroupMax,
            'capacity': capacity,
            'color': color,
            'status': status,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i11.Classroom>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i12.ClassroomAssignment> assignChildToClassroom(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i6.UuidValue classroomId,
    required _i6.UuidValue childId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'classroom',
        method: 'assignChildToClassroom',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'classroom',
          methodName: 'assignChildToClassroom',
          parameters: _i1.testObjectToJson({
            'classroomId': classroomId,
            'childId': childId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i12.ClassroomAssignment>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i12.ClassroomAssignment>> listAssignments(
    _i1.TestSessionBuilder sessionBuilder, {
    _i6.UuidValue? classroomId,
    _i6.UuidValue? childId,
    required bool onlyActive,
    required int page,
    required int pageSize,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'classroom',
        method: 'listAssignments',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'classroom',
          methodName: 'listAssignments',
          parameters: _i1.testObjectToJson({
            'classroomId': classroomId,
            'childId': childId,
            'onlyActive': onlyActive,
            'page': page,
            'pageSize': pageSize,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i12.ClassroomAssignment>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _DataChangeRequestEndpoint {
  _DataChangeRequestEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i13.DataChangeRequest> createRequest(
    _i1.TestSessionBuilder sessionBuilder, {
    _i6.UuidValue? targetChildId,
    required String requestType,
    required String requestPayload,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'dataChangeRequest',
        method: 'createRequest',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'dataChangeRequest',
          methodName: 'createRequest',
          parameters: _i1.testObjectToJson({
            'targetChildId': targetChildId,
            'requestType': requestType,
            'requestPayload': requestPayload,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i13.DataChangeRequest>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i13.DataChangeRequest>> myRequests(
    _i1.TestSessionBuilder sessionBuilder, {
    required int page,
    required int pageSize,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'dataChangeRequest',
        method: 'myRequests',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'dataChangeRequest',
          methodName: 'myRequests',
          parameters: _i1.testObjectToJson({
            'page': page,
            'pageSize': pageSize,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i13.DataChangeRequest>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i13.DataChangeRequest>> listRequestsForReview(
    _i1.TestSessionBuilder sessionBuilder, {
    String? status,
    required int page,
    required int pageSize,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'dataChangeRequest',
        method: 'listRequestsForReview',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'dataChangeRequest',
          methodName: 'listRequestsForReview',
          parameters: _i1.testObjectToJson({
            'status': status,
            'page': page,
            'pageSize': pageSize,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i13.DataChangeRequest>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i13.DataChangeRequest> getRequest(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i6.UuidValue requestId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'dataChangeRequest',
        method: 'getRequest',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'dataChangeRequest',
          methodName: 'getRequest',
          parameters: _i1.testObjectToJson({'requestId': requestId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i13.DataChangeRequest>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i13.DataChangeRequest> updateRequestStatus(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i6.UuidValue requestId,
    required String status,
    String? resolutionNote,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'dataChangeRequest',
        method: 'updateRequestStatus',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'dataChangeRequest',
          methodName: 'updateRequestStatus',
          parameters: _i1.testObjectToJson({
            'requestId': requestId,
            'status': status,
            'resolutionNote': resolutionNote,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i13.DataChangeRequest>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _DocumentEndpoint {
  _DocumentEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i14.OrganizationDocument>> listOrganizationDocuments(
    _i1.TestSessionBuilder sessionBuilder, {
    required int page,
    required int pageSize,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'document',
        method: 'listOrganizationDocuments',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'document',
          methodName: 'listOrganizationDocuments',
          parameters: _i1.testObjectToJson({
            'page': page,
            'pageSize': pageSize,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i14.OrganizationDocument>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i14.OrganizationDocument> createOrganizationDocument(
    _i1.TestSessionBuilder sessionBuilder, {
    required String title,
    String? description,
    required String visibility,
    required String originalName,
    required String mimeType,
    required int sizeBytes,
    String? storagePath,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'document',
        method: 'createOrganizationDocument',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'document',
          methodName: 'createOrganizationDocument',
          parameters: _i1.testObjectToJson({
            'title': title,
            'description': description,
            'visibility': visibility,
            'originalName': originalName,
            'mimeType': mimeType,
            'sizeBytes': sizeBytes,
            'storagePath': storagePath,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i14.OrganizationDocument>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i15.ChildDocument>> listChildDocuments(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i6.UuidValue childId,
    required int page,
    required int pageSize,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'document',
        method: 'listChildDocuments',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'document',
          methodName: 'listChildDocuments',
          parameters: _i1.testObjectToJson({
            'childId': childId,
            'page': page,
            'pageSize': pageSize,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i15.ChildDocument>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i15.ChildDocument> createChildDocument(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i6.UuidValue childId,
    required String title,
    String? description,
    required bool visibleToGuardians,
    required String originalName,
    required String mimeType,
    required int sizeBytes,
    String? storagePath,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'document',
        method: 'createChildDocument',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'document',
          methodName: 'createChildDocument',
          parameters: _i1.testObjectToJson({
            'childId': childId,
            'title': title,
            'description': description,
            'visibleToGuardians': visibleToGuardians,
            'originalName': originalName,
            'mimeType': mimeType,
            'sizeBytes': sizeBytes,
            'storagePath': storagePath,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i15.ChildDocument>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> resolveFileDownloadUrl(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i6.UuidValue fileAssetId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'document',
        method: 'resolveFileDownloadUrl',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'document',
          methodName: 'resolveFileDownloadUrl',
          parameters: _i1.testObjectToJson({'fileAssetId': fileAssetId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _ExperienceEndpoint {
  _ExperienceEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i16.UserOnboardingState?> getOnboardingState(
      _i1.TestSessionBuilder sessionBuilder) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'experience',
        method: 'getOnboardingState',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'experience',
          methodName: 'getOnboardingState',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i16.UserOnboardingState?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i16.UserOnboardingState> completeOnboarding(
    _i1.TestSessionBuilder sessionBuilder, {
    required bool acceptTerms,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'experience',
        method: 'completeOnboarding',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'experience',
          methodName: 'completeOnboarding',
          parameters: _i1.testObjectToJson({'acceptTerms': acceptTerms}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i16.UserOnboardingState>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i17.Organization> getCenterInfo(
      _i1.TestSessionBuilder sessionBuilder) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'experience',
        method: 'getCenterInfo',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'experience',
          methodName: 'getCenterInfo',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i17.Organization>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i18.MenuEntry>> listMenuEntries(
    _i1.TestSessionBuilder sessionBuilder, {
    DateTime? from,
    DateTime? to,
    required int page,
    required int pageSize,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'experience',
        method: 'listMenuEntries',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'experience',
          methodName: 'listMenuEntries',
          parameters: _i1.testObjectToJson({
            'from': from,
            'to': to,
            'page': page,
            'pageSize': pageSize,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i18.MenuEntry>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i18.MenuEntry?> getMenuEntry(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i6.UuidValue menuEntryId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'experience',
        method: 'getMenuEntry',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'experience',
          methodName: 'getMenuEntry',
          parameters: _i1.testObjectToJson({'menuEntryId': menuEntryId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i18.MenuEntry?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i18.MenuEntry> createMenuEntry(
    _i1.TestSessionBuilder sessionBuilder, {
    required DateTime menuDate,
    required String mealType,
    required String title,
    String? description,
    _i6.UuidValue? classroomId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'experience',
        method: 'createMenuEntry',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'experience',
          methodName: 'createMenuEntry',
          parameters: _i1.testObjectToJson({
            'menuDate': menuDate,
            'mealType': mealType,
            'title': title,
            'description': description,
            'classroomId': classroomId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i18.MenuEntry>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i18.MenuEntry> updateMenuEntry(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i6.UuidValue menuEntryId,
    DateTime? menuDate,
    String? mealType,
    String? title,
    String? description,
    _i6.UuidValue? classroomId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'experience',
        method: 'updateMenuEntry',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'experience',
          methodName: 'updateMenuEntry',
          parameters: _i1.testObjectToJson({
            'menuEntryId': menuEntryId,
            'menuDate': menuDate,
            'mealType': mealType,
            'title': title,
            'description': description,
            'classroomId': classroomId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i18.MenuEntry>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _GalleryEndpoint {
  _GalleryEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i19.Gallery>> listGalleries(
    _i1.TestSessionBuilder sessionBuilder, {
    required int page,
    required int pageSize,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'gallery',
        method: 'listGalleries',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'gallery',
          methodName: 'listGalleries',
          parameters: _i1.testObjectToJson({
            'page': page,
            'pageSize': pageSize,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i19.Gallery>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i19.Gallery> getGallery(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i6.UuidValue galleryId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'gallery',
        method: 'getGallery',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'gallery',
          methodName: 'getGallery',
          parameters: _i1.testObjectToJson({'galleryId': galleryId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i19.Gallery>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i19.Gallery> createGallery(
    _i1.TestSessionBuilder sessionBuilder, {
    required String title,
    String? description,
    required String audienceType,
    _i6.UuidValue? audienceClassroomId,
    _i6.UuidValue? audienceChildId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'gallery',
        method: 'createGallery',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'gallery',
          methodName: 'createGallery',
          parameters: _i1.testObjectToJson({
            'title': title,
            'description': description,
            'audienceType': audienceType,
            'audienceClassroomId': audienceClassroomId,
            'audienceChildId': audienceChildId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i19.Gallery>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i19.Gallery> updateGallery(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i6.UuidValue galleryId,
    String? title,
    String? description,
    String? audienceType,
    _i6.UuidValue? audienceClassroomId,
    _i6.UuidValue? audienceChildId,
    bool? isPublished,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'gallery',
        method: 'updateGallery',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'gallery',
          methodName: 'updateGallery',
          parameters: _i1.testObjectToJson({
            'galleryId': galleryId,
            'title': title,
            'description': description,
            'audienceType': audienceType,
            'audienceClassroomId': audienceClassroomId,
            'audienceChildId': audienceChildId,
            'isPublished': isPublished,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i19.Gallery>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i20.GalleryItem> addGalleryItem(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i6.UuidValue galleryId,
    required _i6.UuidValue fileAssetId,
    String? caption,
    int? sortOrder,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'gallery',
        method: 'addGalleryItem',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'gallery',
          methodName: 'addGalleryItem',
          parameters: _i1.testObjectToJson({
            'galleryId': galleryId,
            'fileAssetId': fileAssetId,
            'caption': caption,
            'sortOrder': sortOrder,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i20.GalleryItem>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i20.GalleryItem>> listGalleryItems(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i6.UuidValue galleryId,
    required int page,
    required int pageSize,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'gallery',
        method: 'listGalleryItems',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'gallery',
          methodName: 'listGalleryItems',
          parameters: _i1.testObjectToJson({
            'galleryId': galleryId,
            'page': page,
            'pageSize': pageSize,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i20.GalleryItem>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _HabitEndpoint {
  _HabitEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i21.MealEntry>> listMealsByChild(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i6.UuidValue childId,
    required int page,
    required int pageSize,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'habit',
        method: 'listMealsByChild',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'habit',
          methodName: 'listMealsByChild',
          parameters: _i1.testObjectToJson({
            'childId': childId,
            'page': page,
            'pageSize': pageSize,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i21.MealEntry>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i21.MealEntry> createMealEntry(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i6.UuidValue childId,
    required String mealType,
    required String consumptionLevel,
    DateTime? recordedAt,
    String? menuItems,
    String? notes,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'habit',
        method: 'createMealEntry',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'habit',
          methodName: 'createMealEntry',
          parameters: _i1.testObjectToJson({
            'childId': childId,
            'mealType': mealType,
            'consumptionLevel': consumptionLevel,
            'recordedAt': recordedAt,
            'menuItems': menuItems,
            'notes': notes,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i21.MealEntry>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i21.MealEntry> updateMealEntry(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i6.UuidValue mealEntryId,
    String? mealType,
    String? consumptionLevel,
    DateTime? recordedAt,
    String? menuItems,
    String? notes,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'habit',
        method: 'updateMealEntry',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'habit',
          methodName: 'updateMealEntry',
          parameters: _i1.testObjectToJson({
            'mealEntryId': mealEntryId,
            'mealType': mealType,
            'consumptionLevel': consumptionLevel,
            'recordedAt': recordedAt,
            'menuItems': menuItems,
            'notes': notes,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i21.MealEntry>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i22.NapEntry>> listNapsByChild(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i6.UuidValue childId,
    required int page,
    required int pageSize,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'habit',
        method: 'listNapsByChild',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'habit',
          methodName: 'listNapsByChild',
          parameters: _i1.testObjectToJson({
            'childId': childId,
            'page': page,
            'pageSize': pageSize,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i22.NapEntry>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i22.NapEntry> createNapEntry(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i6.UuidValue childId,
    required DateTime startedAt,
    DateTime? endedAt,
    int? durationMinutes,
    String? sleepQuality,
    String? notes,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'habit',
        method: 'createNapEntry',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'habit',
          methodName: 'createNapEntry',
          parameters: _i1.testObjectToJson({
            'childId': childId,
            'startedAt': startedAt,
            'endedAt': endedAt,
            'durationMinutes': durationMinutes,
            'sleepQuality': sleepQuality,
            'notes': notes,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i22.NapEntry>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i22.NapEntry> updateNapEntry(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i6.UuidValue napEntryId,
    DateTime? startedAt,
    DateTime? endedAt,
    int? durationMinutes,
    String? sleepQuality,
    String? notes,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'habit',
        method: 'updateNapEntry',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'habit',
          methodName: 'updateNapEntry',
          parameters: _i1.testObjectToJson({
            'napEntryId': napEntryId,
            'startedAt': startedAt,
            'endedAt': endedAt,
            'durationMinutes': durationMinutes,
            'sleepQuality': sleepQuality,
            'notes': notes,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i22.NapEntry>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i23.BowelMovementEntry>> listBowelMovementsByChild(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i6.UuidValue childId,
    required int page,
    required int pageSize,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'habit',
        method: 'listBowelMovementsByChild',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'habit',
          methodName: 'listBowelMovementsByChild',
          parameters: _i1.testObjectToJson({
            'childId': childId,
            'page': page,
            'pageSize': pageSize,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i23.BowelMovementEntry>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i23.BowelMovementEntry> createBowelMovementEntry(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i6.UuidValue childId,
    DateTime? eventAt,
    required String eventType,
    String? consistency,
    String? notes,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'habit',
        method: 'createBowelMovementEntry',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'habit',
          methodName: 'createBowelMovementEntry',
          parameters: _i1.testObjectToJson({
            'childId': childId,
            'eventAt': eventAt,
            'eventType': eventType,
            'consistency': consistency,
            'notes': notes,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i23.BowelMovementEntry>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i23.BowelMovementEntry> updateBowelMovementEntry(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i6.UuidValue entryId,
    DateTime? eventAt,
    String? eventType,
    String? consistency,
    String? notes,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'habit',
        method: 'updateBowelMovementEntry',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'habit',
          methodName: 'updateBowelMovementEntry',
          parameters: _i1.testObjectToJson({
            'entryId': entryId,
            'eventAt': eventAt,
            'eventType': eventType,
            'consistency': consistency,
            'notes': notes,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i23.BowelMovementEntry>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i24.ChildDailyHabits> getChildDailyHabits(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i6.UuidValue childId,
    required DateTime day,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'habit',
        method: 'getChildDailyHabits',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'habit',
          methodName: 'getChildDailyHabits',
          parameters: _i1.testObjectToJson({
            'childId': childId,
            'day': day,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i24.ChildDailyHabits>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _NotificationEndpoint {
  _NotificationEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i25.PushDeviceToken> registerDeviceToken(
    _i1.TestSessionBuilder sessionBuilder, {
    required String token,
    required String platform,
    String? deviceId,
    String? deviceModel,
    String? appVersion,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'notification',
        method: 'registerDeviceToken',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'notification',
          methodName: 'registerDeviceToken',
          parameters: _i1.testObjectToJson({
            'token': token,
            'platform': platform,
            'deviceId': deviceId,
            'deviceModel': deviceModel,
            'appVersion': appVersion,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i25.PushDeviceToken>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<void> removeDeviceToken(
    _i1.TestSessionBuilder sessionBuilder, {
    required String token,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'notification',
        method: 'removeDeviceToken',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'notification',
          methodName: 'removeDeviceToken',
          parameters: _i1.testObjectToJson({'token': token}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i26.NotificationRecord>> myNotifications(
    _i1.TestSessionBuilder sessionBuilder, {
    required int page,
    required int pageSize,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'notification',
        method: 'myNotifications',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'notification',
          methodName: 'myNotifications',
          parameters: _i1.testObjectToJson({
            'page': page,
            'pageSize': pageSize,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i26.NotificationRecord>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<void> markNotificationRead(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i6.UuidValue notificationId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'notification',
        method: 'markNotificationRead',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'notification',
          methodName: 'markNotificationRead',
          parameters: _i1.testObjectToJson({'notificationId': notificationId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<int> createSegmentedNotification(
    _i1.TestSessionBuilder sessionBuilder, {
    required String title,
    required String body,
    required String category,
    required String targetScope,
    _i6.UuidValue? targetClassroomId,
    _i6.UuidValue? targetChildId,
    _i6.UuidValue? targetUserId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'notification',
        method: 'createSegmentedNotification',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'notification',
          methodName: 'createSegmentedNotification',
          parameters: _i1.testObjectToJson({
            'title': title,
            'body': body,
            'category': category,
            'targetScope': targetScope,
            'targetClassroomId': targetClassroomId,
            'targetChildId': targetChildId,
            'targetUserId': targetUserId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<int>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _OrganizationEndpoint {
  _OrganizationEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i17.Organization>> listOrganizations(
    _i1.TestSessionBuilder sessionBuilder, {
    required int page,
    required int pageSize,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'organization',
        method: 'listOrganizations',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'organization',
          methodName: 'listOrganizations',
          parameters: _i1.testObjectToJson({
            'page': page,
            'pageSize': pageSize,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i17.Organization>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i17.Organization?> getOrganization(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i6.UuidValue organizationId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'organization',
        method: 'getOrganization',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'organization',
          methodName: 'getOrganization',
          parameters: _i1.testObjectToJson({'organizationId': organizationId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i17.Organization?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i17.Organization> createOrganization(
    _i1.TestSessionBuilder sessionBuilder, {
    required String name,
    required String slug,
    required String contactEmail,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'organization',
        method: 'createOrganization',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'organization',
          methodName: 'createOrganization',
          parameters: _i1.testObjectToJson({
            'name': name,
            'slug': slug,
            'contactEmail': contactEmail,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i17.Organization>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _PedagogicalReportEndpoint {
  _PedagogicalReportEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i27.PedagogicalReport>> listReportsByChild(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i6.UuidValue childId,
    required int page,
    required int pageSize,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'pedagogicalReport',
        method: 'listReportsByChild',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'pedagogicalReport',
          methodName: 'listReportsByChild',
          parameters: _i1.testObjectToJson({
            'childId': childId,
            'page': page,
            'pageSize': pageSize,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i27.PedagogicalReport>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i27.PedagogicalReport> getReport(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i6.UuidValue reportId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'pedagogicalReport',
        method: 'getReport',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'pedagogicalReport',
          methodName: 'getReport',
          parameters: _i1.testObjectToJson({'reportId': reportId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i27.PedagogicalReport>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i27.PedagogicalReport> createReport(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i6.UuidValue childId,
    required DateTime reportDate,
    required String title,
    required String summary,
    required String body,
    required String status,
    required String visibility,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'pedagogicalReport',
        method: 'createReport',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'pedagogicalReport',
          methodName: 'createReport',
          parameters: _i1.testObjectToJson({
            'childId': childId,
            'reportDate': reportDate,
            'title': title,
            'summary': summary,
            'body': body,
            'status': status,
            'visibility': visibility,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i27.PedagogicalReport>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i27.PedagogicalReport> updateReport(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i6.UuidValue reportId,
    DateTime? reportDate,
    String? title,
    String? summary,
    String? body,
    String? status,
    String? visibility,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'pedagogicalReport',
        method: 'updateReport',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'pedagogicalReport',
          methodName: 'updateReport',
          parameters: _i1.testObjectToJson({
            'reportId': reportId,
            'reportDate': reportDate,
            'title': title,
            'summary': summary,
            'body': body,
            'status': status,
            'visibility': visibility,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i27.PedagogicalReport>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _TimeTrackingEndpoint {
  _TimeTrackingEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i28.TimeEntry> checkIn(
    _i1.TestSessionBuilder sessionBuilder, {
    String? notes,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'timeTracking',
        method: 'checkIn',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'timeTracking',
          methodName: 'checkIn',
          parameters: _i1.testObjectToJson({'notes': notes}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i28.TimeEntry>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i28.TimeEntry> checkOut(
    _i1.TestSessionBuilder sessionBuilder, {
    String? notes,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'timeTracking',
        method: 'checkOut',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'timeTracking',
          methodName: 'checkOut',
          parameters: _i1.testObjectToJson({'notes': notes}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i28.TimeEntry>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i28.TimeEntry>> myEntries(
    _i1.TestSessionBuilder sessionBuilder, {
    required int page,
    required int pageSize,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'timeTracking',
        method: 'myEntries',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'timeTracking',
          methodName: 'myEntries',
          parameters: _i1.testObjectToJson({
            'page': page,
            'pageSize': pageSize,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i28.TimeEntry>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i28.TimeEntry>> listEntries(
    _i1.TestSessionBuilder sessionBuilder, {
    _i6.UuidValue? userId,
    DateTime? from,
    DateTime? to,
    required int page,
    required int pageSize,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'timeTracking',
        method: 'listEntries',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'timeTracking',
          methodName: 'listEntries',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'from': from,
            'to': to,
            'page': page,
            'pageSize': pageSize,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i28.TimeEntry>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i28.TimeEntry> getEntry(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i6.UuidValue entryId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'timeTracking',
        method: 'getEntry',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'timeTracking',
          methodName: 'getEntry',
          parameters: _i1.testObjectToJson({'entryId': entryId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i28.TimeEntry>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i28.TimeEntry> correctEntry(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i6.UuidValue targetEntryId,
    required String correctedEntryType,
    required String correctionReason,
    String? notes,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'timeTracking',
        method: 'correctEntry',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'timeTracking',
          methodName: 'correctEntry',
          parameters: _i1.testObjectToJson({
            'targetEntryId': targetEntryId,
            'correctedEntryType': correctedEntryType,
            'correctionReason': correctionReason,
            'notes': notes,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i28.TimeEntry>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}
