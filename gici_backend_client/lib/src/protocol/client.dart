/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:gici_backend_client/src/protocol/auth_session.dart' as _i3;
import 'package:gici_backend_client/src/protocol/chat_conversation.dart' as _i4;
import 'package:uuid/uuid_value.dart' as _i5;
import 'package:gici_backend_client/src/protocol/chat_message.dart' as _i6;
import 'package:gici_backend_client/src/protocol/child.dart' as _i7;
import 'package:gici_backend_client/src/protocol/child_profile_overview.dart'
    as _i8;
import 'package:gici_backend_client/src/protocol/child_timeline_item.dart'
    as _i9;
import 'package:gici_backend_client/src/protocol/classroom.dart' as _i10;
import 'package:gici_backend_client/src/protocol/classroom_assignment.dart'
    as _i11;
import 'package:gici_backend_client/src/protocol/dashboard_summary.dart'
    as _i12;
import 'package:gici_backend_client/src/protocol/data_change_request.dart'
    as _i13;
import 'package:gici_backend_client/src/protocol/organization_document.dart'
    as _i14;
import 'package:gici_backend_client/src/protocol/child_document.dart' as _i15;
import 'package:gici_backend_client/src/protocol/user_onboarding_state.dart'
    as _i16;
import 'package:gici_backend_client/src/protocol/organization.dart' as _i17;
import 'package:gici_backend_client/src/protocol/menu_entry.dart' as _i18;
import 'package:gici_backend_client/src/protocol/gallery.dart' as _i19;
import 'package:gici_backend_client/src/protocol/gallery_item.dart' as _i20;
import 'package:gici_backend_client/src/protocol/meal_entry.dart' as _i21;
import 'package:gici_backend_client/src/protocol/nap_entry.dart' as _i22;
import 'package:gici_backend_client/src/protocol/bowel_movement_entry.dart'
    as _i23;
import 'package:gici_backend_client/src/protocol/child_daily_habits.dart'
    as _i24;
import 'package:gici_backend_client/src/protocol/push_device_token.dart'
    as _i25;
import 'package:gici_backend_client/src/protocol/notification_record.dart'
    as _i26;
import 'package:gici_backend_client/src/protocol/pedagogical_report.dart'
    as _i27;
import 'package:gici_backend_client/src/protocol/app_user.dart' as _i28;
import 'package:gici_backend_client/src/protocol/time_entry.dart' as _i29;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i30;
import 'protocol.dart' as _i31;

/// {@category Endpoint}
class EndpointAuth extends _i1.EndpointRef {
  EndpointAuth(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'auth';

  /// Sign in with email and password.
  /// Returns [AuthSession] with user info and creates a session token
  /// that the client will automatically include in subsequent requests.
  _i2.Future<_i3.AuthSession> signInWithEmailPassword({
    required String email,
    required String password,
  }) =>
      caller.callServerEndpoint<_i3.AuthSession>(
        'auth',
        'signInWithEmailPassword',
        {
          'email': email,
          'password': password,
        },
      );

  /// Get current authenticated user's session info.
  /// Uses the session token to identify the user — no parameters needed.
  _i2.Future<_i3.AuthSession?> me() =>
      caller.callServerEndpoint<_i3.AuthSession?>(
        'auth',
        'me',
        {},
      );

  /// Request a password reset code sent to the user's email.
  _i2.Future<bool> requestPasswordReset({required String email}) =>
      caller.callServerEndpoint<bool>(
        'auth',
        'requestPasswordReset',
        {'email': email},
      );

  /// Reset password using a verification code.
  _i2.Future<bool> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  }) =>
      caller.callServerEndpoint<bool>(
        'auth',
        'resetPassword',
        {
          'email': email,
          'code': code,
          'newPassword': newPassword,
        },
      );
}

/// {@category Endpoint}
class EndpointBootstrap extends _i1.EndpointRef {
  EndpointBootstrap(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'bootstrap';

  _i2.Future<String> seedDemoData({required String bootstrapKey}) =>
      caller.callServerEndpoint<String>(
        'bootstrap',
        'seedDemoData',
        {'bootstrapKey': bootstrapKey},
      );
}

/// {@category Endpoint}
class EndpointChat extends _i1.EndpointRef {
  EndpointChat(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'chat';

  _i2.Future<List<_i4.ChatConversation>> listConversations({
    required int page,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<List<_i4.ChatConversation>>(
        'chat',
        'listConversations',
        {
          'page': page,
          'pageSize': pageSize,
        },
      );

  _i2.Future<_i4.ChatConversation> getConversation(
          {required _i5.UuidValue conversationId}) =>
      caller.callServerEndpoint<_i4.ChatConversation>(
        'chat',
        'getConversation',
        {'conversationId': conversationId},
      );

  _i2.Future<_i4.ChatConversation> createConversation({
    required String conversationType,
    String? title,
    _i5.UuidValue? relatedChildId,
    _i5.UuidValue? relatedClassroomId,
    required List<_i5.UuidValue> participantUserIds,
  }) =>
      caller.callServerEndpoint<_i4.ChatConversation>(
        'chat',
        'createConversation',
        {
          'conversationType': conversationType,
          'title': title,
          'relatedChildId': relatedChildId,
          'relatedClassroomId': relatedClassroomId,
          'participantUserIds': participantUserIds,
        },
      );

  _i2.Future<_i6.ChatMessage> sendMessage({
    required _i5.UuidValue conversationId,
    required String content,
  }) =>
      caller.callServerEndpoint<_i6.ChatMessage>(
        'chat',
        'sendMessage',
        {
          'conversationId': conversationId,
          'content': content,
        },
      );

  _i2.Future<List<_i6.ChatMessage>> listMessages({
    required _i5.UuidValue conversationId,
    required int page,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<List<_i6.ChatMessage>>(
        'chat',
        'listMessages',
        {
          'conversationId': conversationId,
          'page': page,
          'pageSize': pageSize,
        },
      );

  _i2.Future<void> markConversationRead({
    required _i5.UuidValue conversationId,
    _i5.UuidValue? lastReadMessageId,
  }) =>
      caller.callServerEndpoint<void>(
        'chat',
        'markConversationRead',
        {
          'conversationId': conversationId,
          'lastReadMessageId': lastReadMessageId,
        },
      );

  _i2.Future<Map<String, int>> unreadCounts() =>
      caller.callServerEndpoint<Map<String, int>>(
        'chat',
        'unreadCounts',
        {},
      );
}

/// {@category Endpoint}
class EndpointChild extends _i1.EndpointRef {
  EndpointChild(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'child';

  _i2.Future<List<_i7.Child>> listChildren({
    required int page,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<List<_i7.Child>>(
        'child',
        'listChildren',
        {
          'page': page,
          'pageSize': pageSize,
        },
      );

  _i2.Future<_i7.Child> createChild({
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
  }) =>
      caller.callServerEndpoint<_i7.Child>(
        'child',
        'createChild',
        {
          'firstName': firstName,
          'lastName': lastName,
          'dateOfBirth': dateOfBirth,
        },
      );

  _i2.Future<_i7.Child> getChild({required _i5.UuidValue childId}) =>
      caller.callServerEndpoint<_i7.Child>(
        'child',
        'getChild',
        {'childId': childId},
      );

  _i2.Future<_i7.Child> updateChild({
    required _i5.UuidValue childId,
    String? firstName,
    String? lastName,
    DateTime? dateOfBirth,
    String? status,
    String? medicalNotes,
    String? dietaryNotes,
    String? allergies,
  }) =>
      caller.callServerEndpoint<_i7.Child>(
        'child',
        'updateChild',
        {
          'childId': childId,
          'firstName': firstName,
          'lastName': lastName,
          'dateOfBirth': dateOfBirth,
          'status': status,
          'medicalNotes': medicalNotes,
          'dietaryNotes': dietaryNotes,
          'allergies': allergies,
        },
      );

  _i2.Future<_i8.ChildProfileOverview> getChildProfileOverview(
          {required _i5.UuidValue childId}) =>
      caller.callServerEndpoint<_i8.ChildProfileOverview>(
        'child',
        'getChildProfileOverview',
        {'childId': childId},
      );
}

/// {@category Endpoint}
class EndpointChildTimeline extends _i1.EndpointRef {
  EndpointChildTimeline(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'childTimeline';

  _i2.Future<List<_i9.ChildTimelineItem>> getChildTimeline({
    required _i5.UuidValue childId,
    required int page,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<List<_i9.ChildTimelineItem>>(
        'childTimeline',
        'getChildTimeline',
        {
          'childId': childId,
          'page': page,
          'pageSize': pageSize,
        },
      );
}

/// {@category Endpoint}
class EndpointClassroom extends _i1.EndpointRef {
  EndpointClassroom(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'classroom';

  _i2.Future<List<_i10.Classroom>> listClassrooms({
    required int page,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<List<_i10.Classroom>>(
        'classroom',
        'listClassrooms',
        {
          'page': page,
          'pageSize': pageSize,
        },
      );

  _i2.Future<_i10.Classroom> createClassroom({
    required String name,
    String? description,
    int? ageGroupMin,
    int? ageGroupMax,
    required int capacity,
    String? color,
  }) =>
      caller.callServerEndpoint<_i10.Classroom>(
        'classroom',
        'createClassroom',
        {
          'name': name,
          'description': description,
          'ageGroupMin': ageGroupMin,
          'ageGroupMax': ageGroupMax,
          'capacity': capacity,
          'color': color,
        },
      );

  _i2.Future<_i10.Classroom> updateClassroom({
    required _i5.UuidValue classroomId,
    String? name,
    String? description,
    int? ageGroupMin,
    int? ageGroupMax,
    int? capacity,
    String? color,
    String? status,
  }) =>
      caller.callServerEndpoint<_i10.Classroom>(
        'classroom',
        'updateClassroom',
        {
          'classroomId': classroomId,
          'name': name,
          'description': description,
          'ageGroupMin': ageGroupMin,
          'ageGroupMax': ageGroupMax,
          'capacity': capacity,
          'color': color,
          'status': status,
        },
      );

  _i2.Future<_i11.ClassroomAssignment> assignChildToClassroom({
    required _i5.UuidValue classroomId,
    required _i5.UuidValue childId,
  }) =>
      caller.callServerEndpoint<_i11.ClassroomAssignment>(
        'classroom',
        'assignChildToClassroom',
        {
          'classroomId': classroomId,
          'childId': childId,
        },
      );

  _i2.Future<List<_i11.ClassroomAssignment>> listAssignments({
    _i5.UuidValue? classroomId,
    _i5.UuidValue? childId,
    required bool onlyActive,
    required int page,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<List<_i11.ClassroomAssignment>>(
        'classroom',
        'listAssignments',
        {
          'classroomId': classroomId,
          'childId': childId,
          'onlyActive': onlyActive,
          'page': page,
          'pageSize': pageSize,
        },
      );
}

/// {@category Endpoint}
class EndpointDashboard extends _i1.EndpointRef {
  EndpointDashboard(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'dashboard';

  /// Get a summary of key metrics for the dashboard.
  _i2.Future<_i12.DashboardSummary> getSummary() =>
      caller.callServerEndpoint<_i12.DashboardSummary>(
        'dashboard',
        'getSummary',
        {},
      );
}

/// {@category Endpoint}
class EndpointDataChangeRequest extends _i1.EndpointRef {
  EndpointDataChangeRequest(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'dataChangeRequest';

  _i2.Future<_i13.DataChangeRequest> createRequest({
    _i5.UuidValue? targetChildId,
    required String requestType,
    required String requestPayload,
  }) =>
      caller.callServerEndpoint<_i13.DataChangeRequest>(
        'dataChangeRequest',
        'createRequest',
        {
          'targetChildId': targetChildId,
          'requestType': requestType,
          'requestPayload': requestPayload,
        },
      );

  _i2.Future<List<_i13.DataChangeRequest>> myRequests({
    required int page,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<List<_i13.DataChangeRequest>>(
        'dataChangeRequest',
        'myRequests',
        {
          'page': page,
          'pageSize': pageSize,
        },
      );

  _i2.Future<List<_i13.DataChangeRequest>> listRequestsForReview({
    String? status,
    required int page,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<List<_i13.DataChangeRequest>>(
        'dataChangeRequest',
        'listRequestsForReview',
        {
          'status': status,
          'page': page,
          'pageSize': pageSize,
        },
      );

  _i2.Future<_i13.DataChangeRequest> getRequest(
          {required _i5.UuidValue requestId}) =>
      caller.callServerEndpoint<_i13.DataChangeRequest>(
        'dataChangeRequest',
        'getRequest',
        {'requestId': requestId},
      );

  _i2.Future<_i13.DataChangeRequest> updateRequestStatus({
    required _i5.UuidValue requestId,
    required String status,
    String? resolutionNote,
  }) =>
      caller.callServerEndpoint<_i13.DataChangeRequest>(
        'dataChangeRequest',
        'updateRequestStatus',
        {
          'requestId': requestId,
          'status': status,
          'resolutionNote': resolutionNote,
        },
      );
}

/// {@category Endpoint}
class EndpointDocument extends _i1.EndpointRef {
  EndpointDocument(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'document';

  _i2.Future<List<_i14.OrganizationDocument>> listOrganizationDocuments({
    required int page,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<List<_i14.OrganizationDocument>>(
        'document',
        'listOrganizationDocuments',
        {
          'page': page,
          'pageSize': pageSize,
        },
      );

  _i2.Future<_i14.OrganizationDocument> createOrganizationDocument({
    required String title,
    String? description,
    required String visibility,
    required String originalName,
    required String mimeType,
    required int sizeBytes,
    String? storagePath,
  }) =>
      caller.callServerEndpoint<_i14.OrganizationDocument>(
        'document',
        'createOrganizationDocument',
        {
          'title': title,
          'description': description,
          'visibility': visibility,
          'originalName': originalName,
          'mimeType': mimeType,
          'sizeBytes': sizeBytes,
          'storagePath': storagePath,
        },
      );

  _i2.Future<List<_i15.ChildDocument>> listChildDocuments({
    required _i5.UuidValue childId,
    required int page,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<List<_i15.ChildDocument>>(
        'document',
        'listChildDocuments',
        {
          'childId': childId,
          'page': page,
          'pageSize': pageSize,
        },
      );

  _i2.Future<_i15.ChildDocument> createChildDocument({
    required _i5.UuidValue childId,
    required String title,
    String? description,
    required bool visibleToGuardians,
    required String originalName,
    required String mimeType,
    required int sizeBytes,
    String? storagePath,
  }) =>
      caller.callServerEndpoint<_i15.ChildDocument>(
        'document',
        'createChildDocument',
        {
          'childId': childId,
          'title': title,
          'description': description,
          'visibleToGuardians': visibleToGuardians,
          'originalName': originalName,
          'mimeType': mimeType,
          'sizeBytes': sizeBytes,
          'storagePath': storagePath,
        },
      );

  _i2.Future<String> resolveFileDownloadUrl(
          {required _i5.UuidValue fileAssetId}) =>
      caller.callServerEndpoint<String>(
        'document',
        'resolveFileDownloadUrl',
        {'fileAssetId': fileAssetId},
      );
}

/// {@category Endpoint}
class EndpointExperience extends _i1.EndpointRef {
  EndpointExperience(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'experience';

  _i2.Future<_i16.UserOnboardingState?> getOnboardingState() =>
      caller.callServerEndpoint<_i16.UserOnboardingState?>(
        'experience',
        'getOnboardingState',
        {},
      );

  _i2.Future<_i16.UserOnboardingState> completeOnboarding(
          {required bool acceptTerms}) =>
      caller.callServerEndpoint<_i16.UserOnboardingState>(
        'experience',
        'completeOnboarding',
        {'acceptTerms': acceptTerms},
      );

  _i2.Future<_i17.Organization> getCenterInfo() =>
      caller.callServerEndpoint<_i17.Organization>(
        'experience',
        'getCenterInfo',
        {},
      );

  _i2.Future<List<_i18.MenuEntry>> listMenuEntries({
    DateTime? from,
    DateTime? to,
    required int page,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<List<_i18.MenuEntry>>(
        'experience',
        'listMenuEntries',
        {
          'from': from,
          'to': to,
          'page': page,
          'pageSize': pageSize,
        },
      );

  _i2.Future<_i18.MenuEntry?> getMenuEntry(
          {required _i5.UuidValue menuEntryId}) =>
      caller.callServerEndpoint<_i18.MenuEntry?>(
        'experience',
        'getMenuEntry',
        {'menuEntryId': menuEntryId},
      );

  _i2.Future<_i18.MenuEntry> createMenuEntry({
    required DateTime menuDate,
    required String mealType,
    required String title,
    String? description,
    _i5.UuidValue? classroomId,
  }) =>
      caller.callServerEndpoint<_i18.MenuEntry>(
        'experience',
        'createMenuEntry',
        {
          'menuDate': menuDate,
          'mealType': mealType,
          'title': title,
          'description': description,
          'classroomId': classroomId,
        },
      );

  _i2.Future<_i18.MenuEntry> updateMenuEntry({
    required _i5.UuidValue menuEntryId,
    DateTime? menuDate,
    String? mealType,
    String? title,
    String? description,
    _i5.UuidValue? classroomId,
  }) =>
      caller.callServerEndpoint<_i18.MenuEntry>(
        'experience',
        'updateMenuEntry',
        {
          'menuEntryId': menuEntryId,
          'menuDate': menuDate,
          'mealType': mealType,
          'title': title,
          'description': description,
          'classroomId': classroomId,
        },
      );
}

/// {@category Endpoint}
class EndpointGallery extends _i1.EndpointRef {
  EndpointGallery(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'gallery';

  _i2.Future<List<_i19.Gallery>> listGalleries({
    required int page,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<List<_i19.Gallery>>(
        'gallery',
        'listGalleries',
        {
          'page': page,
          'pageSize': pageSize,
        },
      );

  _i2.Future<_i19.Gallery> getGallery({required _i5.UuidValue galleryId}) =>
      caller.callServerEndpoint<_i19.Gallery>(
        'gallery',
        'getGallery',
        {'galleryId': galleryId},
      );

  _i2.Future<_i19.Gallery> createGallery({
    required String title,
    String? description,
    required String audienceType,
    _i5.UuidValue? audienceClassroomId,
    _i5.UuidValue? audienceChildId,
  }) =>
      caller.callServerEndpoint<_i19.Gallery>(
        'gallery',
        'createGallery',
        {
          'title': title,
          'description': description,
          'audienceType': audienceType,
          'audienceClassroomId': audienceClassroomId,
          'audienceChildId': audienceChildId,
        },
      );

  _i2.Future<_i19.Gallery> updateGallery({
    required _i5.UuidValue galleryId,
    String? title,
    String? description,
    String? audienceType,
    _i5.UuidValue? audienceClassroomId,
    _i5.UuidValue? audienceChildId,
    bool? isPublished,
  }) =>
      caller.callServerEndpoint<_i19.Gallery>(
        'gallery',
        'updateGallery',
        {
          'galleryId': galleryId,
          'title': title,
          'description': description,
          'audienceType': audienceType,
          'audienceClassroomId': audienceClassroomId,
          'audienceChildId': audienceChildId,
          'isPublished': isPublished,
        },
      );

  _i2.Future<_i20.GalleryItem> addGalleryItem({
    required _i5.UuidValue galleryId,
    required _i5.UuidValue fileAssetId,
    String? caption,
    int? sortOrder,
  }) =>
      caller.callServerEndpoint<_i20.GalleryItem>(
        'gallery',
        'addGalleryItem',
        {
          'galleryId': galleryId,
          'fileAssetId': fileAssetId,
          'caption': caption,
          'sortOrder': sortOrder,
        },
      );

  _i2.Future<List<_i20.GalleryItem>> listGalleryItems({
    required _i5.UuidValue galleryId,
    required int page,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<List<_i20.GalleryItem>>(
        'gallery',
        'listGalleryItems',
        {
          'galleryId': galleryId,
          'page': page,
          'pageSize': pageSize,
        },
      );
}

/// {@category Endpoint}
class EndpointHabit extends _i1.EndpointRef {
  EndpointHabit(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'habit';

  _i2.Future<List<_i21.MealEntry>> listMealsByChild({
    required _i5.UuidValue childId,
    required int page,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<List<_i21.MealEntry>>(
        'habit',
        'listMealsByChild',
        {
          'childId': childId,
          'page': page,
          'pageSize': pageSize,
        },
      );

  _i2.Future<_i21.MealEntry> createMealEntry({
    required _i5.UuidValue childId,
    required String mealType,
    required String consumptionLevel,
    DateTime? recordedAt,
    String? menuItems,
    String? notes,
  }) =>
      caller.callServerEndpoint<_i21.MealEntry>(
        'habit',
        'createMealEntry',
        {
          'childId': childId,
          'mealType': mealType,
          'consumptionLevel': consumptionLevel,
          'recordedAt': recordedAt,
          'menuItems': menuItems,
          'notes': notes,
        },
      );

  _i2.Future<_i21.MealEntry> updateMealEntry({
    required _i5.UuidValue mealEntryId,
    String? mealType,
    String? consumptionLevel,
    DateTime? recordedAt,
    String? menuItems,
    String? notes,
  }) =>
      caller.callServerEndpoint<_i21.MealEntry>(
        'habit',
        'updateMealEntry',
        {
          'mealEntryId': mealEntryId,
          'mealType': mealType,
          'consumptionLevel': consumptionLevel,
          'recordedAt': recordedAt,
          'menuItems': menuItems,
          'notes': notes,
        },
      );

  _i2.Future<List<_i22.NapEntry>> listNapsByChild({
    required _i5.UuidValue childId,
    required int page,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<List<_i22.NapEntry>>(
        'habit',
        'listNapsByChild',
        {
          'childId': childId,
          'page': page,
          'pageSize': pageSize,
        },
      );

  _i2.Future<_i22.NapEntry> createNapEntry({
    required _i5.UuidValue childId,
    required DateTime startedAt,
    DateTime? endedAt,
    int? durationMinutes,
    String? sleepQuality,
    String? notes,
  }) =>
      caller.callServerEndpoint<_i22.NapEntry>(
        'habit',
        'createNapEntry',
        {
          'childId': childId,
          'startedAt': startedAt,
          'endedAt': endedAt,
          'durationMinutes': durationMinutes,
          'sleepQuality': sleepQuality,
          'notes': notes,
        },
      );

  _i2.Future<_i22.NapEntry> updateNapEntry({
    required _i5.UuidValue napEntryId,
    DateTime? startedAt,
    DateTime? endedAt,
    int? durationMinutes,
    String? sleepQuality,
    String? notes,
  }) =>
      caller.callServerEndpoint<_i22.NapEntry>(
        'habit',
        'updateNapEntry',
        {
          'napEntryId': napEntryId,
          'startedAt': startedAt,
          'endedAt': endedAt,
          'durationMinutes': durationMinutes,
          'sleepQuality': sleepQuality,
          'notes': notes,
        },
      );

  _i2.Future<List<_i23.BowelMovementEntry>> listBowelMovementsByChild({
    required _i5.UuidValue childId,
    required int page,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<List<_i23.BowelMovementEntry>>(
        'habit',
        'listBowelMovementsByChild',
        {
          'childId': childId,
          'page': page,
          'pageSize': pageSize,
        },
      );

  _i2.Future<_i23.BowelMovementEntry> createBowelMovementEntry({
    required _i5.UuidValue childId,
    DateTime? eventAt,
    required String eventType,
    String? consistency,
    String? notes,
  }) =>
      caller.callServerEndpoint<_i23.BowelMovementEntry>(
        'habit',
        'createBowelMovementEntry',
        {
          'childId': childId,
          'eventAt': eventAt,
          'eventType': eventType,
          'consistency': consistency,
          'notes': notes,
        },
      );

  _i2.Future<_i23.BowelMovementEntry> updateBowelMovementEntry({
    required _i5.UuidValue entryId,
    DateTime? eventAt,
    String? eventType,
    String? consistency,
    String? notes,
  }) =>
      caller.callServerEndpoint<_i23.BowelMovementEntry>(
        'habit',
        'updateBowelMovementEntry',
        {
          'entryId': entryId,
          'eventAt': eventAt,
          'eventType': eventType,
          'consistency': consistency,
          'notes': notes,
        },
      );

  _i2.Future<_i24.ChildDailyHabits> getChildDailyHabits({
    required _i5.UuidValue childId,
    required DateTime day,
  }) =>
      caller.callServerEndpoint<_i24.ChildDailyHabits>(
        'habit',
        'getChildDailyHabits',
        {
          'childId': childId,
          'day': day,
        },
      );
}

/// {@category Endpoint}
class EndpointNotification extends _i1.EndpointRef {
  EndpointNotification(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'notification';

  _i2.Future<_i25.PushDeviceToken> registerDeviceToken({
    required String token,
    required String platform,
    String? deviceId,
    String? deviceModel,
    String? appVersion,
  }) =>
      caller.callServerEndpoint<_i25.PushDeviceToken>(
        'notification',
        'registerDeviceToken',
        {
          'token': token,
          'platform': platform,
          'deviceId': deviceId,
          'deviceModel': deviceModel,
          'appVersion': appVersion,
        },
      );

  _i2.Future<void> removeDeviceToken({required String token}) =>
      caller.callServerEndpoint<void>(
        'notification',
        'removeDeviceToken',
        {'token': token},
      );

  _i2.Future<List<_i26.NotificationRecord>> myNotifications({
    required int page,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<List<_i26.NotificationRecord>>(
        'notification',
        'myNotifications',
        {
          'page': page,
          'pageSize': pageSize,
        },
      );

  _i2.Future<void> markNotificationRead(
          {required _i5.UuidValue notificationId}) =>
      caller.callServerEndpoint<void>(
        'notification',
        'markNotificationRead',
        {'notificationId': notificationId},
      );

  _i2.Future<int> createSegmentedNotification({
    required String title,
    required String body,
    required String category,
    required String targetScope,
    _i5.UuidValue? targetClassroomId,
    _i5.UuidValue? targetChildId,
    _i5.UuidValue? targetUserId,
  }) =>
      caller.callServerEndpoint<int>(
        'notification',
        'createSegmentedNotification',
        {
          'title': title,
          'body': body,
          'category': category,
          'targetScope': targetScope,
          'targetClassroomId': targetClassroomId,
          'targetChildId': targetChildId,
          'targetUserId': targetUserId,
        },
      );
}

/// {@category Endpoint}
class EndpointOrganization extends _i1.EndpointRef {
  EndpointOrganization(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'organization';

  _i2.Future<List<_i17.Organization>> listOrganizations({
    required int page,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<List<_i17.Organization>>(
        'organization',
        'listOrganizations',
        {
          'page': page,
          'pageSize': pageSize,
        },
      );

  _i2.Future<_i17.Organization?> getOrganization(
          {required _i5.UuidValue organizationId}) =>
      caller.callServerEndpoint<_i17.Organization?>(
        'organization',
        'getOrganization',
        {'organizationId': organizationId},
      );

  _i2.Future<_i17.Organization> createOrganization({
    required String name,
    required String slug,
    required String contactEmail,
  }) =>
      caller.callServerEndpoint<_i17.Organization>(
        'organization',
        'createOrganization',
        {
          'name': name,
          'slug': slug,
          'contactEmail': contactEmail,
        },
      );
}

/// {@category Endpoint}
class EndpointPedagogicalReport extends _i1.EndpointRef {
  EndpointPedagogicalReport(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'pedagogicalReport';

  _i2.Future<List<_i27.PedagogicalReport>> listReportsByChild({
    required _i5.UuidValue childId,
    required int page,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<List<_i27.PedagogicalReport>>(
        'pedagogicalReport',
        'listReportsByChild',
        {
          'childId': childId,
          'page': page,
          'pageSize': pageSize,
        },
      );

  _i2.Future<_i27.PedagogicalReport> getReport(
          {required _i5.UuidValue reportId}) =>
      caller.callServerEndpoint<_i27.PedagogicalReport>(
        'pedagogicalReport',
        'getReport',
        {'reportId': reportId},
      );

  _i2.Future<_i27.PedagogicalReport> createReport({
    required _i5.UuidValue childId,
    required DateTime reportDate,
    required String title,
    required String summary,
    required String body,
    required String status,
    required String visibility,
  }) =>
      caller.callServerEndpoint<_i27.PedagogicalReport>(
        'pedagogicalReport',
        'createReport',
        {
          'childId': childId,
          'reportDate': reportDate,
          'title': title,
          'summary': summary,
          'body': body,
          'status': status,
          'visibility': visibility,
        },
      );

  _i2.Future<_i27.PedagogicalReport> updateReport({
    required _i5.UuidValue reportId,
    DateTime? reportDate,
    String? title,
    String? summary,
    String? body,
    String? status,
    String? visibility,
  }) =>
      caller.callServerEndpoint<_i27.PedagogicalReport>(
        'pedagogicalReport',
        'updateReport',
        {
          'reportId': reportId,
          'reportDate': reportDate,
          'title': title,
          'summary': summary,
          'body': body,
          'status': status,
          'visibility': visibility,
        },
      );
}

/// {@category Endpoint}
class EndpointStaff extends _i1.EndpointRef {
  EndpointStaff(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'staff';

  /// List staff members (staff + organization_admin roles).
  _i2.Future<List<_i28.AppUser>> listStaff({
    required int page,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<List<_i28.AppUser>>(
        'staff',
        'listStaff',
        {
          'page': page,
          'pageSize': pageSize,
        },
      );

  /// List guardian users.
  _i2.Future<List<_i28.AppUser>> listGuardians({
    required int page,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<List<_i28.AppUser>>(
        'staff',
        'listGuardians',
        {
          'page': page,
          'pageSize': pageSize,
        },
      );

  /// Create a new staff or admin user.
  _i2.Future<_i28.AppUser> createStaffUser({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String role,
    String? phone,
  }) =>
      caller.callServerEndpoint<_i28.AppUser>(
        'staff',
        'createStaffUser',
        {
          'email': email,
          'password': password,
          'firstName': firstName,
          'lastName': lastName,
          'role': role,
          'phone': phone,
        },
      );

  /// Update a staff user's details.
  _i2.Future<_i28.AppUser> updateStaffUser({
    required _i5.UuidValue userId,
    String? firstName,
    String? lastName,
    String? phone,
    String? role,
    bool? isActive,
  }) =>
      caller.callServerEndpoint<_i28.AppUser>(
        'staff',
        'updateStaffUser',
        {
          'userId': userId,
          'firstName': firstName,
          'lastName': lastName,
          'phone': phone,
          'role': role,
          'isActive': isActive,
        },
      );
}

/// {@category Endpoint}
class EndpointTimeTracking extends _i1.EndpointRef {
  EndpointTimeTracking(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'timeTracking';

  _i2.Future<_i29.TimeEntry> checkIn({String? notes}) =>
      caller.callServerEndpoint<_i29.TimeEntry>(
        'timeTracking',
        'checkIn',
        {'notes': notes},
      );

  _i2.Future<_i29.TimeEntry> checkOut({String? notes}) =>
      caller.callServerEndpoint<_i29.TimeEntry>(
        'timeTracking',
        'checkOut',
        {'notes': notes},
      );

  _i2.Future<List<_i29.TimeEntry>> myEntries({
    required int page,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<List<_i29.TimeEntry>>(
        'timeTracking',
        'myEntries',
        {
          'page': page,
          'pageSize': pageSize,
        },
      );

  _i2.Future<List<_i29.TimeEntry>> listEntries({
    _i5.UuidValue? userId,
    DateTime? from,
    DateTime? to,
    required int page,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<List<_i29.TimeEntry>>(
        'timeTracking',
        'listEntries',
        {
          'userId': userId,
          'from': from,
          'to': to,
          'page': page,
          'pageSize': pageSize,
        },
      );

  _i2.Future<_i29.TimeEntry> getEntry({required _i5.UuidValue entryId}) =>
      caller.callServerEndpoint<_i29.TimeEntry>(
        'timeTracking',
        'getEntry',
        {'entryId': entryId},
      );

  _i2.Future<_i29.TimeEntry> correctEntry({
    required _i5.UuidValue targetEntryId,
    required String correctedEntryType,
    required String correctionReason,
    String? notes,
  }) =>
      caller.callServerEndpoint<_i29.TimeEntry>(
        'timeTracking',
        'correctEntry',
        {
          'targetEntryId': targetEntryId,
          'correctedEntryType': correctedEntryType,
          'correctionReason': correctionReason,
          'notes': notes,
        },
      );

  /// Export time entries as CSV string for Spanish labor law compliance
  /// (Registro diario de jornada).
  _i2.Future<String> exportTimeEntries({
    required DateTime from,
    required DateTime to,
    _i5.UuidValue? userId,
  }) =>
      caller.callServerEndpoint<String>(
        'timeTracking',
        'exportTimeEntries',
        {
          'from': from,
          'to': to,
          'userId': userId,
        },
      );
}

class Modules {
  Modules(Client client) {
    auth = _i30.Caller(client);
  }

  late final _i30.Caller auth;
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )? onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
          host,
          _i31.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
          onFailedCall: onFailedCall,
          onSucceededCall: onSucceededCall,
          disconnectStreamsOnLostInternetConnection:
              disconnectStreamsOnLostInternetConnection,
        ) {
    auth = EndpointAuth(this);
    bootstrap = EndpointBootstrap(this);
    chat = EndpointChat(this);
    child = EndpointChild(this);
    childTimeline = EndpointChildTimeline(this);
    classroom = EndpointClassroom(this);
    dashboard = EndpointDashboard(this);
    dataChangeRequest = EndpointDataChangeRequest(this);
    document = EndpointDocument(this);
    experience = EndpointExperience(this);
    gallery = EndpointGallery(this);
    habit = EndpointHabit(this);
    notification = EndpointNotification(this);
    organization = EndpointOrganization(this);
    pedagogicalReport = EndpointPedagogicalReport(this);
    staff = EndpointStaff(this);
    timeTracking = EndpointTimeTracking(this);
    modules = Modules(this);
  }

  late final EndpointAuth auth;

  late final EndpointBootstrap bootstrap;

  late final EndpointChat chat;

  late final EndpointChild child;

  late final EndpointChildTimeline childTimeline;

  late final EndpointClassroom classroom;

  late final EndpointDashboard dashboard;

  late final EndpointDataChangeRequest dataChangeRequest;

  late final EndpointDocument document;

  late final EndpointExperience experience;

  late final EndpointGallery gallery;

  late final EndpointHabit habit;

  late final EndpointNotification notification;

  late final EndpointOrganization organization;

  late final EndpointPedagogicalReport pedagogicalReport;

  late final EndpointStaff staff;

  late final EndpointTimeTracking timeTracking;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'auth': auth,
        'bootstrap': bootstrap,
        'chat': chat,
        'child': child,
        'childTimeline': childTimeline,
        'classroom': classroom,
        'dashboard': dashboard,
        'dataChangeRequest': dataChangeRequest,
        'document': document,
        'experience': experience,
        'gallery': gallery,
        'habit': habit,
        'notification': notification,
        'organization': organization,
        'pedagogicalReport': pedagogicalReport,
        'staff': staff,
        'timeTracking': timeTracking,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup =>
      {'auth': modules.auth};
}
